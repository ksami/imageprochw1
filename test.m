%path = '../data/img02.jpg';
path = 'test.jpg';
img = imread(path);
imshow(img);
pause;

gaussKernel = fspecial('gaussian', 3, 1);
img1 = myImageFilter(img, gaussKernel);
%img1 = imfilter(img,gaussKernel,'replicate');

imshow(img1);
pause;