% open a picture
img_org = imread('../image/alphabet1.jpg');
% input angle
angle = input("angle: ");
% rotate nearest
img_near = imrotate(img_org, angle, 'nearest', 'crop');
% rotate bilinear
img_bil = imrotate(img_org, angle, 'bilinear', 'crop');
% show 
figure;
imshow(img_org);
title('origin image');
figure;
imshow(img_near);
title('nearest rotate image');
figure;
imshow(img_bil);
title('bilinear rotate image')