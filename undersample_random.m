function indexesToDelete = undersample_random(articleType)
    
    articles = {
        'Belts';
        'Briefs';
        'Sandals';
        'Flip Flops';
        'Wallets';
        'Sunglasses';
        'Heels';
        'Handbags';
        'Tops';
        'Kurtas';
        'Sports Shoes';
        'Watches';
        'Casual Shoes';
        'Shirts';
        'Tshirts'
        };
    
    objMean = 600;
    indexesToDelete = [];
    
    for ii = 1:size(articles,1)
        pos = find(strcmp(articles{ii,1},articleType));
        numImages = size(pos,1);
        randomValues = randperm(numImages, numImages - objMean);
        selectedIndex = pos(randomValues.');
        indexesToDelete = [indexesToDelete; selectedIndex];
    end

end