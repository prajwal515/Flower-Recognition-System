clear all;
clc;
no_of_char = 5;
no_of_persons = 5;
total_char = no_of_char * no_of_persons;
row = 50;
col = 100;
Avg_Image = zeros(row,col);
Sum_Image = zeros(row,col);
Source = 'E:\cvpr\flower\flower imgs\'; 
Source1 = 'E:\cvpr\flower\flower imgs b&w\'; 
for i=1:no_of_char,
    for j=1:no_of_persons,
        char_Path = '';
        char_Path  = strcat(Source,'image_',int2str(i),'00',int2str(j),'.jpg');
        char_Image = imread(char_Path);
        char_Image = rgb2gray(char_Image);
        char_Image = im2bw(char_Image);
        
        char_Image = imcomplement(char_Image);
        char_Image1=bwareafilt(char_Image,10);
        char_Image = imresize(char_Image1, [50 100]);
        newimagename = [Source1 'image_',int2str(i),'00',int2str(j) '.jpg'];
        imwrite(char_Image, newimagename);
        imshow(char_Image);
    end
end 
