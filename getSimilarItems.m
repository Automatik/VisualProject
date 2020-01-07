function getSimilarItems(imagePath, svmMaster, svmSub, svmArticle, trainHogFeatures, imagesIdsTrain, imdsArticleTypeTrain)
    K = 10; % Similar items to retrieve
    image = imread(imagePath);
    image = imrotate(image,-90);
    segmentedImage = segmentImage(image);
    if ~isempty(segmentedImage)
        
        hog = double(extractHOGFeatures(segmentedImage,'CellSize',[8 8],'BlockSize',[2 2]));
        features = hog ./ norm(hog);
        
        load('categoryMap.mat','CategoryMap','categoryList');

        [predMaster,~,~,PosteriorMaster] = predict(svmMaster,features);
        [predSub,~,~,PosteriorSub] = predict(svmSub, features);
        [predArticle,~,~,PosteriorArticle] = predict(svmArticle, features);
        
%         fprintf("Pred Master: %s, Sub: %s, Article: %s\n",string(predMaster), string(predSub), string(predArticle));
        
%         master = find({CategoryMap.Master} == string(predMaster),1);
%         subsMap = CategoryMap(master).SubCategories;
%         subs = {subsMap.Sub};
%         subClasses = cellstr(svmSub.ClassNames).';
%         validSubs = subClasses(ismember(subClasses,subs));
%         validProbSub = PosteriorSub(ismember(subClasses,subs));
%         [~, maxProbSubIndex] = max(validProbSub);
%         predSub = validSubs(maxProbSubIndex);
%         sub = find(ismember(subs,predSub),1);
%         articlesMap = subsMap(sub).Articles;
%         articles = {articlesMap.Article};
%         articleClasses = cellstr(svmArticle.ClassNames).';
%         validArticles = articleClasses(ismember(articleClasses, articles));
%         validProbArticle = PosteriorArticle(ismember(articleClasses, articles));
%         [~, maxProbArticleIndex] = max(validProbArticle);
%         pred = validArticles(maxProbArticleIndex);
        
%         pred = predict(svmArticleHog.ClassificationSVM, features);
%         pred = predict(svmArticleHog, features);
%         [pred, ~, PBScore, Posterior] = predict(svmArticleHog, features);
%         disp(string(pred));

        m = 2;
        s = 6;
        a = 10;
        [probMaster, indexMaster] = sort(PosteriorMaster, 'descend');
        masterNames = svmMaster.ClassNames(indexMaster(1:m)).';
%         master = find(ismember({CategoryMap.Master},masterNames(1:m)));
%         subsMap = CategoryMap(masterNames(1:m)).SubCategories;
        subsCell = {CategoryMap.SubCategories};
        subsMap = cell2mat(subsCell(indexMaster(1:m)));
        subs = {subsMap.Sub};
        subClasses = cellstr(svmSub.ClassNames).';
        validSubs = subClasses(ismember(subClasses,subs));
        validProbSub = PosteriorSub(ismember(subClasses,subs));
        [~, indexSub] = sort(validProbSub, 'descend');
        predSub = validSubs(indexSub(1:s));
        probSub = validProbSub(indexSub(1:s));
%         articlesMap = subsMap(sub).Articles;
        articlesCell = {subsMap.Articles};
        articlesMap = cell2mat(articlesCell(ismember(subs,predSub)));
        articles = {articlesMap.Article};
        articleClasses = cellstr(svmArticle.ClassNames).';
        validArticles = articleClasses(ismember(articleClasses, articles));
        validProbArticle = PosteriorArticle(ismember(articleClasses, articles));
        [~, indexArticle] = sort(validProbArticle, 'descend');
        if length(indexArticle) < a
            a = length(indexArticle);
        end
        predArticle = validArticles(indexArticle(1:a));
        probArticle = validProbArticle(indexArticle(1:a));
        
        predProb = zeros(length(predArticle),1);
        pred = cell(length(predArticle),1);
        for ii = 1:length(predArticle)
            art = predArticle(ii);
            catlistIndex = find(strcmp(categoryList(:,3),art));
            subRef = categoryList(catlistIndex,2);
            masterRef = categoryList(catlistIndex,1);
            subIdx = find(strcmp(predSub,subRef),1);
            masterIdx = find(strcmp(cellstr(masterNames),masterRef),1);
            prob = probArticle(ii) * probSub(subIdx) * probMaster(masterIdx);
            predProb(ii) = prob;
            pred{ii} = art;
        end
        
        [~, indexPred] = max(predProb);
        pos = find(ismember(cellstr(imdsArticleTypeTrain.Labels),pred{indexPred}));

        % Seleziona i primi 10 articoli
%         [articleSorted, indexArticle] = sort(PosteriorArticle,'descend');
%         articleNames = svmArticle.ClassNames(indexArticle);
%         pred = articleNames(1:10);
%         pos = find(ismember(cellstr(imdsArticleTypeTrain.Labels),cellstr(pred)));
        
        
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