% load('newSvmMaster.mat','svmMaster');
% load('newSvmSub.mat','svmSub');
% load('newSvmArticle.mat','svmArticle');
% load('hogFeatures.mat','trainHogFeatures');
% load('imdsOriginalTrainTest.mat','imdsMasterTrain', ...
%     'imdsSubTrain', 'imdsArticleTypeTrain', 'imagesIdsTrain');

testdir = 'testImages2';
destdir = 'testSegment';
files = dir(testdir);
if exist(destdir,'dir') ~= 7
    mkdir(destdir);
end
for f = 3:length(files)
    filename = files(f).name;
    fprintf("Segmenting %s\n",filename);
    getSimilarItems(strcat(testdir,'/',filename), svmArticle, trainHogFeatures, imagesIdsTrain, imdsArticleTypeTrain);
%     im = imrotate(im,-90);
end