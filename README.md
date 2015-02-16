# pair_images
Resizes and pairs images from the command line with imagemagick

It resizes images to a max size given as the first param, eg.: ruby pair_images.rb 1024
and stitches the images in pairs currently goes in file name order, and outputs the results into a new folder.

(Perfect for auction images, eg. t-shirt photo front + back to be in one image)

- Runs on OSX
- Requires imagemagick
- Requires fileutils
