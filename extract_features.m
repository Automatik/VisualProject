load('cvpartitions.mat','cvMaster');
load('imds.mat','imdsMaster');

net = alexnet;
sz = net.Layers(1).InputSize;
layer = 'fc7'; % layer da cui estrarre le features

% Resize images
% Se rimuoviamo le immagini grigie non c'è bisogno del color preprocessing
imdsMaster = augmentedImageDatastore(sz, imdsMaster, 'ColorPreprocessing','gray2rgb');

features = activations(net, imdsMaster, layer, 'OutputAs', 'rows');
