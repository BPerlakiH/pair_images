require "fastimage"
require "fileutils"

if ARGV.empty?
  puts "Usage: pair_images.rb max_size"
  exit 1
end

max_size = ARGV[0].to_i

puts max_size

if max_size == nil or max_size < 1
	exit "invalid size provided"
end

tmpDir = "tmp/"
outDir = "paired/"

images = Dir["./*"].reject{ |i| File.extname(i).downcase != ".jpg"}

# verify the images are even
if(images.length < 2 or images.length % 2 != 0)
	puts "image count: " + images.length.to_s + " is not even or less than 2"
	exit
end

Dir.mkdir tmpDir unless Dir.exists?(tmpDir)
Dir.mkdir outDir unless Dir.exists?(outDir)


# resize the images
for img in images
	size = FastImage.size(img)
	#if the image is the exact size or smaller just copy it over
	if(size[0] <= max_size || size[1] <= max_size)
		FileUtils.copy(img, targetDir + File.basename(img))
	else
		cmd = 'sips -Z ' + max_size.to_s + ' ' + img + ' --out ' + tmpDir
		puts cmd
		system cmd
	end
end

#stitch the images in pairs
tmpImages = Dir[tmpDir + "/*"]
begin
	pair = tmpImages.pop(2)
	puts pair[0] + " | " + pair[1] + "\n"
	cmd = "convert " + pair[0] + " " + pair[1] + " +append " + outDir + File.basename(pair[0])
	system cmd
end while 0 < tmpImages.length


# clean up the temp dir
FileUtils.rm_r(tmpDir)
