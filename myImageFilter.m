function [img1] = myImageFilter(img0, h)
% [img1] = myImageFilter(img0, h)
% Performs convolution of filter matrix h on the greyscale image img0 
% and returns the result img1


% Output matrix %
img1 = zeros(size(img0), 'uint8');


% Create a padded version of img0 %

%flip kernel both horizontally and vertically
kernel = h';

[rowk, colk] = size(kernel);
windrowk = floor(rowk/2);
windcolk = floor(colk/2);

paddedImg0 = padarray(img0, [windrowk windcolk], 'replicate');
[rowp, colp] = size(paddedImg0);


% Calculate weighted average and assign back to source px %

%iterate through padded image giving space for window of kernel size
for i=1+windrowk:rowp-windrowk
    for j=1+windcolk:colp-windcolk
        
        weightedAvg = 0;
        
        %iterate through window of kernel size in padded image
        for m=-windrowk:windrowk
            for n=-windcolk:windcolk
                weightedAvg = weightedAvg + (kernel(m+windrowk+1,n+windcolk+1) * paddedImg0(i+m,j+n));
            end
        end
        
        img1(i-windrowk,j-windcolk) = weightedAvg;
                
    end
end

end