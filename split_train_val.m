[imagesIds, ~, masterCategory, subCategory] = loadstyles();

missing_images = find_missing_images(imagesIds);
[~, idxs] = ismember(missing_images, imagesIds);
imagesIds(idxs.',:) = []; % remove missing images
masterCategory(idxs.',:) = [];
subCategory(idxs.',:) = [];

% Se vogliamo rimuovere le immagini solo grigie
% gray_images = find_gray_images(imagesIds);
% [~, gray_indexes] = ismember(gray_images,imagesIds);
% imagesIds(gray_indexes.',:) = [];
% masterCategory(idxs.',:) = [];
% subCategory(idxs.',:) = [];

% Rimuoviamo l'immagine relativa al label Home che è solo una
pos = find(strcmp(masterCategory,'Home'));
imagesIds(pos,:) = [];
masterCategory(pos,:) = [];
subCategory(pos,:) = [];

% Create ImageDatastore
location = cellstr(strcat('../images/',num2str(imagesIds),'.jpg'));
location = strrep(location,' ',''); %remove spaces
imdsMaster = imageDatastore(location, 'Labels', categorical(masterCategory));
imdsSub = imageDatastore(location, 'Labels', categorical(subCategory));
save('imds.mat','imdsMaster','imdsSub');

% Per vedere la distribuzione
% T = countEachLabel(imdsMaster)

cvMaster = cvpartition(masterCategory, 'KFold', 3);
cvSub = cvpartition(subCategory, 'KFold', 3);
save('cvpartitions.mat','cvMaster','cvSub');

% Semplice split

% numImages = size(imagesIds,1);
% valSize = 0.25;
% 
% trainIndexes = randperm(numImages, floor((1 - valSize)*numImages));
% valIndexes = setdiff(1:numImages,trainIndexes);
% 
% trainIds = imagesIds(trainIndexes);
% valIds = imagesIds(valIndexes);
% 
% save('train_val_ids.mat','trainIds','valIds');
