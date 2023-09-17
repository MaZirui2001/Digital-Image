%要求对 blood.bmp、 lena.bmp，分别用前面所述的算子进行边缘检测，显示边缘检测结果图像。
% Roberts算子, Sobel算子, Prewitt算子, 拉普拉斯算子, Canny算子

% 读取图像
lena = imread('../image/lena.bmp');
blood = imread('../image/blood.bmp');

% Roberts算子
lena_roberts = edge(lena, 'Roberts');
blood_roberts = edge(blood, 'Roberts');

% Sobel算子
lena_sobel = edge(lena, 'Sobel');
blood_sobel = edge(blood, 'Sobel');

% Prewitt算子
lena_prewitt = edge(lena, 'Prewitt');
blood_prewitt = edge(blood, 'Prewitt');

% 4邻域拉普拉斯算子
lena_laplacian1 = edge(lena, 'log');
blood_laplacian1 = edge(blood, 'log');
% 8邻域拉普拉斯算子
lena_laplacian2 = edge(lena, 'log', 0, 1);
blood_laplacian2 = edge(blood, 'log', 0, 1);

% Canny算子
lena_canny = edge(lena, 'Canny');
blood_canny = edge(blood, 'Canny');

% 显示图像
figure;
subplot(2, 7, 1); imshow(lena); title('lena');
subplot(2, 7, 2); imshow(lena_roberts); title('Roberts');
subplot(2, 7, 3); imshow(lena_sobel); title('Sobel');
subplot(2, 7, 4); imshow(lena_prewitt); title('Prewitt');
subplot(2, 7, 5); imshow(lena_laplacian1); title('Laplacian4');
subplot(2, 7, 6); imshow(lena_laplacian2); title('Laplacian8');
subplot(2, 7, 7); imshow(lena_canny); title('Canny');
subplot(2, 7, 8); imshow(blood); title('blood');
subplot(2, 7, 9); imshow(blood_roberts); title('Roberts');
subplot(2, 7, 10); imshow(blood_sobel); title('Sobel');
subplot(2, 7, 11); imshow(blood_prewitt); title('Prewitt');
subplot(2, 7, 12); imshow(blood_laplacian1); title('Laplacian4');
subplot(2, 7, 13); imshow(blood_laplacian2); title('Laplacian8');
subplot(2, 7, 14); imshow(blood_canny); title('Canny');