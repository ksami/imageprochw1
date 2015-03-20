function [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% Im is the edge magnitude image, threshold(scalar) is a edge strength threshold
% used to ignore pixels with a low edge filter response. rhoRes (scalar) and thetaRes
% (scalar) are the resolution of the Hough transform accumulator along the rho and theta
% axes respectively. H is the Hough transform accumulator that contains the number
% of votes for all the possible lines passing through the image.

rangeTheta = 0:thetaRes:pi;
%rangeRho = [0:rhoRes:100];

[row col] = size(Im);
H = zeros(((row+col)/rhoRes)+row+col, length(rangeTheta)+1);

rhoOffset = row+col+1;
thetaOffset = 1;

for y=1:row
    for x=1:col
        %based on threshold
        if(Im(y,x) > threshold)
            %calculate rho value for each theta value
            %increase vote count at every rho-theta pair
            for theta=rangeTheta
                rho = x*sin(theta) + y*cos(theta);  % -(row+col)<rho<row+col, 0<theta<pi
                
                rho = floor(rho/rhoRes + rhoOffset);
                thet = floor(theta/thetaRes + thetaOffset);
                H(rho, thet) = H(rho, thet) + 1;
                %H(rho+rhoOffset,floor(theta*thetaScale+thetaOffset)) = H(rho+rhoOffset,floor(theta*thetaScale+thetaOffset)) + 1;
            end
        end
    end
end
