% 读入图像 pout.bmp 和 Girl.bmp
pout = imread('../image/pout.bmp');
girl = imread('../image/Girl.bmp');

% 理想低通滤波器
D0 = 30; % 截止频率
H = lpfilter('ideal', size(pout,1), size(pout,2), D0);
lp_pout = freqfilter(pout, H);
H = lpfilter('ideal', size(girl,1), size(girl,2), D0);
lp_girl = freqfilter(girl, H);

% 巴特沃斯低通滤波器
D0 = 30; % 截止频率
n = 1; % 阶数
H = lpfilter('btw', size(pout,1), size(pout,2), D0, n);
lp_pout_btw = freqfilter(pout, H);
H = lpfilter('btw', size(girl,1), size(girl,2), D0, n);
lp_girl_btw = freqfilter(girl, H);

% 高斯低通滤波器
D0 = 30; % 截止频率
n = 2;
H = lpfilter('gaussian', size(pout,1), size(pout,2), D0, n);
lp_pout_gauss = freqfilter(pout, H);
H = lpfilter('gaussian', size(girl,1), size(girl,2), D0, n);
lp_girl_gauss = freqfilter(girl, H);

% 显示不同低通滤波器处理后的图像
figure;
subplot(2,4,1), imshow(pout, []), title('pout原图');
subplot(2,4,2), imshow(lp_pout, []), title('理想低通滤波器');
subplot(2,4,3), imshow(lp_pout_btw, []), title('巴特沃斯低通滤波器');
subplot(2,4,4), imshow(lp_pout_gauss, []), title('高斯低通滤波器');
subplot(2,4,5), imshow(girl, []), title('girl原图');
subplot(2,4,6), imshow(lp_girl, []), title('理想低通滤波器');
subplot(2,4,7), imshow(lp_girl_btw, []), title('巴特沃斯低通滤波器');
subplot(2,4,8), imshow(lp_girl_gauss, []), title('高斯低通滤波器');

function H = lpfilter(type, M, N, D0, n)
    
    % Initialize filter
    % Compute distance from center for each pixel
    % D = zeros(M, N);
    [U,V] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);%构建坐标
    D = hypot(U,V);%计算中心偏移距离
    
    % Generate filter based on type
    switch type
        case 'ideal'
            H = D <= D0;
        case 'btw'
            if n == 0
                error('The order of Butterworth filter cannot be 0.');
            end
            H = 1./(1 + (D./D0).^(2*n));
        case 'gaussian'
            H = exp(-(D./D0).^n);
        otherwise
            error('Unsupported filter type.');
    end
    
    end
    function output = freqfilter(img, H)
        
        % Compute the Fourier transform of the input image
        F = fft2(img);
        
        % Shift the zero-frequency component to the center of the spectrum
        F = fftshift(F);
        
        % Apply the frequency domain filter to the spectrum
        G = F .* H;
        
        % Shift the zero-frequency component back to the top-left corner
        G = ifftshift(G);
        
        % Compute the inverse Fourier transform to obtain the filtered image
        output = abs(ifft2(G));
    
    end