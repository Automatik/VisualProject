%% Estrarre features dal dataset originale (solo train ?)

% load('imdsOriginalTrainTest.mat','imdsArticleTypeTrain','imdsArticleTypeTest',...
%         'imdsMasterTrain','imdsMasterTest','imdsSubTrain','imdsSubTest', ...
%         'imagesIdsTrain','imagesIdsTest');

trainImds = imdsMasterTrain;
trainIds = imagesIdsTrain;
fprintf("Extracting Train Features\n");
% if exist('hogFeatures.mat','file') ~= 2
    trainHogFeatures = extractHog(trainImds);
% else
%     load('hogFeatures.mat');
% end

%% Estrarre features delle immagini di test
fprintf("Extracting Test Features\n");
testImds = imdsMasterTest;
testIds = imagesIdsTest;
% if exist('hogFeatures.mat','file') ~= 2
    testHogFeatures = extractHog(testImds);
% end

%% Applicare metriche di similarità
fprintf("CBIR\n");
K = 10; % quanti elementi simili trovare

testSize = 10; % size(testHogFeatures,1);

trainAug = augmentedImageDatastore([80 60], trainImds, 'ColorPreprocessing','rgb2gray');
testAug = augmentedImageDatastore([80 60], testImds, 'ColorPreprocessing','rgb2gray');
% normTrainHogFeatures = trainHogFeatures ./ norm(trainHogFeatures);
% normTestHogFeatures = testHogFeatures ./ norm(testHogFeatures);
% normTrainRgbFeatures = trainRgbFeatures ./ norm(trainRgbFeatures);
% normTestRgbFeatures = testRgbFeatures ./ norm(testRgbFeatures);
% normTrainFeatures = [normTrainHogFeatures normTrainRgbFeatures] ./ norm([normTrainHogFeatures normTrainRgbFeatures]);
% normTestFeatures = [normTestHogFeatures normTestRgbFeatures] ./ norm([normTestHogFeatures normTestRgbFeatures]);
normTrainFeatures = trainHogFeatures ./ norm(trainHogFeatures);
normTestFeatures = testHogFeatures ./ norm(testHogFeatures);
%load('svmMasterHog.mat');
%pred = predict(svmMasterHog.ClassificationSVM, normTestFeatures);

results = zeros(testSize, K);
euclideanScores = zeros(testSize,1);
pearsonScores = zeros(testSize,1);
for ii = 1:testSize
    features = normTestFeatures(ii,:);
    %label = cellstr(pred(ii));
    
    % calculate euclidean similarity metric
%     D = pdist2(normTrainFeatures,features,'euclidean'); 
%     normalize with max distance
%     maxDistance = max(D);
%     D = D ./ maxDistance;
    % calculate cosine similarity metric
%     D = pdist2(normTrainFeatures,features,'cosine');

    % correlation metric
    D = pdist2(normTrainFeatures, features, 'correlation');

    % spearman
%     D = pdist2(trainHogFeatures,features,'spearman');
    
    [dists, idx] = mink(D, K);
    
    %labels = cellstr(trainImds.Labels(idx));
    %results(ii,:) = strcmp(label, labels);
    euclideanScores(ii,1) = mean(1 - dists);
    
    % Show images
    corrs = zeros(K,1);
    %id = testIds(ii); Da usare con imread
    id = ii;
    data = readByIndex(testAug, id); % mettere rgb2gray negli Aug
    data = data{:,1};
    imQuery = data{1,1};
    %imQuery = imread(strcat('../images/',num2str(id),'.jpg'));
    %figure,imshow(imQuery);
    %ids = trainIds(idx); Da usare con imread
    ids = idx;
    data = readByIndex(trainAug, ids);
    images = data{:,1};
    %figure;
    for jj = 1:K
        %subplot(K/5, K/2, jj);
        img = images{jj,1};
        %img = imread(strcat('../images/',num2str(ids(jj)),'.jpg'));
        %imshow(img);
        corrs(jj,1) = corr2(imQuery, img);
    end
    pearsonScores(ii,1) = mean(corrs);
end

%% Valutazione delle performance (usare i label ? )

% Label score: quanto combaciano le immagini estratte con il label
% dell'immagine query
labelScore = mean(mean(results, 2)); 
fprintf("Label Score: %.2f\n",labelScore);

% Euclidean Distance/Similarity score:
euclideanSimilarityScore = mean(euclideanScores);
fprintf("Euclidean Similarity Score: %.2f\n",euclideanSimilarityScore);

% Perason correlation score:
pearsonSimilarityScore = mean(pearsonScores);
fprintf("Pearson Similarity Score: %.2f\n",pearsonSimilarityScore);