function hogFeatures = extractHog(imds)
    imdsAug = augmentedImageDatastore([80 60],imds,'ColorPreprocessing','gray2rgb');
    hogFeatures = zeros(size(imds.Files,1), 1944);
    h = 1;
    ii = 1;
    while ii <= size(imds.Files,1)
        to = ii + 4; % 99;
        data = readByIndex(imdsAug,ii:to);
        images = data{:,1};
        for jj = 1:size(images,1)
            img = images{jj,1};
            hog = extractHOGFeatures(img,'CellSize',[8 8],'BlockSize',[2 2]);
            hogFeatures(h,:) = hog;
            h = h + 1;
        end
        ii = to + 1;
    end
end

% hogFeatures = zeros(size(imdsMaster.Files,1), 1944);
% 
% for ii = 1:size(imdsMaster.Files,1)
%     img = readimage(imdsMaster, ii);
%     if size(img,3) > 1
%         img = rgb2gray(img);
%     end
%     if isequal(size(img),[80 60])
%         hog = extractHOGFeatures(img,'CellSize',[8 8],'BlockSize',[2 2]);
%         hogFeatures(ii,:) = hog;
%     else
%         fprintf("Image Index: %d\n",ii);
%     end
% end

