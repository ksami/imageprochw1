function [lines] = myHoughLineSegments(lineRho, lineTheta, Im, threshold)
% [lines] = myHoughLineSegments(lineRho, lineTheta, Im, threshold)
% Prunes lines into line segments so they do not extend beyond the object
% lines(i).start and lines(i).end are [2 1] vectors to store the (y,x)
% location of each point

%how many blank pixels before ending the line
gapThreshold = 2;

% Generate lines in y-x space %
[row, col] = size(Im);
nLines = size(lineRho,1);
failedCalc = zeros(nLines,1);
idx = 0;

%prealloc lines
lines(nLines).start=0;
lines(nLines).end=0;


for i=1:nLines
    
    rho = lineRho(i);
    theta = lineTheta(i);
    
    isStartFound = false;
    isEndFound = false;  %probably redundant
    gapCount = 0;
    
    %//TODO: what to do if theta==pi/2? y always NaN, lines get no val;
    %separate case, iterate using y instead, is a vertical line
    %save cases
    if(cos(theta)>-0.001 && cos(theta)<0.001)
        idx = idx+1;
        failedCalc(idx) = i;
        continue;
    end
    
    %for every rho-theta pair, obtain line in y-x space
    %iterating along line in Im
    for x=1:col
        
        % -(row+col)<rho<row+col, 0<theta<pi
        %rho=x*sin(theta)-y*cos(theta)        
        y = ((x*sin(theta))/cos(theta)) - (rho/cos(theta));  % -(row + 2*col)<y<row + 2*col , NaN
        y = floor(y);
        
        %y should be bounded by row at least
        if(y>0 && y<row)
    
            %should be true while theoretical line is on real line but
            %there are gaps
            %instead of Im(y,x)~=0
%             if(Im(y,x)>threshold)                %//TODO: stopped here, need reconsider ending condition
%                 if(isStartFound==false)
%                     lines(i).start = [y x];
%                     isStartFound = true;
%                 else
%                     if(isEndFound==false)
%                         lines(i).end = [y x];
%                     end
%                 end
%             else
%                 isEndFound = true;
%             end
            if(Im(y,x)>threshold)
                if(isStartFound==false)
                    lines(i).start = [y x];
                    lines(i).end = [y x];
                    isStartFound = true;
                elseif(isStartFound && isEndFound==false)
                    lines(i).end = [y x];
                    gapCount = 0;
                end
            elseif(isStartFound)
                gapCount = gapCount + 1;
                if(gapCount>gapThreshold)
                    break;  %consider next set of rho theta
                end
            end
              
        end
        
%         if(isStartFound && isEndFound)
%             break;
%         end
        
    end
    
end

%for failed cases
for j=1:idx
    
    rho = lineRho(failedCalc(j));
    theta = lineTheta(failedCalc(j));
    
    isStartFound = false;
    isEndFound = false;
    gapCount = 0;
    
    %for every rho-theta pair, obtain line in y-x space
    %iterating along line in Im
    for y=1:row
        
        % -(row+col)<rho<row+col, 0<theta<pi
        %rho=x*sin(theta)-y*cos(theta)        
        %y = (x*sin(theta))/cos(theta) - rho/cos(theta);  % -(row + 2*col)<y<row + 2*col , NaN
        %y = floor(y);
        
        %sin(theta) now can't be 0 since cos(theta)==0 to be a failed case
        x = rho/sin(theta) - (y*cos(theta))/sin(theta);
        x = floor(x);
        
        %x should be bounded by col at least
        if(x>0 && x<col)
    
            %should be true while theoretical line is on real line
            %instead of Im(y,x)~=0
%             if(Im(y,x)>threshold)
%                 if(isStartFound==false)
%                     lines(failedCalc(j)).start = [y x];
%                     isStartFound = true;
%                 else
%                     if(isEndFound==false)
%                         lines(failedCalc(j)).end = [y x];
%                     end
%                 end
%             else
%                 isEndFound = true;
%             end
            
            if(Im(y,x)>threshold)
                if(isStartFound==false)
                    lines(failedCalc(j)).start = [y x];
                    isStartFound = true;
                elseif(isStartFound && isEndFound==false)
                    lines(failedCalc(j)).end = [y x];
                    gapCount = 0;
                end
            elseif(isStartFound)
                gapCount = gapCount + 1;
                if(gapCount>gapThreshold)
                    break;  %consider next set of rho theta
                end
            end
              
        end
        
%         if(isStartFound && isEndFound)
%             break;
%         end
        
    end
    
end


end