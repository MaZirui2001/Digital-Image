% 用超限中值滤波器去除图像中的噪声：当某个像素的灰度值超过窗口中像素灰度值排序中间的那个值，且达到一定水平时，则判断该点为噪声，用灰度值排序中间的那个值来代替；否则还是保持原来的灰度值。

img = imread('../image/lena.bmp');

% 3%椒盐噪声
img_salt = imnoise(img, 'salt & pepper', 0.03);
% 3%高斯噪声
img_gaussian = imnoise(img, 'gaussian', 0, 0.03);
% 3%随机噪声
img_random = imnoise(img, 'speckle', 0.03);

thres = 30;
winsize = 3;
% 3*3超限中值滤波器
img_salt_3 = adpmedian(img_salt, winsize, thres);
img_gaussian_3 = adpmedian(img_gaussian, winsize, thres);
img_random_3 = adpmedian(img_random, winsize, thres);
% 显示
subplot(3, 2, 1); imshow(img_salt); title('3%椒盐噪声');
subplot(3, 2, 2); imshow(img_salt_3); title('3*3超限中值滤波器');
subplot(3, 2, 3); imshow(img_gaussian); title('3%高斯噪声');
subplot(3, 2, 4); imshow(img_gaussian_3); title('3*3超限中值滤波器');
subplot(3, 2, 5); imshow(img_random); title('3%随机噪声');
subplot(3, 2, 6); imshow(img_random_3); title('3*3超限中值滤波器');

% 用超限中值滤波器去除图像中的噪声：当某个像素的灰度值超过窗口中像素灰度值排序中间的那个值，且达到一定水平时，则判断该点为噪声，用灰度值排序中间的那个值来代替；否则还是保持原来的灰度值。
function img = adpmedian(img, winsize, thres)
    [m, n] = size(img);
    img = double(img);
    bound = ceil(winsize/2);
    for i = 1:m
        for j = 1:n
            % 3*3窗口
            if i > bound && i < m-bound+1 && j > bound && j < bound+1
                window = img(i-bound:i+bound, j-bound:j+bound);
                % 排序
                window = sort(window(:));
                % 中值
                median = window(ceil(length(window)/2));
                % 当前像素值
                pixel = img(i, j);
                % 当前像素值与中值的差
                diff = abs(pixel - median);
                if diff > thres
                    img(i, j) = median;
                end
            end
        end
    end
    img = uint8(img);
end