% open a picture
img_org = imread('../image/alphabet1.jpg');
% input mv scale
lr = input('input lr: ');
ud = input('input ud: ');
% move
se = translate(strel(1), [ud, lr]);
img_mv = imdilate(img_org, se);
% show
figure;
imshow(img_org);
title('origin image');
figure;
imshow(img_mv);
title('move image');