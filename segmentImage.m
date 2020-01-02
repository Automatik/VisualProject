function segmentedImage = segmentImage(image)
    
    image = colorConstancy(image,'white patch');

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
    T_area = 0.5; %Threshold area
    T_center = 0.75; 
    max_area = T_area * size(gray,1) * size(gray,2);
    
    % rimozione rumore / artefatti
    filtered = imgaussfilt(gray,1.5, 'FilterSize',7);
    
    % Valutazione colore dello sfondo guardando la parte centrale
    % dell'immagine
    x = floor((1 - T_center) * size(filtered,2));
    y = floor((1 - T_center) * size(filtered,1));
    width = floor(T_center * size(filtered,2));
    height = floor(T_center * size(filtered,1));
    rect = [x y width-x height-y];
    imageCenter = imcrop(filtered,rect);
    
    if mean2(imageCenter) > 0.55 
        hasWhiteBackground = true;
    else
        hasWhiteBackground = false;
    end

    kernel = strel('diamond',7);
    
    if hasWhiteBackground
        T = adaptthresh(filtered,0.65);
        bin = imbinarize(filtered,T);
        bin2 = imclose(bin,kernel);
        bw3 = bwareaopen(bin2,500);
        compl = ~bw3;
    else
        T = adaptthresh(filtered,0.6);
        bin = imbinarize(filtered,T);
        bin2 = imerode(bin,kernel);
        bw3 = bwareaopen(bin2,500);
        compl = bw3;
    end
         
    % Cerchiamo la componente connessa che può essere l'oggetto
    stats = regionprops(compl,'BoundingBox','Centroid','Extent','Solidity','Extrema','FilledArea');
    bbox = cell2mat({stats.BoundingBox}.');
    [~, index] = sortrows(bbox,[3 4],'descend');
    sortedStats = stats(index);
    if hasWhiteBackground
        [acceptedBbox, index2] = discardBboxes(sortedStats, max_area, center, max_distance);
    else
        [acceptedBbox, index2] = discardBboxesBlack(sortedStats, max_area, center, max_distance);
    end
    sortedStats(index2,:) = [];
    %figure,imshow(compl); for ii = 1:size(sortedBbox,1) rectangle('Position', sortedBbox(ii,:),'EdgeColor','r'); text(sortedBbox(ii,1),sortedBbox(ii,2),num2str(ii), 'Color','g'); end
    if size(acceptedBbox,1) > 0
        bb = acceptedBbox(1,:);
%     figure,imshow(compl),hold on;
%     rectangle('Position',bb,'EdgeColor','r');
%         segmentedImage = imcrop(compl,bb);
        cropped = imcrop(im,bb);
        segmentedImage = imresize(imgaussfilt3(cropped,1.5),[80 60]);
    else
        segmentedImage = [];
    end
end

function [acceptedBbox, idx] = discardBboxes(stats, max_area, center, max_distance)
    bbox = cell2mat({stats.BoundingBox}.');
    T_solidity1 = 0.5;
    T_solidity2 = 0.7;
    T_extent = 0.45;
    minRatio = 0.5;
    maxRatio = 2.1;
    maxRatio2 = 2.51;
    tempIdx = zeros(size(bbox,1),1);
    jj = 1;
    for ii = 1:size(bbox,1)
        centroid = stats(ii).Centroid;
        centerX = centroid(1);
        centerY = centroid(2);
        width = bbox(ii,3);
        height = bbox(ii,4);
        ratio = width / height;
        area = width * height;
        distanceX = abs(center(1) - centerX);
        distanceY = abs(center(2) - centerY);
        solidity = stats(ii).Solidity;
        extent = stats(ii).Extent;
        if (ratio < minRatio || ratio > maxRatio) && (ratio > maxRatio2 || solidity < T_solidity2)
            tempIdx(jj) = ii;
            jj = jj + 1;
        else
            if area >= max_area
                tempIdx(jj) = ii;
                jj = jj + 1;
            else
                if distanceX > max_distance(1) || distanceY > max_distance(2)
                    tempIdx(jj) = ii;
                    jj = jj + 1;
                else
                    if solidity < T_solidity1 || extent < T_extent
                        tempIdx(jj) = ii;
                        jj = jj + 1;
                    end
                end
            end
        end
    end
    idx = tempIdx(1:jj);
    acceptedBbox = bbox;
    acceptedBbox(idx,:) = [];
end

function [acceptedBbox, idx] = discardBboxesBlack(stats, max_area, center, max_distance)
    bbox = cell2mat({stats.BoundingBox}.');
    minRatio = 0.5;
    maxRatio = 1.6;
    T_diff = 150;
    T_extent = 0.8;
    tempIdx = zeros(size(bbox,1),1);
    jj = 1;
    for ii = 1:size(bbox,1)
        centroid = stats(ii).Centroid;
        centerX = centroid(1);
        centerY = centroid(2);
        width = bbox(ii,3);
        height = bbox(ii,4);
        ratio = width / height;
        area = width * height;
        distanceX = abs(center(1) - centerX);
        distanceY = abs(center(2) - centerY);
        extrema = stats(ii).Extrema;
        TL = extrema(8,:);
        TR = extrema(3,:);
        BR = extrema(4,:);
        BL = extrema(7,:);
        myextent = stats(ii).FilledArea / area;
        if (ratio < minRatio || ratio > maxRatio)
            tempIdx(jj) = ii;
            jj = jj + 1;
        else
            if area >= max_area
                tempIdx(jj) = ii;
                jj = jj + 1;
            else    
                if distanceX > max_distance(1) || distanceY > max_distance(2)
                    tempIdx(jj) = ii;
                    jj = jj + 1;
                else
                    if abs(pdist2(TL,TR) - pdist2(BL,BR)) > T_diff || abs(pdist2(TL,BL) - pdist2(TR,BR)) > T_diff 
                        tempIdx(jj) = ii;
                        jj = jj + 1;
                    else
                        if myextent < T_extent
                            tempIdx(jj) = ii;
                            jj = jj + 1;
                        end
                    end
                end
            end
        end
    end
    idx = tempIdx(1:jj);
    acceptedBbox = bbox;
    acceptedBbox(idx,:) = [];
end