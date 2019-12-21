function segmentedImage = segmentImage(image)
    im = im2double(image);
    if size(image,3) == 3
        gray = rgb2gray(im);
    else
        gray = im;
    end

    T_distance = 0.25; %Threshold distance from center
    center = [size(gray,2) / 2, size(gray,1) / 2];
    max_distance = [abs(T_distance * size(gray,2) - center(1))
                    abs(T_distance * size(gray,1) - center(2))];
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
    %compl = imclearborder(compl); % oppure prendere elemento più centrale

    stats = regionprops(compl,'BoundingBox');
    bbox = cell2mat({stats.BoundingBox}.');
    sortedBbox = sortrows(bbox,[3 4],'descend');
    acceptedBbox = discardBboxes(sortedBbox, max_area, center, max_distance);
    
    if size(acceptedBbox,1) > 0
        bb = acceptedBbox(1,:);
%     figure,imshow(compl),hold on;
%     rectangle('Position',bb,'EdgeColor','r');

        segmentedImage = imcrop(im,bb);
    else
        segmentedImage = image;
    end
end

function acceptedBbox = discardBboxes(bbox, max_area, center, max_distance)
    minRatio = 0.5;
    maxRatio = 1.5;
    idx = [];
    for ii = 1:size(bbox,1)
        centerX = bbox(ii,1);
        centerY = bbox(ii,2);
        width = bbox(ii,3);
        height = bbox(ii,4);
        ratio = width / height;
        area = width * height;
        distanceX = abs(center(1) - centerX);
        distanceY = abs(center(2) - centerY);
        if ratio < minRatio || ratio > maxRatio || area >= max_area || distanceX > max_distance(1) || distanceY > max_distance(2)
            idx = [idx; ii];
        end
    end
    acceptedBbox = bbox;
    acceptedBbox(idx,:) = [];
end
