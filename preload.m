load('SvmMasterCubic.mat','svm');
load('SvmArticleCubic.mat','svmArticle');
load('imdsOriginalTrainTest.mat','imdsMasterTrain', ...
    'imdsSubTrain', 'imdsArticleTypeTrain', 'imagesIdsTrain');
load('hogFeatures.mat','trainHogFeatures');

% svmArticleHog = setGlobalSvmArticle(svmArticle);
% trainHogFeatures = setGlobalHogFeatures(trainHogFeatures);
% imagesIdsTrain = setGlobalImagesIds(imagesIdsTrain);
% imdsArticleTypeTrain = setGlobalImdsArticle(imdsArticleTypeTrain);