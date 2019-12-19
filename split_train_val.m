[imagesIds, ~, masterCategory, subCategory, articleType] = loadstyles();

missing_images = find_missing_images(imagesIds);
[~, idxs] = ismember(missing_images, imagesIds);
imagesIds(idxs.',:) = []; % remove missing images
masterCategory(idxs.',:) = [];
subCategory(idxs.',:) = [];
articleType(idxs.',:) = [];

% Se vogliamo rimuovere le immagini solo grigie
% gray_images = find_gray_images(imagesIds);
% [~, gray_indexes] = ismember(gray_images,imagesIds);
% imagesIds(gray_indexes.',:) = [];
% masterCategory(idxs.',:) = [];
% subCategory(idxs.',:) = [];

% Rimuoviamo l'immagine relativa al label Home che è solo una
pos = [];
pos = [pos; find(strcmp(masterCategory,'Home'))];
pos = [pos; find(strcmp(articleType, 'Body Wash and Scrub'))];
pos = [pos; find(strcmp(articleType, 'Cushion Covers'))];
pos = [pos; find(strcmp(articleType, 'Hair Accessory'))];
pos = [pos; find(strcmp(articleType, 'Ipad'))];
pos = [pos; find(strcmp(articleType, 'Mens Grooming Kit'))];
pos = [pos; find(strcmp(articleType, 'Shoe Laces'))];
pos = [pos; find(strcmp(articleType, 'Suits'))];
pos = [pos; find(strcmp(articleType, 'Face Serum and Gel'))];
pos = [pos; find(strcmp(articleType, 'Key chain'))];
pos = [pos; find(strcmp(articleType, 'Rain Trousers'))];
pos = [pos; find(strcmp(articleType, 'Ties and Cufflinks'))];
pos = [pos; find(strcmp(articleType, 'Hat'))];
pos = [pos; find(strcmp(articleType, 'Lounge Tshirts'))];
pos = [pos; find(strcmp(articleType, 'Tablet Sleeve'))];
pos = [pos; find(strcmp(articleType, 'Trolley Bag'))];
pos = [pos; find(strcmp(articleType, 'Beauty Accessory'))];
pos = [pos; find(strcmp(articleType, 'Lehenga Choli'))];
pos = [pos; find(strcmp(articleType, 'Lip Plumper'))];
pos = [pos; find(strcmp(articleType, 'Makeup Remover'))];
pos = [pos; find(strcmp(articleType, 'Robe'))];
pos = [pos; find(strcmp(articleType, 'Nehru Jackets'))];
pos = [pos; find(strcmp(articleType, 'Toner'))];
pos = [pos; find(strcmp(articleType, 'Face Scrub and Exfoliator'))];
pos = [pos; find(strcmp(articleType, 'Body Lotion'))];
pos = [pos; find(strcmp(articleType, 'Eye Cream'))];
pos = [pos; find(strcmp(articleType, 'Nail Essentials'))];
pos = [pos; find(strcmp(articleType, 'Shrug'))];
pos = [pos; find(strcmp(articleType, 'Umbrellas'))];
pos = [pos; find(strcmp(articleType, 'Headband'))];
pos = [pos; find(strcmp(articleType, 'Salwar and Dupatta'))];
pos = [pos; find(strcmp(articleType, 'Wristbands'))];
pos = [pos; find(strcmp(articleType, 'Blazers'))];
pos = [pos; find(strcmp(articleType, 'Clothing Set'))];
pos = [pos; find(strcmp(articleType, 'Footballs'))];
pos = [pos; find(strcmp(articleType, 'Shapewear'))];
pos = [pos; find(strcmp(articleType, 'Tights'))];
pos = [pos; find(strcmp(articleType, 'Concealer'))];
pos = [pos; find(strcmp(articleType, 'Rucksacks'))];
pos = [pos; find(strcmp(articleType, 'Water Bottle'))];
pos = [pos; find(strcmp(articleType, 'Booties'))];
pos = [pos; find(strcmp(articleType, 'Mask and Peel'))];
pos = [pos; find(strcmp(articleType, 'Rompers'))];
pos = [pos; find(strcmp(articleType, 'Basketballs'))];
pos = [pos; find(strcmp(articleType, 'Mascara'))];
pos = [pos; find(strcmp(articleType, 'Waistcoat'))];
pos = [pos; find(strcmp(articleType, 'Baby Dolls'))];
pos = [pos; find(strcmp(articleType, 'Jumpsuit'))];
pos = [pos; find(strcmp(articleType, 'Lip Care'))];
pos = [pos; find(strcmp(articleType, 'Travel Accessory'))];
pos = [pos; find(strcmp(articleType, 'Swimwear'))];
pos = [pos; find(strcmp(articleType, 'Waist Pouch'))];
pos = [pos; find(strcmp(articleType, 'Rain Jacket'))];
pos = [pos; find(strcmp(articleType, 'Hair Colour'))];
pos = [pos; find(strcmp(articleType, 'Bath Robe'))];
pos = [pos; find(strcmp(articleType, 'Gloves'))];
pos = [pos; find(strcmp(articleType, 'Shoe Accessories'))];
pos = [pos; find(strcmp(articleType, 'Sunscreen'))];
pos = [pos; find(strcmp(articleType, 'Face Wash and Cleanser'))];
pos = [pos; find(strcmp(articleType, 'Tracksuits'))];
pos = [pos; find(strcmp(articleType, 'Churidar'))];
pos = [pos; find(strcmp(articleType, 'Salwar'))];
pos = [pos; find(strcmp(articleType, 'Stockings'))];
pos = [pos; find(strcmp(articleType, 'Jeggings'))];
pos = [pos; find(strcmp(articleType, 'Lounge Shorts'))];
pos = [pos; find(strcmp(articleType, 'Mufflers'))];
pos = [pos; find(strcmp(articleType, 'Patiala'))];
pos = [pos; find(strcmp(articleType, 'Camisoles'))];
pos = [pos; find(strcmp(articleType, 'Suspenders'))];
pos = [pos; find(strcmp(articleType, 'Eyeshadow'))];
pos = [pos; find(strcmp(articleType, 'Messenger Bag'))];
pos = [pos; find(strcmp(articleType, 'Mobile Pouch'))];
pos = [pos; find(strcmp(articleType, 'Lip Liner'))];
pos = [pos; find(strcmp(articleType, 'Compact'))];
pos = [pos; find(strcmp(articleType, 'Boxers'))];
pos = [pos; find(strcmp(articleType, 'Highlighter and Blush'))];
pos = [pos; find(strcmp(articleType, 'Fragrance Gift Set'))];
pos = [pos; find(strcmp(articleType, 'Jewellery Set'))];
pos = [pos; find(strcmp(articleType, 'Face Moisturisers'))];
pos = [pos; find(strcmp(articleType, 'Lounge Pants'))];
pos = [pos; find(strcmp(articleType, 'Bracelet'))];
pos = [pos; find(strcmp(articleType, 'Sports Sandals'))];
pos = [pos; find(strcmp(articleType, 'Foundation and Primer'))];
pos = [pos; find(strcmp(articleType, 'Laptop Bag'))];
pos = [pos; find(strcmp(articleType, 'Bangle'))];
pos = [pos; find(strcmp(articleType, 'Duffel Bag'))];
pos = [pos; find(strcmp(articleType, 'Stoles'))];
pos = [pos; find(strcmp(articleType, 'Free Gifts'))];
pos = [pos; find(strcmp(articleType, 'Kurta Sets'))];
pos = [pos; find(strcmp(subCategory, 'Perfumes'))];
pos = [pos; find(strcmp(subCategory, 'Free Gifts'))];
pos = [pos; find(strcmp(subCategory, 'Eyes'))];
imagesIds(pos,:) = [];
masterCategory(pos,:) = [];
subCategory(pos,:) = [];
articleType(pos,:) = [];

% Create ImageDatastore
location = cellstr(strcat('../images/',num2str(imagesIds),'.jpg'));
location = strrep(location,' ',''); %remove spaces
imdsMaster = imageDatastore(location, 'Labels', categorical(masterCategory));
imdsSub = imageDatastore(location, 'Labels', categorical(subCategory));
imdsArticle = imageDatastore(location, 'Labels', categorical(articleType));
save('imds.mat','imdsMaster','imdsSub','imdsArticle');

% Per vedere la distribuzione
% T = countEachLabel(imdsMaster)

%% Splittare per ArticleType e successivamente replicare lo split
% per MasterCategory e SubCategory
[imdsArticleTypeTrain, imdsArticleTypeTest] = splitEachLabel(imdsArticle, 0.75);

imagesIdsTrain = extract_id(imdsArticleTypeTrain.Files);
imagesIdsTest = extract_id(imdsArticleTypeTest.Files);

imdsMasterTrain = assign_labels(imdsArticleTypeTrain, imdsMaster);
imdsMasterTest = assign_labels(imdsArticleTypeTest, imdsMaster);

imdsSubTrain = assign_labels(imdsArticleTypeTrain, imdsSub);
imdsSubTest = assign_labels(imdsArticleTypeTest, imdsSub);

save('imdsOriginalTrainTest.mat','imdsArticleTypeTrain','imdsArticleTypeTest',...
    'imdsMasterTrain','imdsMasterTest','imdsSubTrain','imdsSubTest', ...
    'imagesIdsTrain','imagesIdsTest');

%% Crea immagini sintetiche SOLO dal training set

create_new_images(imagesIdsTrain, cellstr(imdsMasterTrain.Labels), ...
    cellstr(imdsSubTrain.Labels), cellstr(imdsArticleTypeTrain.Labels));

%% Undersample delle immagini delle classi di maggioranza

indexesToDelete = undersample_random(cellstr(imdsArticleTypeTrain.Labels));
imagesIds(indexesToDelete,:) = [];
masterCategory(indexesToDelete,:) = [];
subCategory(indexesToDelete,:) = [];
articleType(indexesToDelete,:) = [];

load('newImagesLabels.mat','newImagesIds','newMasterCategory','newSubCategory','newArticleType');

newImagesLocation = cellstr(strcat('../newImages/',num2str(cell2mat(newImagesIds)),'.jpg'));
newImagesLocation = strrep(newImagesLocation,' ','');
location = [location; newImagesLocation];
masterCategory = [masterCategory; newMasterCategory];
subCategory = [subCategory; newSubCategory];
articleType = [articleType; newArticleType];

imdsMaster = imageDatastore(location, 'Labels', categorical(masterCategory));
imdsSub = imageDatastore(location, 'Labels', categorical(subCategory));
imdsArticle = imageDatastore(location, 'Labels', categorical(articleType));
save('imdsForTrain.mat','imdsMaster','imdsSub','imdsArticle');

% cvMaster = cvpartition(masterCategory, 'KFold', 3);
% cvSub = cvpartition(subCategory, 'KFold', 3);
% save('cvpartitions.mat','cvMaster','cvSub');
