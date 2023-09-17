% 4、直方图均衡：要求
% 1) 显示一幅图像 pout.bmp 的直方图；
% 2) 用直方图均衡对图像 pout.bmp 进行增强；
% 3) 显示增强后的图像及其直方图。
% 4) 用原始图像 pout.bmp 进行直方图规定化处理，将直方图规定化为高斯分布；
% 4) 显示规定化后的图像及其直方图。

pic = imread('../image/pout.bmp');
subplot(3,2,1);
imshow(pic);
title('原始图像');
subplot(3,2,2);
histogram(pic);
title('原始图像直方图');

pic2 = histeq(pic);
subplot(3,2,3);
imshow(pic2);
title('直方图均衡化后的图像');
subplot(3,2,4);
histogram(pic2);
title('直方图均衡化后的图像直方图');

pic3 = histeq(pic, normpdf((0:1:255), 128, 50));
subplot(3,2,5);
imshow(pic3);
title('直方图规定化后的图像');
subplot(3,2,6);
histogram(pic3);
title('直方图规定化后的图像直方图');
