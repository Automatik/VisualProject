%% Load Labels
fprintf("Loading labels...\n");
[imagesIds, ~, masterCategory, subCategory, articleType] = loadstyles();

missing_images = find_missing_images(imagesIds);
[~, idxs] = ismember(missing_images, imagesIds);
imagesIds(idxs.',:) = []; % remove missing images
masterCategory(idxs.',:) = [];
subCategory(idxs.',:) = [];
articleType(idxs.',:) = [];

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

%% Create category map
fprintf("Creating map...\n");
CategoryMap = struct('Master',{},'SubCategories',{});
masterCategories = unique(masterCategory);
[CategoryMap(1:size(masterCategories,1)).Master] = masterCategories{:};
for m = 1:size(masterCategories,1)
    master = masterCategories{m,1};
    pos = find(strcmp(masterCategory,master));
    subs = subCategory(pos);
    subCategories = unique(subs);
    subsCount = hist(categorical(subs),categorical(subCategories));
    subStruct = struct('Sub',{},'Count',{},'Articles',{});
    [subStruct(1:size(subCategories,1)).Sub] = subCategories{:};
    c = num2cell(subsCount);
    [subStruct(1:size(subCategories,1)).Count] = c{:};
    
    for s = 1:size(subCategories,1)
        sub = subCategories{s,1};
        pos = find(strcmp(subCategory,sub));
        articles = articleType(pos);
        articleTypes = unique(articles);
        articlesCount = hist(categorical(articles),categorical(articleTypes));
        articleStruct = struct('Article',{},'Count',{});
        [articleStruct(1:size(articleTypes,1)).Article] = articleTypes{:};
        a = num2cell(articlesCount);
        [articleStruct(1:size(articleTypes,1)).Count] = a{:};
        subStruct(s).Articles = articleStruct;
    end
%     [subStruct(1:size(subCategories,1)).Articles;
    CategoryMap(m).SubCategories = subStruct;
end

%% Remove duplicates
fprintf("Removing duplicates...\n");
% Check first sub categories
for m = 1:size(CategoryMap,2)
    subCategories = CategoryMap(m).SubCategories;
    subNames = {subCategories.Sub};
    for s = 1:length(subNames)
        name = subNames(s);
        for mm = 1:size(CategoryMap,2)
            if mm ~= m
                subCs = CategoryMap(mm).SubCategories;
                subNs = {subCs.Sub};
                if ~isempty(find(strcmp(name, subNs), 1))
                    fprintf("Duplicate found: %s in %s\n",string(name),string(CategoryMap(mm).Master));
                end
            end
        end
    end
end
% Check articles
indexItemsToRemove = zeros(1,3);
k = 1;
for m = 1:size(CategoryMap,2)
    subCategories = CategoryMap(m).SubCategories;
    for s = 1:size(subCategories,2)
        articles = subCategories(s).Articles;
        for a = 1:length(articles)
            articleName = articles(a).Article;
            articleCount = articles(a).Count;
            for mm = 1:size(CategoryMap,2)
                subCs = CategoryMap(mm).SubCategories;
                for ss = 1:size(subCs,2)
                    if ss ~= s
                        articlesTypes = subCs(ss).Articles;
                        articlesNames = {articlesTypes.Article};
                        articlesCounts = [articlesTypes.Count];
                        pos = find(strcmp(articleName, articlesNames),1);
                        if ~isempty(pos)
                            fprintf("Comparing: Master %s -> Sub %s -> Article %s with count %d\n",string(CategoryMap(m).Master),string(subCategories(s).Sub),string(articleName),articleCount);
                            fprintf("Duplicate found: Master %s -> Sub %s -> Article %s with count %d\n",string(CategoryMap(mm).Master),string(subCs(ss).Sub),string(articleName),articlesCounts(pos));
                            count = articlesCounts(pos);
                            if articleCount < count
                                fprintf("Removing the one with %d items\n\n",articleCount);
                                indexItemsToRemove(k,:) = [m s a];
                                k = k + 1;
                            else
                                if articleCount > count
                                    fprintf("Removing the one with %d items\n\n",count);
                                    indexItemsToRemove(k,:) = [mm ss pos];
                                    k = k + 1;
                                else
                                    fprintf("Number of items are equal!! Choose yourself!\n\n");
                                end
                            end
                            
                        end
                    end
                end
            end
        end
    end
end
indexItemsToRemove = unique(indexItemsToRemove,'rows');
% Remove Belts
CategoryMap(1).SubCategories(2).Articles(4) = [];
% Remove Tshirts
CategoryMap(1).SubCategories(3).Articles(2) = [];
% Remove shorts
CategoryMap(2).SubCategories(4).Articles(3) = [];
% Remove Dresses
CategoryMap(2).SubCategories(6).Articles(2) = [];
% Remove Belts
CategoryMap(2).SubCategories(6).Articles(1) = [];
% Remove Flip flops
CategoryMap(3).SubCategories(2).Articles(1) = [];
% Remove Sandals
CategoryMap(3).SubCategories(3).Articles(5) = [];
save('categoryMap.mat','CategoryMap');