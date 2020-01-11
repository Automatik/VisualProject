load('SvmMasterCubic.mat', 'svm');
load('SvmArticleCubic.mat', 'svmArticle');
load('imdsOriginalTrainTest.mat','imdsMasterTrain', ...
    'imdsSubTrain', 'imdsArticleTypeTrain', 'imagesIdsTrain');
load('hogFeatures.mat','trainHogFeatures');