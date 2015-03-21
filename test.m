% path = 'orbiicon.jpg';
path = '../data/img02.jpg';
%path = 'test.jpg';

sigma     = 2;
threshold = 0.03;
rhoRes    = 2;
thetaRes  = pi/180;
nLines    = 20;

img = imread(path);
imshow(img);
pause;

[Im, Io, Ix, Iy] = myEdgeFilter(img, sigma);
H = myHoughTransform(Im, threshold, rhoRes, thetaRes);
[lineRho, lineTheta] = myHoughLines(H, rhoRes, thetaRes, nLines);

% gaussKernel = fspecial('gaussian', [3 3], 2);
% smooth = imfilter(img, gaussKernel, 'replicate');
% sobelKernel = fspecial('sobel');
% sobx = imfilter(smooth, sobelKernel, 'replicate');
% soby = imfilter(smooth, sobelKernel', 'replicate');

% subplot(1,2,1), subimage(Im)
% subplot(1,2,2), subimage(Io)

%gaussKernel = fspecial('gaussian', 3, 1);
%img1 = myImageFilter(img, gaussKernel);  
%img1 = imfilter(img,gaussKernel,'replicate');

%imshow(img1);