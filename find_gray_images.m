function gray_images = find_gray_images(imagesIds)

    if exist('gray_images.mat','file') ~= 2
        gray_images = zeros(431,1);
        gi = 1;
        imdir = '../images/';
        for ii = 1:size(imagesIds,1)
            filename = strcat(imdir,num2str(imagesIds(ii)),'.jpg');
            im = imread(filename);
            if size(im,3) == 1
                gray_images(gi,1) = imagesIds(ii);
                gi = gi + 1;
            end
        end
        save('gray_images.mat','gray_images');
    else
        load('gray_images.mat','gray_images');
    end
end