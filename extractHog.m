function [BOW_tr, C] = extractHog(imds)
    imdsAug = augmentedImageDatastore([80 60],imds,'ColorPreprocessing','gray2rgb');
    
    %griglia
    disp('creazione griglia');
    pointPosition=[];
    %porto tutte le img alle stesse dimensioni, scelgo dim immagine e step per
    %punto successivo
    featStep=30; %TBD
    imsize=500; %TBD
    %riconduco tutto a img quadrate di lato 500
    tic
    for ii=featStep:featStep:imsize-featStep
        for jj=featStep:featStep:imsize-featStep
            pointPosition = [pointPosition; ii jj];
        end
    end
    toc
    
    %hogFeatures = zeros(size(imds.Files,1), 1944);
    %hogFeatures = zeros(size(imds.Files,1), 768);
    %hogFeatures = zeros(size(imds.Files,1), 190);
%     hogFeatures = zeros(size(imds.Files,1), 729);
    hogFeatures = zeros(size(imds.Files,1)*size(pointPosition,1),36);
    labels = zeros(size(imds.Files,1)*size(pointPosition,1),1);
    h = 1;
    k = 1;
%     for ii = 1:size(imds.Files,1)
%         hog = trainHogFeatures(h,:);
%         hogFeatures(k:k+1943,:) = hog.';
%         labels(k:k+1943,:) = repmat(h, size(hog,2), 1);
%         k = k+1944;
%         h = h + 1;
%     end
    ii = 1;
    step = size(pointPosition,1);
    while ii <= size(imds.Files,1)
        to = ii + 4; % 99;
        data = readByIndex(imdsAug,ii:to);
        images = data{:,1};
        for jj = 1:size(images,1)
            fprintf("%d\n",h);
            img = images{jj,1};
            img = imresize(img, [imsize imsize]);
            img = rgb2gray(img);
            hog = extractHOGFeatures(img,pointPosition,'CellSize',[8 8],'BlockSize',[2 2]);
            hogFeatures(k:k+step-1,:) = hog;
            labels(k:k+step-1,:) = repmat(h, size(hog,1), 1);
            k = k+step;
%             R = imhist(img(:,:,1)).';
%             G = imhist(img(:,:,2)).';
%             B = imhist(img(:,:,3)).';
%             normR = R ./ norm(R);
%             normG = G ./ norm(G);
%             normB = B ./ norm(B);
%             hog = [normR normG normB] ./ norm([normR normG normB]);
%             hog = Extract_features2(img,imfinfo(imdsAug.Files{h}));
%             lbpR = extractLBPFeatures(img(:,:,1),'NumNeighbors',16,'Radius',2);
%             lbpG = extractLBPFeatures(img(:,:,2),'NumNeighbors',16,'Radius',2);
%             lbpB = extractLBPFeatures(img(:,:,3),'NumNeighbors',16,'Radius',2);
%             lbpR = lbpR ./ norm(lbpR);
%             lbpG = lbpG ./ norm(lbpG);
%             lbpB = lbpB ./ norm(lbpB);
%             hog = [lbpR lbpG lbpB] ./ norm([lbpR lbpG lbpB]);
%             hogFeatures(h,:) = hog;
            h = h + 1;
        end
        ii = to + 1;
    end
    
    fprintf("KMeans\n");
    K = 100;
    tic
    [IDX,C]=kmeans(hogFeatures,K);
    toc
    
    disp('rappresentazione BOW training');
    BOW_tr = zeros(h,K);
    tic
    for ii = 1:h
        %u = find(labels == ii);
        %imfeaturesIDX = IDX(u);
        imfeaturesIDX = IDX(labels == ii);
        H = hist(imfeaturesIDX,1:K);
        H = H ./ sum(H);
        BOW_tr(ii,:) = H;
    end
    toc
end

% hogFeatures = zeros(size(imdsMaster.Files,1), 1944);
% 
% for ii = 1:size(imdsMaster.Files,1)
%     img = readimage(imdsMaster, ii);
%     if size(img,3) > 1
%         img = rgb2gray(img);
%     end
%     if isequal(size(img),[80 60])
%         hog = extractHOGFeatures(img,'CellSize',[8 8],'BlockSize',[2 2]);
%         hogFeatures(ii,:) = hog;
%     else
%         fprintf("Image Index: %d\n",ii);
%     end
% end

