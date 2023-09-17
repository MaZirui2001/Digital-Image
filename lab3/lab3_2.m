%用超限邻域平均法去除图像中的噪声：如果某个像素的灰度值大于其邻域像素的
%平均值，且达到了一定水平，则判断该像素为噪声，继而用邻域像素的均值取代这一像素值。
img = imread('../image/lena.bmp');
% 3%椒盐噪声
img_salt = imnoise(img, 'salt & pepper', 0.03);
% 3%高斯噪声
img_gaussian = imnoise(img, 'gaussian', 0, 0.03);
% 3%随机噪声
img_random = imnoise(img, 'speckle', 0.03);

% 超限邻域平均法如果某个像素的灰度值大于其邻域像素的平均值，且达到了一定水平，则判断该像素为噪声
% 继而用邻域像素的均值取代这一像素值。
img_salt_3 = overlimit(img_salt, 50);
img_gaussian_3 = overlimit(img_gaussian, 50);
img_random_3 = overlimit(img_random, 50);
% 显示
figure;
subplot(3, 2, 1); imshow(img_salt); title('3%椒盐噪声');
subplot(3, 2, 2); imshow(img_salt_3); title('超限邻域平均法去除椒盐噪声');
subplot(3, 2, 3); imshow(img_gaussian); title('3%高斯噪声');
subplot(3, 2, 4); imshow(img_gaussian_3); title('超限邻域平均法去除高斯噪声');
subplot(3, 2, 5); imshow(img_random); title('3%随机噪声');
subplot(3, 2, 6); imshow(img_random_3); title('超限邻域平均法去除随机噪声');

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

