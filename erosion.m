%%%%%%%%%%%%%%% Function erosion %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
%         Implement erosion with certain structuring element to an image
% 
% Input Variable:
%         input_image    the desired image to do the operation
%         structure      the structuring element for the operation
%         
% Output:
%         output         the image after operation
%         
% Process Flow:
%         1. Find the positions that the pixel is black(0).
%         2. Extract the same size of the mask of the structuring 
%             element from the input image
%         3. If all the pixels on the extracted image has the same value as the 
%             corresponding position on the structuring element, set the origin of the 
%             input image to be black.
%        
% Note:
%         1. value '0' represents black, '1' for white
%
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = erosion(input_image,structure)
    
    [rows, col] = size(input_image);
    [x, y] = size(structure);
    output = zeros(rows, col);
    pos = (structure == 1); % find the postion of black pixel
    
    for i = 1+floor(x/2):rows-floor(x/2)
        for j = 1+floor(y/2):col-floor(y/2)
            temp = input_image(i-floor(x/2):i+floor(x/2), j-floor(y/2):j+floor(y/2));
           if (min(temp(pos)) == 0) % if the position of the image pixel is white
               output(i, j) = 0;
           else
               output(i, j) = 1;
           end
        end
    end      
end
