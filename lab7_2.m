net = alexnet;
sz = net.Layers(1).InputSize;

%% cut layers
layersTransfer = net.Layers(1:end-3);
layersTransfer=freezeWeights(layersTransfer);

%% replace layers
numClasses = 44;
% con weightlearnrate questi layer avranno un learning rate 20 volte di
% quello dei precedenti, e saranno i layer a scegliere quanto aumentarne
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses, 'WeightLearnRateFactor', 20, ...
    'BiasLearnRateFactor', 20)
    softmaxLayer
    classificationLayer];

%% preparazione dati
% imds = imageDatastore('image.orig');
% labels = [];
% for ii = 1:size(imds.Files,1)
%     name = imds.Files{ii,1};
%     [p,n,ex] = fileparts(name);
%     class=floor(str2double(n)/100);
%     labels=[labels; class];
% end
% 
% labels = categorical(labels); 
% imds = imageDatastore('image.orig','labels',labels);

%% divisione train-test
[imdsTrain, imdsTest] = splitEachLabel(imdsSub,0.7, 'randomized');

%% data augmentation
% pixelRange = [-5 5];
% imageAugmenter = imageDataAugmenter('RandXReflection',true,'RandXTranslation',pixelRange,'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(sz, imdsTrain, 'ColorPreprocessing','gray2rgb');
augimdsTest = augmentedImageDatastore(sz, imdsTest, 'ColorPreprocessing','gray2rgb');
% augimdsTest = augmentedImageDatastore(sz(1:2), imdsTest);

%% configurazione fine tuning
options = trainingOptions('sgdm','MiniBatchSize',64,'MaxEpochs',6,'InitialLearnRate',1e-4,'Shuffle','every-epoch',...
    'ValidationData',augimdsTest,'ValidationFrequency',3,'Verbose',false,'Plots','training-progress');

%% training vero e proprio
netTransfer = trainNetwork(augimdsTrain,layers, options);

%% test
[lab_pred_te, scores] = classify(netTransfer, augimdsTest);

%% performance
acc = numel(find(lab_pred_te==imdsTest.Labels))/numel(lab_pred_te);