load('cvpartitions.mat','cvMaster');
load('imdsOriginalTrainTest.mat','imdsMasterTrain','imdsMasterTest');

net = alexnet;
sz = net.Layers(1).InputSize;
layer = 'fc7'; % layer da cui estrarre le features

% Resize images
% Se rimuoviamo le immagini grigie non c'� bisogno del color preprocessing
imdsMaster = augmentedImageDatastore(sz, imdsMaster, 'ColorPreprocessing','gray2rgb');

features = activations(net, imdsMaster, layer, 'OutputAs', 'rows');

% normFeatures = features ./ norm(features);

% [imds1, imds2] = splitEachLabel(imdsMaster, 0.25);
% T = table(normFeatures, imds1.Labels);
% train model


