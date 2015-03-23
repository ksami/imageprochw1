function houghScript(sigma, threshold, rhoRes, thetaRes, nLines, exptNo)

datadir     = '../data';    %the directory containing the images
resultsdir  = '../results'; %the directory for dumping results


imglist = dir(sprintf('%s/*.jpg', datadir));

for i = 1:numel(imglist)
    
    %read in images%
    [path imgname dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
   
    %actual Hough line code function calls%
    
    [Im Io Ix Iy] = myEdgeFilter(img, sigma);
    
    [H] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
    
    [lineRho lineTheta] = myHoughLines(H, rhoRes, thetaRes, nLines);
    
    lines = myHoughLineSegments(lineRho, lineTheta, Im, threshold);
    
    %everything below here just saves the outputs to files%
    fname = sprintf('%s/%d/%s_01edge.pgm', resultsdir, exptNo, imgname);
    imwrite(sqrt(Im/max(Im(:))), fname);
    fname = sprintf('%s/%d/%s_02threshold.pgm', resultsdir, exptNo, imgname);
    imwrite(Im > threshold, fname);
    fname = sprintf('%s/%d/%s_03hough.pgm', resultsdir, exptNo, imgname);
    imwrite(H/max(H(:)), fname);
    fname = sprintf('%s/%d/%s_04lines.pgm', resultsdir, exptNo, imgname);
    
    img2 = img;
    for j=1:numel(lines)
       img2 = drawLine(img2, lines(j).start, lines(j).end); 
    end
    
    imwrite(img2, fname);
end
    