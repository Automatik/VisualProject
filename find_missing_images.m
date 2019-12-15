function missing_images = find_missing_images(imagesIds)

    if exist('missing_images.mat','file') ~= 2
        missing_images = [];
        imdir = '../images/';
        for ii = 1:size(imagesIds,1)
            filename = strcat(imdir,num2str(imagesIds(ii)),'.jpg');
            if exist(filename,'file') ~= 2
                missing_images = [missing_images; imagesIds(ii)];
            end
        end
        save('missing_images.mat','missing_images');
    else
        load('missing_images.mat','missing_images');
    end

end
