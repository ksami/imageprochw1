function [img1] = myImageFilter(img0, h)
% [img1] = myImageFilter(img0, h)
% Performs convolution of filter matrix h on the greyscale image img0 
% and returns the result img1

%convert everything to double type
img0 = im2double(img0);
h = im2double(h);


% Output matrix %
img1 = zeros(size(img0));


% Create a padded version of img0 %

%flip kernel both horizontally and vertically
%kernel = h';
kernel = h;

[rowk, colk] = size(kernel);
windrowk = floor(rowk/2);
windcolk = floor(colk/2);

paddedImg0 = padarray(img0, [windrowk windcolk], 'replicate');
[rowp, colp] = size(paddedImg0);


% Calculate weighted average and assign back to source px %

%iterate through padded image giving space for window of kernel size
for i=1+windrowk:rowp-windrowk
    for j=1+windcolk:colp-windcolk
        
        weightedSum = 0;
        
        %iterate through window of kernel size in padded image
        for m=-windrowk:windrowk
            for n=-windcolk:windcolk
                weightedSum = weightedSum + (kernel(m+windrowk+1,n+windcolk+1) * paddedImg0(i+m,j+n));
            end
        end
        
        img1(i-windrowk,j-windcolk) = weightedSum;
                
    end
end

%output uint8
img1 = im2uint8(img1);

end