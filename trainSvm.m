load('imds.mat', 'imdsMaster','imdsSub');

net = alexnet;
sz = net.Layers(1).InputSize;
layer = 'fc7'; % layer da cui estrarre le features

[trainSub, testSub] = splitEachLabel(imdsSub, 0.75);

trainAugSub = augmentedImageDatastore(sz, trainSub, 'ColorPreprocessing','gray2rgb');
testAugSub = augmentedImageDatastore(sz, testSub, 'ColorPreprocessing','gray2rgb');

trainFeatures = activations(net, trainAugSub, layer, 'OutputAs', 'rows');
testFeatures = activations(net, testAugSub, layer, 'OutputAs', 'rows');

normTrainFeatures = trainFeatures ./ norm(trainFeatures);
normTestFeatures = testFeatures ./ norm(testFeatures);

normTrainFeatures = gpuArray(normTrainFeatures);
% normTestFeatures = gpuArray(normTestFeatures);

svm = fitcecoc(normTrainFeatures, trainSub.Labels);
save('svmSub.mat','svm');

pred = predict(svm, normTestFeatures);
save('pred.mat','pred');