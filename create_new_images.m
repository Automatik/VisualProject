function create_new_images(imagesIds, masterCategory, subCategory, articleType)
    % Mean Images for article types
    objMean = 600;
    articleCategories = categories(categorical(articleType));
    % startingId = max(imagesIds) + 1;
    startingId = 60001;
    imdir = '../newImages/';
    newImagesIds = cell(1,1);
    newMasterCategory = cell(1,1);
    newSubCategory = cell(1,1);
    newArticleType = cell(1,1);
    counter = 1;
    id = startingId;
    for ii = 1:size(articleCategories,1)
        article_category = articleCategories{ii,1};
        articles = find(strcmp(articleType, article_category));
        if size(articles,1) < objMean
            imagesToCreate = objMean - size(articles,1);
            imagesCreated = 0;
            fprintf("Article: %s Current Images: %d Images to create: %d\n",article_category,size(articles,1),imagesToCreate);
            jj = 1;
            while ~isMeanReached(imagesCreated, imagesToCreate) && jj <= size(articles,1)
                index = articles(jj);
                image_id = imagesIds(index);
                master_category = masterCategory{index};
                sub_category = subCategory{index};
                im = imread(strcat('../images/',num2str(image_id),'.jpg'));
                if size(im,3) == 1
                    isGrayImage = true;
                else
                    isGrayImage = false;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    F = fspecial('gaussian',3,1.5);
                    newImage = imfilter(im,F);
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    F = fspecial('gaussian',3,0.5);
                    newImage = imfilter(im,F);
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    F = fspecial('average',3);
                    newImage = imfilter(im,F);
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    if isGrayImage
                        newImage = medfilt2(im,[3 3]);
                    else
                        newImage = medfilt3(im, [3 3 3]);
                    end
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    newImage = imadjust(im,[],[],2.5);
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    newImage = imadjust(im,[],[],0.5);
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
                if ~isMeanReached(imagesCreated, imagesToCreate)
                    newImage = imtranslate(im, [5 5],'FillValues',255);
                    imwrite(newImage,strcat(imdir,num2str(id),'.jpg'));
                    newImagesIds{counter,1} = id;
                    newMasterCategory{counter,1} = master_category;
                    newSubCategory{counter,1} = sub_category;
                    newArticleType{counter,1} = article_category;
                    counter = counter + 1;
                    id = id + 1;
                    imagesCreated = imagesCreated + 1;
                end
            end
        end
    end
    save('newImagesLabels.mat','newImagesIds','newMasterCategory','newSubCategory','newArticleType');
end

function meanReached = isMeanReached(imagesCreated, imagesToCreate)
    if imagesCreated >= imagesToCreate
        meanReached = true;
    else
        meanReached = false;
    end
end