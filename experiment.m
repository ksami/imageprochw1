%parameters

sigma     = 2;
threshold = 0.03;
rhoRes    = 2;
thetaRes  = pi/180;
nLines    = 20;

%end of parameters
i=6;

% houghScript(sigma, threshold, rhoRes, thetaRes, nLines, i);  i=i+1;
% houghScript(sigma, threshold, rhoRes, thetaRes, nLines*2, i);  i=i+1;
% houghScript(sigma-1, threshold, rhoRes, thetaRes, nLines, i);  i=i+1;
% houghScript(sigma, threshold-0.01, rhoRes, thetaRes, nLines, i);  i=i+1;
% houghScript(sigma, threshold, rhoRes-1, thetaRes, nLines, i);  i=i+1;
houghScript(sigma+1, threshold, rhoRes, thetaRes, nLines, i);  i=i+1;