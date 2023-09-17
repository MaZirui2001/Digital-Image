
k = input('input k: ');
b = input('input b: ');
original = imread('../image/alphabet1.jpg');
transformed = original * k + b;
figure
imshow(original)
figure
imshow(transformed)