# ImageFilters

Image filtering app in swift. Implemented basic colour filters.

## Creating a filter on your image is a 4 step process

1. Create a **CIContext** object (with default options) -> manages rendering for you
2. Instantiate a **CIFilter** object (representing the filter to apply) -> takes input image and returns output image.
3. Create a CIImage object representing the image to be processed, and provide it as the input image parameter to the filter. 
4. Get a CIImage object representing the filter’s output
5. Render the output image to a Core Graphics image that you can display or save to a file.


## Points to take care.
1. Contexts are heavyweight objects, so if you do create one, do so as early as possible, and reuse it each time you need to process images.
2. CIImage object describes how to produce an image (instead of containing image data)
3. Core Image merely identifies and stores the steps needed to execute the filter. Those steps are performed only when you request that the image be rendered for display or output.
