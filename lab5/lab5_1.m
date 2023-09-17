% 读取原始图像
original = im2double(imread('../image/flower1.jpg'));

% 设置运动位移和方向
motion_angle = 45;
motion_distance = 30;

% 生成点扩散函数（PSF）
PSF = fspecial('motion', motion_distance, motion_angle);

% 对原始图像进行运动模糊
blurred = imfilter(original, PSF, 'conv', 'circular');


% 采用逆滤波恢复图像
deconvolved = deconvwnr(blurred, PSF);


% 采用维纳滤波恢复图像

SNR = 0.0001;
deconvolved_wiener = deconvwnr(blurred, PSF, SNR);

% 显示
figure;
subplot(2, 2, 1), imshow(original), title('原图');
subplot(2, 2, 2), imshow(blurred), title('运动模糊图像');
subplot(2, 2, 3), imshow(deconvolved), title('逆滤波恢复图像');
subplot(2, 2, 4), imshow(deconvolved_wiener), title('维纳滤波恢复图像');

% 添加高斯噪声
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', 0, noise_var);


% 采用逆滤波恢复有噪声图像
deconvolved_noisy = deconvwnr(blurred_noisy, PSF);


% 采用维纳滤波恢复有噪声图像
signal_var = var(blurred(:));
deconvolved_wiener_noisy = deconvwnr(blurred_noisy, PSF, noise_var / signal_var);


% 显示
figure;
subplot(2,2,1), imshow(original), title('原图');
subplot(2,2,2), imshow(blurred_noisy), title('运动模糊图像');
subplot(2,2,3), imshow(deconvolved_noisy), title('逆滤波恢复图像');
subplot(2,2,4), imshow(deconvolved_wiener_noisy), title('维纳滤波恢复图像');
