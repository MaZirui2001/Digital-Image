I = imread('../image/lena.bmp');

% 对图像进行二值化处理
BW = imbinarize(I, OSTU(I) / 255);

% 显示原图像和分割结果
% figure;
subplot(1,3,1); imshow(I); title('原始图像');
subplot(1,3,2); imshow(BW); title('OTSU 分割后的二值化图像');
subplot(1,3,3); imshow(imbinarize(I, graythresh(I))); title('graythresh'); 

function T = OSTU(I)
    [r, l] = size(I);
    N = r * l;
    mu = zeros(256);
    w = zeros(256);
    for i = 0 : 255
        mu(i + 1) = sum(I(I == i)) / N;
        w(i + 1) = sum(I(I == i)) / N;
    end
    T = 0;
    max = 0;
    for i = 0 : 255
        sigma = w(i + 1) * (1 - w(i + 1)) * (mu(256) - 2 * mu(i + 1))^2;
        if sigma > max
            max = sigma;
            T = i;
        end
    end
end