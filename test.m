path = '../data/img02.jpg';
%path = 'test.jpg';
img = imread(path);
imshow(img);
pause;

gaussKernel = [0.006 0.061 0.242 0.383 0.242 0.061 0.006];
%gaussKernel = [1 0 0; 0 1 0; 0 0 1];
img1 = myImageFilter(img, gaussKernel);
%img1 = imfilter(img,gaussKernel,'replicate');
imshow(img1);
pause;

gaussKernel = gaussKernel';
img2 = myImageFilter(img1, gaussKernel);
imshow(img2);