function [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% Im is the edge magnitude image, threshold(scalar) is a edge strength threshold
% used to ignore pixels with a low edge filter response. rhoRes (scalar) and thetaRes
% (scalar) are the resolution of the Hough transform accumulator along the rho and theta
% axes respectively. H is the Hough transform accumulator that contains the number
% of votes for all the possible lines passing through the image.

rangeTheta = 0:thetaRes:pi;

[row, col] = size(Im);
H = zeros(((2*(row+col))/rhoRes)+1, (pi/thetaRes)+1);

rhoOffset = row+col;

for y=1:row
    for x=1:col
        %based on threshold
        if(Im(y,x) > threshold)
            %calculate rho value for each theta value
            %increase vote count at every rho-theta pair
            for theta=rangeTheta
                rho = x*sin(theta) - y*cos(theta);  % -(row+col)<rho<row+col, 0<theta<pi
                
                rho = floor((rho + rhoOffset)/rhoRes) + 1;  % ((-(row+col)+(row+col))/rhoRes) +1 == 1<rho<((2*(row+col))/rhoRes) +1
                thet = floor(theta/thetaRes) + 1;  % 1<theta<(theta/thetaRes)+1
                H(rho, thet) = H(rho, thet) + 1;
            end
        end
    end
end
