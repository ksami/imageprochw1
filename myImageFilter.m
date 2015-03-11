function [img1] = myImageFilter(img0, h)
% [img1] = myImageFilter(img0, h)
% Performs convolution of filter matrix h on the greyscale image img0 
% and returns the result img1

img1 = zeros(size(img0));

%ensure kernel size is odd*odd, else return zeros img1
[r,c] = size(h);
if(mod(r,2)>0)
    return
end
if(mod(c,2)>0)
    return
end

% Create a padded version of img0 %

paddedImg0 = zeros(size(img0)+2);
[row, col] = size(img0);

%copy original img into center of padded leaving border of 1px
for i=2:row+1
    for j=2:col+1
        paddedImg0(i,j) = img0(i-1,j-1);
    end
end

%reflection for 1st and last row
for j=2:col+1
    paddedImg0(1,j) = paddedImg0(3,j);
    paddedImg0(row+2,j) = paddedImg0(row,j);
end

%reflection for 1st and last col
for i=2:row+1
    paddedImg0(i,1) = paddedImg0(i,3);
    paddedImg0(i,col+2) = paddedImg0(i,col);
end
        
%reflection for 4 corner pixels, clockwise
paddedImg0(1,1) = paddedImg0(2,2);
paddedImg0(1,col+2) = paddedImg0(2,col+1);
paddedImg0(row+2,col+2) = paddedImg0(row+1,col+1);
paddedImg0(row+2,1) = paddedImg0(row+1,2);


% Calculate weighted average and assign back to source px %

%flip kernel both horizontally and vertically
kernel = h';

[rowp, colp] = size(paddedImg0);
[rowk, colk] = size(kernel);
windrowk = floor(rowk/2);
windcolk = floor(colk/2);

%iterate through original image size in padded image
for i=1+windrowk:rowp-windrowk
    for j=1+windcolk:colp-windcolk
        
        weightedAvg = 0;
        
        %iterate through window of kernel size in padded image
        for m=i-windrowk:i+windrowk
            for n=j-windcolk:j+windcolk
                weightedAvg = weightedAvg + paddedImg0(m,n);
            end
        end
        
        img1(i,j) = weightedAvg;
                
    end
end


end