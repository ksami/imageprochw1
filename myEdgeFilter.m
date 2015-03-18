function [Im Io Ix Iy] = myEdgeFilter(img, sigma)
% [Im Io Ix Iy] = myEdgeFilter(img, sigma)
% Canny Edge Detector
% Takes in img and sigma for Gaussian filter,
% outputs Im, edge magnitude image
% Io, edge orientation image
% Ix, Iy, edge filter responses in x, y directions

% Smooth image using Gaussian filter %
gaussKernel = fspecial('gaussian', [3 3], sigma);
smoothImg = myImageFilter(img, gaussKernel);

% Find image gradient in x, y directions %
ySobelKernel = fspecial('sobel');
xSobelKernel = ySobelKernel';

Ix = myImageFilter(smoothImg, xSobelKernel);
Iy = myImageFilter(smoothImg, ySobelKernel);
Ix = im2double(Ix);
Iy = im2double(Iy);
% imshow(Ix); pause;

% Find direction and magnitude of gradient for each pixel %
[row, col] = size(smoothImg);
Im = zeros([row col]);
Io = zeros([row col]);

for i=1:row
    for j=1:col
        Im(i,j) = sqrt( (Ix(i,j)^2) + (Iy(i,j)^2) );
        if(Iy(i,j) == 0)
            Io(i,j) = 0;
        else
            Io(i,j) = atan( abs(Ix(i,j)) / abs(Iy(i,j)) );
        end
    end
end
imshow(Ix);
pause;
imshow(Iy);
pause;

% Non-maximum Suppression %
for i=1:row
    for j=1:col
        
        %for each pixel in edge magnitude Im(i,j)
        stepRow = sin(Io(i,j));  %0<step<1
        stepCol = cos(Io(i,j));
        
        %find an interpolated pixel val
        magStep = sqrt( (stepRow)^2 + (stepCol)^2 );
        
        %boundary checking...
        idxRowFlr1 = i+floor(stepRow);
        idxColFlr1 = j+floor(stepCol);
        idxRowCel1 = i+ceil(stepRow);
        idxColCel1 = j+ceil(stepCol);
        if(idxRowFlr1>row || idxColFlr1>col || idxRowCel1>row || idxColCel1>col)
            continue;
        end
        
        idxRowFlr2 = i-floor(stepRow);
        idxColFlr2 = j-floor(stepCol);
        idxRowCel2 = i-ceil(stepRow);
        idxColCel2 = j-ceil(stepCol);
        if(idxRowFlr2<1 || idxColFlr2<1 || idxRowCel2<1 || idxColCel2<1)
            continue;
        end
        
        interpolatedPx1 = uint8(magStep * ( Im(idxRowFlr1, idxColFlr1) + Im(idxRowCel1, idxColCel1) ));
        interpolatedPx2 = uint8(magStep * ( Im(idxRowFlr2, idxColFlr2) + Im(idxRowCel2, idxColCel2) ));

        %consider neighbours vs Im(i,j)
        if(Im(i,j)<interpolatedPx1 || Im(i,j)<interpolatedPx2)
            Im(i,j) = 0;
        end
        
    end
end

end