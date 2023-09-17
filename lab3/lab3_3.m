% 用中值滤波器去除图像中的噪声(选 3x3 窗口做中值滤波)；
img = imread('../image/lena.bmp');

% 3%椒盐噪声
img_salt = imnoise(img, 'salt & pepper', 0.03);
% 3%高斯噪声
img_gaussian = imnoise(img, 'gaussian', 0, 0.03);
% 3%随机噪声
img_random = imnoise(img, 'speckle', 0.03);

% 3x3 中值滤波
img_salt_med = medfilt2(img_salt, [3, 3]);
img_gaussian_med = medfilt2(img_gaussian, [3, 3]);
img_random_med = medfilt2(img_random, [3, 3]);

% 显示图像
figure;
subplot(3, 2, 1);imshow(img_salt);title('3%椒盐噪声');
subplot(3, 2, 2);imshow(img_salt_med);title('3%椒盐噪声中值滤波');
subplot(3, 2, 3);imshow(img_gaussian);title('3%高斯噪声');
subplot(3, 2, 4);imshow(img_gaussian_med);title('3%高斯噪声中值滤波');
subplot(3, 2, 5);imshow(img_random);title('3%随机噪声');
subplot(3, 2, 6);imshow(img_random_med);title('3%随机噪声中值滤波');

