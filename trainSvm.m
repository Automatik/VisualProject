load('imdsForTrain.mat', 'imdsMaster', 'imdsSub', 'imdsArticle');
load('imdsOriginalTrainTest.mat', 'imdsArticleTypeTest', 'imdsMasterTest', 'imdsSubTest');
load('trainSvmHogFeatures.mat')
%net = alexnet;
%sz = net.Layers(1).InputSize;
sz = [80 60];
layer = 'fc7'; % layer da cui estrarre le features

%[trainSub, testSub] = splitEachLabel(imdsSub, 0.75);
trainSub = imdsSub;
% testSub = imdsSubTest;

trainAugSub = augmentedImageDatastore(sz, trainSub, 'ColorPreprocessing', 'gray2rgb');
% testAugSub = augmentedImageDatastore(sz, testSub, 'ColorPreprocessing','gray2rgb');

%trainFeatures = activations(net, trainAugSub, layer, 'OutputAs', 'rows');
%testFeatures = activations(net, testAugSub, layer, 'OutputAs', 'rows');
% trainFeatures = extractFeaturesHOG(trainAugSub);
% testFeatures = extractFeaturesHOG(testAugSub);

normTrainFeatures = trainFeatures ./ norm(trainFeatures);
%normTestFeatures = testFeatures ./ norm(testFeatures);

%normTrainFeatures = gpuArray(normTrainFeatures);
% normTestFeatures = gpuArray(normTestFeatures);

t = templateSVM('KernelFunction', 'polynomial', 'Standardize', true);
svmArticleCubic = fitcecoc(normTrainFeatures, imdsArticle.Labels, 'Learners', t, 'Coding', 'onevsone', 'FitPosterior', true, 'KFold', 3, 'Options', statset('UseParallel', true));

svm = fitcecoc(normTrainFeatures, trainSub.Labels);
save('svmSub.mat', 'svm');

%pred = predict(svm, normTestFeatures);
%save('pred.mat','pred');
