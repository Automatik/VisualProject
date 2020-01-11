function getSimilarItems(imagePath, svmArticle, trainHogFeatures, imagesIdsTrain, imdsArticleTypeTrain)
    K = 10; % Similar items to retrieve
    image = imread(imagePath);
    image = imrotate(image,-90);
    segmentedImage = segmentImage(image);
    if ~isempty(segmentedImage)
        
        hog = double(extractHOGFeatures(segmentedImage,'CellSize',[8 8],'BlockSize',[2 2]));
        features = hog ./ norm(hog);
        
        [~,~,~,PosteriorArticle] = predict(svmArticle, features);
        
        
%         pred = predict(svmArticleHog.ClassificationSVM, features);
%         pred = predict(svmArticleHog, features);
%         [pred, ~, PBScore, Posterior] = predict(svmArticleHog, features);
%         disp(string(pred));


        % Seleziona i primi 10 articoli
        [articleSorted, indexArticle] = sort(PosteriorArticle,'descend');
        articleNames = svmArticle.ClassNames(indexArticle);
        pred = articleNames(1:10);
        pos = find(ismember(cellstr(imdsArticleTypeTrain.Labels),cellstr(pred)));
        
        
%         fprintf("Final Sub: %s, Article: %s\n",string(predSub),string(pred));
%         pos = find(strcmp(cellstr(imdsArticleTypeTrain.Labels),string(pred)));
        hogFeatures = trainHogFeatures(pos,:);
        imagesIds = imagesIdsTrain(pos,:);
        
        normTrainFeatures = hogFeatures ./ norm(hogFeatures);
        D = pdist2(normTrainFeatures, features, 'correlation');
        [~, idx] = mink(D, K);
        ids = imagesIds(idx);
        
        similarImagesPaths = strrep(cellstr(strcat('../images/',num2str(ids),'.jpg')),' ','');
        [pathstr, name, ext] = fileparts(imagePath);
        for ii = 1:K
%             resultPath = fullfile(pathstr, [name '_' num2str(ii) ext]);
            resultPath = fullfile('testSimilarity', [name '_' num2str(ii) ext]);
            copyfile(similarImagesPaths{ii,:},resultPath);
        end
    end
end