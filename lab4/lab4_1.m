% 读取图像并获取灰度图像
rect1 = imread('../image/Rect1.bmp');
rect2 = imread('../image/Rect2.bmp');

% 对图像进行二维傅里叶变换
F1 = fft2(rect1);
F2 = fft2(rect2);

% 将低频移到中心点
F1_shift = log(abs(fftshift(F1))+1);
F2_shift = log(abs(fftshift(F2))+1);


% 对 F1 和 F2 进行反变换得到图像
IF1_abs = uint8(ifft2(abs(F1)));
IF2_abs = uint8(ifft2(abs(F2)));

% 获取 F1 和 F2 的相位
phase1 = angle(F1);
phase2 = angle(F2);


% 对新的复数数组进行反变换得到图像
IF1_angle = uint8(abs(ifft2(10000*exp(1i*phase1))));
IF2_angle = uint8(abs(ifft2(10000*exp(1i*phase2))));

% 获取 F1 和 F2 的共轭
conjF1 = conj(F1);
conjF2 = conj(F2);

% 对新的复数数组进行反变换得到图像
IF1_conj = ifft2(conjF1);
IF2_conj = ifft2(conjF2);

figure;
subplot(2,5,1);imshow(rect1);title('rect 1');
subplot(2,5,2);imshow(F1_shift,[]);title('频谱');
subplot(2,5,3);imshow(IF1_abs);title('幅度反变换');
subplot(2,5,4);imshow(IF1_angle);title('相位反变换');
subplot(2,5,5);imshow(IF1_conj,[]);title('共轭反变换');
subplot(2,5,6);imshow(rect2);title('rect 2');
subplot(2,5,7);imshow(F2_shift,[]);title('频谱');
subplot(2,5,8);imshow(IF2_abs);title('幅度反变换');
subplot(2,5,9);imshow(IF2_angle);title('相位反变换');
subplot(2,5,10);imshow(IF2_conj,[]);title('共轭反变换');
