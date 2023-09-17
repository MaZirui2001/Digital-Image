A = imread('../image/alphabet1.jpg');
A1 = im2double(rgb2gray(A));
[h,w] = size(A1);
A2 = zeros(h,w);
x1 = input('input x1: ');
x2 = input('input x2: ');
y1 = input('input y1: ');
y2 = input('input y2: ');
for i = 1 : h
    for j = 1 : w
        if A1(i, j) <= x1
            A2(i, j) = (y1 / x1) * A1(i, j);
        elseif A1(i,j) < x2
            A2(i, j) = (y2 - y1) / (x2 - x1) * (A1(i, j) - x1) + y1;
        else 
            A2(i, j) = (255 - y2)/(255 - x2) * (A1(i,j) - x2) + y2;
        end
    end
end
subplot(2,1,1);
imshow(A1),title('原图');
subplot(2,1,2);
imshow(A2),title('分段灰度变换');