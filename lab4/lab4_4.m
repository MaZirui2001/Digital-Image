% 读入图像 pout.bmp 和 Girl.bmp
pout = imread('../image/pout.bmp');
girl = imread('../image/Girl.bmp');

% 理想高通滤波器
D0 = 15;
H = lpfilter('ideal', size(pout, 1), size(pout, 2), D0);
lp_pout = freqfilter(pout, H);
H = lpfilter('ideal', size(girl, 1), size(girl, 2), D0, 2);
lp_girl = freqfilter(girl, H);

% 巴特沃斯高通滤波器
D0 = 15;
n = 1;
H = lpfilter('btw', size(pout, 1), size(pout, 2), D0, n);
lp_pout_btw = freqfilter(pout, H);
H = lpfilter('btw', size(girl, 1), size(girl, 2), D0, n);
lp_girl_btw = freqfilter(girl, H);

% 高斯高通滤波器
D0 = 15;
n = 2;
H = lpfilter('gaussian', size(pout, 1), size(pout, 2), D0, n);
lp_pout_gaussian = freqfilter(pout, H);
H = lpfilter('gaussian', size(girl, 1), size(girl, 2), D0, n);
lp_girl_gaussian = freqfilter(girl, H);

% 显示结果
figure;
subplot(2, 4, 1), imshow(pout, []), title('pout原图');
subplot(2, 4, 2), imshow(lp_pout, []), title('理想高通滤波器');
subplot(2, 4, 3), imshow(lp_pout_btw, []), title('巴特沃斯高通滤波器');
subplot(2, 4, 4), imshow(lp_pout_gaussian, []), title('高斯高通滤波器');
subplot(2, 4, 5), imshow(girl, []), title('girl原图');
subplot(2, 4, 6), imshow(lp_girl, []), title('理想高通滤波器');
subplot(2, 4, 7), imshow(lp_girl_btw, []), title('巴特沃斯高通滤波器');
subplot(2, 4, 8), imshow(lp_girl_gaussian, []), title('高斯高通滤波器');



function H = lpfilter(type, M, N, D0, n)
    [U,V] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
    D = hypot(U,V);

    % 构造滤波器
    switch type
        case 'ideal'
            H = D > D0;
        case 'btw'
            H = 1./ (1 + (D0./D).^(2*n));
        case 'gaussian'
            H = exp(-(D0./D).^n);
        otherwise
            error("Unknown filter type.");
    end
end

function output = freqfilter(img, H)
    % 傅里叶变换
    F = fft2(img);

    F = fftshift(F);

    % 频域滤波
    G = H .* F;

    % 傅里叶反变换
    G = ifftshift(G);

    output = ifft2(G);

    output = abs(output);
end

