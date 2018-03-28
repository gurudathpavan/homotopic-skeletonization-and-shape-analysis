%%%%%%%%%%%%%  Function erosion_amg.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute a dilated image of an original image 
%
% Input Variables:
%      X       m x n input 2D gray-scale image to be filtered
%      B       Structuring element 
% 
% Returned Results:
%     temp     new dilated image
%
% Processing Flow:
%      1.  Finding the size of the filter.
%      2.  Place the centre of filter on the image and check whether 1 is 
%          present in all element.
%      3.  If present then return 1(white) at centre pixel else return 0. 
%      
%  Restrictions/Notes:
%      This function takes a binary image as input. The image is not padded 
%       by zeros at the boundary.
%
%  The following functions are called:
%      none
%
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ temp ] = erosion_amg( X,B )
    g=X;
    g2 = false(size(g));
    s = B;
    sof=size(B);
    [R,C]=size(g);
    k1=round(sof/2);
    k2=k1-1;
    for r = k1:(R-k2)
        for c = k1:(C-k2)
           A = g(r-k2:r+k2,c-k2:c+k2);
           if (all((A & s) == s) == true)           
               g2(r,c) = true;
           else
                g2(r,c) = false;
           end
        end
    end
    temp= g2;
end
