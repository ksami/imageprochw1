function [Im Io Ix Iy] = myEdgeFilter(img, sigma)
% [Im Io Ix Iy] = myEdgeFilter(img, sigma)
% Canny Edge Detector
% Takes in img and sigma for Gaussian filter,
% outputs Im, edge magnitude image
% Io, edge orientation image
% Ix, Iy, edge filter responses in x, y directions

% Smooth image using Gaussian filter %
gaussKernel = fspecial('gaussian', 3, sigma);
smoothImg = myImageFilter(img, gaussKernel);

% Find image gradient in x, y directions %
xSobelKernel = fspecial('sobel');
ySobelKernel = xSobelKernel';
Ix = myImageFilter(smoothImg, xSobelKernel);
Iy = myImageFilter(smoothImg, ySobelKernel);

% Find direction and magnitude of gradient for each pixel %
[row, col] = size(smoothImg);
Im = zeros([row col], 'uint8');
Io = zeros([row col], 'uint8');

for i=1:row
    for j=1:col
        Im(i,j) = uint8(sqrt( double( ((Ix(i,j))^2) + ((Iy(i,j))^2) ) ));
        Io(i,j) = uint8(atan( double( abs(Ix(i,j)) / abs(Iy(i,j)) ) ));
    end
end

% Non-maximum Suppression %

end