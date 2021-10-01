function [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% Im is the edge magnitude image, threshold(scalar) is a edge strength threshold
% used to ignore pixels with a low edge filter response. rhoRes (scalar) and thetaRes
% (scalar) are the resolution of the Hough transform accumulator along the rho and theta
% axes respectively. H is the Hough transform accumulator that contains the number
% of votes for all the possible lines passing through the image.

[m, n] = size(Im); % for finding max rho
rhoMax = sqrt(m^2 + n^2); % maximum distance possible
thetaRes = thetaRes * (180/pi); % rescale theta resolution to degrees for now

% bins of accumulator for quantization
rhoScale = ceil(-rhoMax):rhoRes:ceil(rhoMax); % (0, rhoMax)
thetaScale = -90:thetaRes:90; %  (-pi/2, pi/2)
rhoLen = numel(rhoScale); % rows in accumulator
thetaLen = numel(thetaScale); % columns in accumulator
H = zeros(rhoLen, thetaLen); % initialize accumulator

[edge_xIdx, edge_yIdx] = find(Im > threshold); % find non-zero indices of edges in image

% populate accumulator
for i = 1:numel(edge_xIdx)
    for thetaIdx = 1:thetaLen % loop through thetaScale
       rhoCurrent = edge_yIdx(i)*cosd(thetaScale(thetaIdx)) + edge_xIdx(i)*sind(thetaScale(thetaIdx));
       rhoCurrent = floor(rhoCurrent/rhoRes) * rhoRes; % quantize to rho's resolution into bins
       thetaCurrent = floor(thetaScale(thetaIdx)/thetaRes) * thetaRes; % quantize to theta's resolution into bins
       thetaBinIdx = find(thetaScale==thetaCurrent); % find quantized indices
       rhoBinIdx = find(rhoScale==rhoCurrent);
       H( rhoBinIdx, thetaBinIdx ) = H( rhoBinIdx, thetaBinIdx ) + 1; % increment element in accumulator
    end
end
% end of accumulator population

thetaScale = thetaScale .* (pi/180); % convert back to radians for output
        
end
