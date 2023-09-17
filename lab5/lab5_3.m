source = imread('../image/cameraman.bmp');
subplot(1,3,1); imshow(source); title('原图'); 
% 调用 qtdecomp() 函数对图像进行四叉树分割，并将分割后的结果保存在数组 S 中。
% value_range 参数控制分割的粒度，值越大分割越细。此处设置为 0.35。
value_range = .5;
S = qtdecomp(source,value_range,2);%四叉树分割
blocks = zeros(256);

% 通过循环遍历不同的分块大小，产生分块边界。
% 对于每个分块，将其边界像素设置为白色，其余像素设置为黑色，并将其保存在 256x256 的数组 blocks 中。
for dim = [64 32 16 8 4 2]
	blocks_cnt = length(find(S==dim));    
	if (blocks_cnt > 0)        
        % 全部设置为黑色
        values = repmat(uint8(1),[dim dim blocks_cnt]);
        % 设置边界为白色
        values(2:dim,2:dim,:) = 0;
        % 将分块保存在 blocks 中
        blocks = qtsetblk(blocks,S,dim,values);
  end
end

%产生分裂图
output1 = source;

output1(blocks==1) = 255;
subplot(1,3,2); imshow(output1); title('分裂图'); 

% 在分块边界的基础上，将每个分块进行标记，用不同的整数表示。标记后的结果保存在数组 blocks 中。
i = 0;
for dim = [64 32 16 8 4 2]
    % 从分块中提取块
    [vals,r,c] = qtgetblk(source,S,dim);
    % 如果块不为空，则对块进行标记
    if ~isempty(vals)
        for j = 1:length(r)
            i = i + 1;
            blocks(r(j):r(j)+ dim - 1,c(j):c(j)+ dim - 1) = i;
        end
    end
end

% 对于极差较小的分块，将其与周围的分块合并。
% 具体做法是对于每个分块，找到其周围边界像素，并将其与当前分块合并，计算合并后分块的极差，
% 如果小于预设的值 value_range*256，则将其标记与当前分块相同。
for j = 1 : i
    % 找到边界, boundarymask() 函数用于找到边界像素，只有当两个像素值不相等时，才将其设置为 1。
    bound = boundarymask(blocks == j, 4) & (~(blocks == j));
    % 找到边界像素的位置
    [r,l] = find(bound == 1);
    for k = 1 : size(r,1)
        % 合并
        merge = source((blocks==j) | (blocks==blocks(r(k),l(k))));
        % 计算极差
        if(range(merge(:)) < value_range * 256)
            % 标记
            blocks(blocks == blocks(r(k), l(k))) = j;
        end
    end
end

% 根据标记重新分割图像，合并相邻的分块，使其边界更加平滑，输出结果保存在数组 output2 中。
output2 = source;
for i = 2 : 255
    for j = 2 : 255
        % 如果当前像素与其右边或下边的像素不相等，则将其设置为白色。
        if(blocks(i,j)~=blocks(i,j+1) || blocks(i,j)~=blocks(i+1,j))
            output2(i,j) = 255;
        end
    end
end

subplot(1,3,3); imshow(output2); title('合并后的结果'); 