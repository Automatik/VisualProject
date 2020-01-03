function getSimilarItems(imagePath)
    K = 10; % Similar items to retrieve
    image = imread(imagePath);
    tic
    segmentedImage = segmentImage(image);
    toc
    if ~isempty(segmentedImage)
        
        hog = double(extractHOGFeatures(segmentedImage,'CellSize',[8 8],'BlockSize',[2 2]));
        features = hog ./ norm(hog);
        
%         pred = predict(svmArticleHog.ClassificationSVM, features);
        pred = predict(svmArticleHog, features);
        disp(string(pred));
        pos = find(strcmp(cellstr(imdsArticleTypeTrain.Labels),string(pred)));
        trainHogFeatures = trainHogFeatures(pos,:);
        imagesIdsTrain = imagesIdsTrain(pos,:);
        
        normTrainFeatures = trainHogFeatures ./ norm(trainHogFeatures);
        D = pdist2(normTrainFeatures, features, 'correlation');
        [~, idx] = mink(D, K);
        ids = imagesIdsTrain(idx);
        
        similarImagesPaths = strrep(cellstr(strcat('../images/',num2str(ids),'.jpg')),' ','');
        [pathstr, name, ext] = fileparts(imagePath);
        for ii = 1:K
            resultPath = fullfile(pathstr, [name '_' num2str(ii) ext]);
            copyfile(similarImagesPaths{ii,:},resultPath);
        end
    end
end