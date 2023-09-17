img = imread('../image/lena.bmp');

% 3%椒盐噪声
img_salt = imnoise(img, 'salt & pepper', 0.03);
% 3%高斯噪声
img_gaussian = imnoise(img, 'gaussian', 0, 0.03);
% 3%随机噪声
img_random = imnoise(img, 'speckle', 0.03);

% 用均值滤波器去除图像中的噪声（选 3x3 窗口）并显示；
img_salt_mean = imfilter(img_salt, fspecial('average', 3));
img_gaussian_mean = imfilter(img_gaussian, fspecial('average', 3));
img_random_mean = imfilter(img_random, fspecial('average', 3));

%用超限邻域平均法去除图像中的噪声：如果某个像素的灰度值大于其邻域像素的
%平均值，且达到了一定水平，则判断该像素为噪声，继而用邻域像素的均值取代这一像素值。
%（选 3x3 窗口，阈值为 15）
img_salt_overmean = overlimit(img_salt, 15);
img_gaussian_overmean = overlimit(img_gaussian, 15);
img_random_overmean = overlimit(img_random, 15);

% 用中值滤波器去除图像中的噪声(选 3x3 窗口做中值滤波)；
img_salt_median = medfilt2(img_salt, [3, 3]);
img_gaussian_median = medfilt2(img_gaussian, [3, 3]);
img_random_median = medfilt2(img_random, [3, 3]);

% 用超限中值滤波器去除图像中的噪声：当某个像素的灰度值超过窗口中像素灰度值排序中间的那个值，
% 且达到一定水平时，则判断该点为噪声，用灰度值排序中间的那个值来代替；否则还是保持原来的灰度值。
img_salt_overmedian = adpmedian(img_salt, 3, 15);
img_gaussian_overmedian = adpmedian(img_gaussian, 3, 15);
img_random_overmedian = adpmedian(img_random, 3, 15);

% 显示
figure;
subplot(3, 5, 1); imshow(img_salt); title('3%椒盐噪声');
subplot(3, 5, 2); imshow(img_salt_mean); title('均值滤波');
subplot(3, 5, 3); imshow(img_salt_overmean); title('超限邻域平均法');
subplot(3, 5, 4); imshow(img_salt_median); title('中值滤波');
subplot(3, 5, 5); imshow(img_salt_overmedian); title('超限中值滤波');
subplot(3, 5, 6); imshow(img_gaussian); title('3%高斯噪声');
subplot(3, 5, 7); imshow(img_gaussian_mean); title('均值滤波');
subplot(3, 5, 8); imshow(img_gaussian_overmean); title('超限邻域平均法');
subplot(3, 5, 9); imshow(img_gaussian_median); title('中值滤波');
subplot(3, 5, 10); imshow(img_gaussian_overmedian); title('超限中值滤波');
subplot(3, 5, 11); imshow(img_random); title('3%随机噪声');
subplot(3, 5, 12); imshow(img_random_mean); title('均值滤波');
subplot(3, 5, 13); imshow(img_random_overmean); title('超限邻域平均法');
subplot(3, 5, 14); imshow(img_random_median); title('中值滤波');
subplot(3, 5, 15); imshow(img_random_overmedian); title('超限中值滤波');




function img = overlimit(img, threshold)
    [m, n] = size(img);
    for i = 2:m-1
        for j = 2:n-1
            if abs(img(i, j) - mean(mean(img(i-1:i+1, j-1:j+1)))) > threshold
                img(i, j) = mean(mean(img(i-1:i+1, j-1:j+1)));
            end
        end
    end
end

function img = adpmedian(img, winsize, thres)
    [m, n] = size(img);
    img = double(img);
    bound = ceil(winsize/2);
    for i = 1:m
        for j = 1:n
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