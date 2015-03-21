function [lineRho, lineTheta] = myHoughLines(H, rhoRes, thetaRes, nLines)
% [lineRho lineTheta] = myHoughLines(H, rhoRes, thetaRes, nLines)
% H is the Hough transform accumulator; rhoRes and thetaRes are the accumulator
% resolution parameters and nLines is the number of lines to return. Outputs lineRho
% and lineTheta are both nLines 1 vectors that contain the parameters (rho and theta
% respectively) of the lines found in an image.

% Non-maximal suppression %
[row, col] = size(H);

for i=1:row
    for j=1:col

        isSuppressed = false;

        %consider all neighbours
        for m=1:-1:-1
            for n=1:-1:-1

                %except self
                if(m==0 && n==0)
                    continue;
                end

                %boundary checking...
                if(i-m<1 || i-m>row)
                    continue;
                end

                if(j-n<1 || j-n>col)
                    continue;
                end

                %compare H(i,j) with neighbours and suppress
                if(H(i,j)<=H(i-m,j-n))
                    H(i,j) = 0;
                    isSuppressed = true;
                    break;
                end

            end
            
            if(isSuppressed)
                break;
            end

        end        
    end
end


% Find and return top nLines results %
lineRho = zeros(nLines, 1);
lineTheta = zeros(nLines, 1);
temp = zeros(row*col, 3);  %[[val, rho, theta]]
tempIdx = 1;

%store info in temp array
for i=1:row
    for j=1:col
        if(H(i,j)~=0)
            temp(tempIdx, 1) = H(i,j);
            
            %1<rho<((2*(row+col))/rhoRes) +1
            %1<theta<(pi/thetaRes)+1
            temp(tempIdx, 2) = ((i-1)*rhoRes) - ((row-1)*rhoRes)/2;  %row == 2*(maxval of rho))/rhoRes)+1
            temp(tempIdx, 3) = (j-1)*thetaRes;

            tempIdx = tempIdx + 1;
        end
    end
end

%sort based on val
sorted = sortrows(temp,-1);

%take top nLines results
for i=1:nLines
    lineRho(i,1) = sorted(i,2);
    lineTheta(i,1) = sorted(i,3);
end


end