% open a picture
ab2 = imread('../image/alphabet2.jpg');
ab1 = imread("../image/alphabet1.jpg");

[mp, fp] = cpselect(ab2, ab1, 'Wait', true);

% get the coordinates of the points
tform = fitgeotrans(mp, fp, 'projective');
correct = imwarp(ab2, tform, 'OutputView', imref2d(size(ab2)));

figure;
imshow(correct);
title('Corrected Image');