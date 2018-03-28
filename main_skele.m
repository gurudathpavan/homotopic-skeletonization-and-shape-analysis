%%%%%%%%%%%%% main_skele.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Solution to the Part-1  of Project-2
%
% Input Variables:
%      idx              1 for penn256; 2 for bear
%      Image            Binary input image 
%      B1,B2 ..B8       Structuring Elements
% 
% Returned Results:
%     Gives the output images after every iteration of skeletonization
%
% Processing Flow:
%      1.  Computer hit or miss transform of input image with SE.
%      2.  Subtract it from the previous image to obtain the skeleton
%      3.  Repeat steps 1,2 for all structuring elements and input images
% 
%  Restrictions/Notes:
%      File takes about 40 seconds for bear and 14 seconds for penn256
%
%  The following functions are called:
%       erosion.m
% 
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear
tic;
idx = input('Enter input image(1:penn.256, 2:bear): ');

switch idx
    case 1
        Image = imread('penn256.gif');
        idx = 'penn';
    case 2
        Image = imread('bear.gif');
        idx = 'bear';
end
Image = logical(Image);
% structuring elements on the project instruction
B1 = [1 1 1 ;NaN 0 NaN; 0 0 0]; 
B2 = [NaN 1 1; 0 0 1; 0 0 NaN]; 
B3 = [0 NaN 1; 0 0 1; 0 NaN 1]; 
B4 = [0 0 NaN; 0 0 1; NaN 1 1]; 
B5 = [0 0 0; NaN 0 NaN; 1 1 1]; 
B6 = [NaN 0 0; 1 0 0; 1 1 NaN]; 
B7 = [1 NaN 0; 1 0 0; 1 NaN 0]; 
B8 = [1 1 NaN; 1 0 0; NaN 0 0]; 

B_total = [B1 B2 B3 B4 B5 B6 B7 B8]; % construct a super matrix for iteration
B_c_total = 1 - B_total; % complement super structuring element 
[M, N] = size(B_total);

Image_org = Image;
figure();
imshow(Image);
title('Penn');
Image = ~Image;
% eroded by structuring elements

j = 1;
num_1 = 0;
num_2 = 0;
figure();

while(1)
%   computing hit-or-miss on every structuring element
    for i = 1:3:N-2
        B_f = B_total(:,i:i+2);
        B_b = B_c_total(:,i:i+2);
        
        img_fore = logical(erosion(Image, B_f));
        img_back = logical(erosion(1-Image, B_b));
        
        img_temp = img_fore & img_back;
        Image = logical(Image - img_temp);
    end
    
    num_1 = sum(sum(double(Image)));  
    
    if (j > 1 && num_2 == num_1) 
        break;
    end
%    
%     figure();
%     imshow(~Image);
%     title(['X' num2str(j)]);
%     

    imwrite(double(~Image),['X' num2str(j) '_' idx '.png']);
    imshow(~Image);
    
    j = j + 1;
    num_2 = num_1;
    
end


%superposition of image
superpos = mod(Image_org + ~logical(Image), 2);
figure();
imshow(superpos);
title('superposition');
imwrite(double(superpos), ['superpos' idx '.png']);
figure();
imshow(~Image);
imwrite(double(~Image), ['final' idx '.png']);
toc;