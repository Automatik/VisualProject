% im1 = imread('testImages/test1.jpg');
% im2 = imread('testImages/test2.jpg');
% im10 = imread('testImages/test10.jpg');
% 
% segmentImage(im1);
% segmentImage(im2);
% segmentImage(im3);

im = imread('testImages/test2.jpg');
s = segmentImage(im);

% testdir = 'testImages';
% files = dir(testdir);
% if exist('testSegment','dir') ~= 7
%     mkdir testSegment;
% end
% for f = 3:length(files)
%     filename = files(f).name;
%     fprintf("Segmenting %s\n",filename);
%     im = imread(strcat(testdir,'/',filename));
%     res = segmentImage(im);
%     imwrite(res,strcat('testSegment/seg_',filename));
% end
