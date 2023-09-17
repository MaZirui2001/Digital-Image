% open a picture
img_org = imread('../image/alphabet1.jpg');
% input size
times = input("resize times: ");
% resize nearest
img_near = imresize(img_org, times, 'nearest');
% resize bilinear
img_bil = imresize(img_org, times, 'bilinear');
% show 
figure;
imshow(img_org);
title('origin image');
figure;
imshow(img_near);
title('nearest resize image');
figure;
imshow(img_bil);
title('bilinear res9ze image')