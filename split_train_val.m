imagesIds = loadstyles();

missing_images = find_missing_images(imagesIds);
[~, idxs] = ismember(missing_images, imagesIds);
imagesIds(idxs.',:) = []; % remove missing images

% gray_images = find_gray_images(imagesIds);
%[~, gray_indexes] = ismember(gray_images,imagesIds);
%imagesIds(gray_indexes.',:) = [];

% Semplice split

numImages = size(imagesIds,1);
valSize = 0.25;

trainIndexes = randperm(numImages, floor((1 - valSize)*numImages));
valIndexes = setdiff(1:numImages,trainIndexes);

trainIds = imagesIds(trainIndexes);
valIds = imagesIds(valIndexes);

save('train_val_ids.mat','trainIds','valIds');
