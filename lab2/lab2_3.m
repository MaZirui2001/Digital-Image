% 3、灰度直方图
% 要求：输入一幅图像，显示它的灰度直方图，可以根据输入的参数（上限、下限）显示特定范围的灰度直方图。
pic_pre = imread('../image/flower1.jpg');
% pic = im2double(im2gray(pic_pre));
pic = im2gray(pic_pre);

low = input("input low: ");
high = input("input high: ");
gray_range = [low, high];
num_bins = diff(gray_range) + 1;
counts = histcounts(pic, num_bins, 'BinLimits', gray_range); 
bar(gray_range(1):gray_range(2), counts); % 显示灰度直方图
xlim([low high]); % 设置X轴范围
title('Gray level histogram'); % 设置标题
xlabel('Gray level'); % 设置X轴标签
ylabel('Count'); % 设置Y轴标签
