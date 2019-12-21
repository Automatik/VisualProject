function segmentedImage = segmentImage(image)
    im = im2double(image);
    if size(image,3) == 3
        gray = rgb2gray(im);
    else
        gray = im;
    end
    
    T_area = 0.75; %Threshold area
    max_area = T_area * size(gray,1) * size(gray,2);
    
    % rimozione rumore / artefatti
    F = fspecial('gaussian', 15, 1.5);
    filtered = imfilter(gray,F);
    
    if mean2(filtered) > 0.4
        hasWhiteBackground = true;
    else
        hasWhiteBackground = false;
    end
    
    bw = filtered > 0.7; %altrimenti usare adaptthresh
    bw2 = imclose(bw, strel('disk',7,4));
    bw3 = bwareaopen(bw2,1000);
    
    % lo schermo del monitor è necessario rimanga in primo piano,
    % altrimenti sbaglia a capire il colore del background
    if hasWhiteBackground
        compl = imcomplement(bw3);
    else
        compl = bw3;
    end
%     imshow(compl);
    compl = imclearborder(compl); % oppure prendere elemento più centrale

    stats = regionprops(compl,'BoundingBox');
    bbox = cell2mat({stats.BoundingBox}.');
    sortedBbox = sortrows(bbox,[3 4],'descend');
    acceptedBbox = discardBboxes(sortedBbox, max_area);
     
    bb = acceptedBbox(1,:);
%     figure,imshow(compl),hold on;
%     rectangle('Position',bb,'EdgeColor','r');

    segmentedImage = imcrop(im,bb);
end

function acceptedBbox = discardBboxes(bbox, max_area)
    idx = [];
    for ii = 1:size(bbox,1)
        width = bbox(ii,3);
        height = bbox(ii,4);
        ratio = width / height;
        area = width * height;
        if ratio < 0.5 || ratio > 1.5 || area >= max_area
            idx = [idx; ii];
        end
    end
    acceptedBbox = bbox;
    acceptedBbox(idx,:) = [];
end
