function hogFeatures = extractFeaturesHOG(imdsAug)
    
    ImSize = [80 60];
    CellSize = [8 8];
    BlockSize = [2 2];
    NumBins = 9;
    
    BlocksPerImage = floor((ImSize ./ CellSize - BlockSize)./(BlockSize - ceil(BlockSize/2)) + 1);
    N = prod([BlocksPerImage, BlockSize, NumBins]);
    

    
    % PER LBP
%     NumNeighbors = 8;
%     Radius = 1;
%     CellSize = [80 60];  
%     numCells = prod(floor(ImSize/CellSize));
%     Bins = NumNeighbors * (NumNeighbors-1) + 3;
%     N = numCells * Bins;
    
    fprintf("Total Features: %d\n",N);

    hogFeatures = zeros(size(imdsAug.Files,1), N);
    h = 1;
    ii = 1;
    while ii <= size(imdsAug.Files,1)
        to = ii + 4; % 99;
        data = readByIndex(imdsAug,ii:to);
        images = data{:,1};
        for jj = 1:size(images,1)
            img = images{jj,1};
            hog = extractHOGFeatures(img,'CellSize',CellSize,'BlockSize',BlockSize, 'NumBins',NumBins);
            % LBP
            % hog = extractLBPFeatures(rgb2gray(img),'NumNeighbors',NumNeighbors,'Radius',Radius,'CellSize',CellSize);
            hogFeatures(h,:) = hog;
            h = h + 1;
        end
        ii = to + 1;
    end
end