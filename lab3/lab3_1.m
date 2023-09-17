% 用原始图像 lena.bmp 或 cameraman.bmp 分别加产生的 3%椒盐噪声、高斯噪声、随机噪声合成有噪声的图像并显示；
% 用均值滤波器去除图像中的噪声（选 3x3 窗口）并显示；

img = imread('../image/lena.bmp');

% 3%椒盐噪声
img_salt = imnoise(img, 'salt & pepper', 0.03);
% 3%高斯噪声
img_gaussian = imnoise(img, 'gaussian', 0, 0.03);
% 3%随机噪声
img_random = imnoise(img, 'speckle', 0.03);

% 用均值滤波器去除图像中的噪声（选 3x3 窗口）
img_salt_mean = imfilter(img_salt, fspecial('average', 3));
img_gaussian_mean = imfilter(img_gaussian, fspecial('average', 3));
img_random_mean = imfilter(img_random, fspecial('average', 3));

% 显示
figure;
subplot(2, 4, 1);
imshow(img);
title('原始图像');
subplot(2, 4, 2);
imshow(img_salt);
title('3%椒盐噪声');
subplot(2, 4, 3);
imshow(img_gaussian);
title('3%高斯噪声');
subplot(2, 4, 4);
imshow(img_random);
title('3%随机噪声');
subplot(2, 4, 5);
imshow(img_salt_mean);
title('3%椒盐噪声均值滤波');
subplot(2, 4, 6);
imshow(img_gaussian_mean);
title('3%高斯噪声均值滤波');
subplot(2, 4, 7);
imshow(img_random_mean);
title('3%随机噪声均值滤波');