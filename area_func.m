%%%%%%%%%%%%% function area_func.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      calculates area of object in bounding box
%
% Input Variables:
%      input           Input binary image 
% Returned Results:
%      count         area of object 
% Processing Flow:
%      1.  Compute number of ones in the image
%
%  Restrictions/Notes:
%    
%  The following functions are called:
%      None
%
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function count = area_func(input)
    input = logical(input);
    [rows col] = size(input);
    count=0;
    for i=1:rows
        for j=1:col
            if input(i,j)==1
                count = count+1;
            end
        end
    end
end

                