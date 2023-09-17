pout = imread("../image/Pout.bmp");

D0 = 15;
n = 1;
% 理想高通滤波器-直方图
pout1 = freqfilter(pout, lpfilter('ideal', size(pout, 1), size(pout, 2), D0, n));
pout1 = histeq(uint8(pout1));
% 直方图-理想高通滤波器
pout2 = histeq(pout);
pout2 = freqfilter(pout2, lpfilter('ideal', size(pout, 1), size(pout, 2), D0, n));

% 巴特沃斯高通滤波器-直方图
pout3 = freqfilter(pout, lpfilter('btw', size(pout, 1), size(pout, 2), D0, n));
pout3 = histeq(uint8(pout3));
% 直方图-巴特沃斯高通滤波器
pout4 = histeq(pout);
pout4 = freqfilter(pout4, lpfilter('btw', size(pout, 1), size(pout, 2), D0, n));

% 高斯高通滤波器-直方图
pout5 = freqfilter(pout, lpfilter('gaussian', size(pout, 1), size(pout, 2), D0, n));
pout5 = histeq(uint8(pout5));
% 直方图-高斯高通滤波器
pout6 = histeq(pout);
pout6 = freqfilter(pout6, lpfilter('gaussian', size(pout, 1), size(pout, 2), D0, n));

figure;
subplot(3,3,1), imshow(pout, []), title('原图');
subplot(3,3,4), imshow(pout1, []), title('理想高通滤波器-直方图');
subplot(3,3,5), imshow(pout3, []), title('巴特沃斯高通滤波器-直方图');
subplot(3,3,6), imshow(pout5, []), title('高斯高通滤波器-直方图');
subplot(3,3,7), imshow(pout2, []), title('直方图-理想高通滤波器');
subplot(3,3,8), imshow(pout4, []), title('直方图-巴特沃斯高通滤波器');
subplot(3,3,9), imshow(pout6, []), title('直方图-高斯高通滤波器');


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