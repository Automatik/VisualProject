im1 = imread('../test1.jpg');
im2 = imread('../test2.jpg');

g1 = rgb2gray(im1);
g2 = rgb2gray(im2);

%rimuove artefatti immagini
bw = g1 > 180;
close = imclose(bw, strel('disk',7,4));
compl = imcomplement(close);
imshow(compl);

stats = regionprops(compl,'BoundingBox');
figure,imshow(compl),hold on;
rectangle('Position',stats(82).BoundingBox,'EdgeColor','r');
