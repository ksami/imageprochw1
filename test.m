path = '../data/img01.jpg';
%path = 'test.jpg';
img = imread(path);
imshow(img);
pause;

[Im, Io, Ix, Iy] = myEdgeFilter(img, 1);
subplot(1,2,1), subimage(Ix)
subplot(1,2,2), subimage(Iy)

%gaussKernel = fspecial('gaussian', 3, 1);
%img1 = myImageFilter(img, gaussKernel);  
%img1 = imfilter(img,gaussKernel,'replicate');

%imshow(img1);