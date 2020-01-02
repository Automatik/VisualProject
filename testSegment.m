% im1 = imread('testImages/test1.jpg');
% im2 = imread('testImages/test2.jpg');
% im10 = imread('testImages/test10.jpg');
% 
% segmentImage(im1);
% segmentImage(im2);
% segmentImage(im3);

% im = imread('testImages/test3.jpg');
% s = segmentImage(im);

testdir = 'testImages';
destdir = 'testSegment';
files = dir(testdir);
if exist(destdir,'dir') ~= 7
    mkdir(destdir);
end
for f = 3:length(files)
    filename = files(f).name;
    fprintf("Segmenting %s\n",filename);
    im = imread(strcat(testdir,'/',filename));
%     im = imrotate(im,-90);
    res = segmentImage(im);
    if isempty(res)
        fprintf("Image not segmented\n");
    else
        imwrite(res,strcat(destdir,'/seg_',filename));
    end
end
