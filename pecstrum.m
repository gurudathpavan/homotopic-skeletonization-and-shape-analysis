%%%%%%%%%%%%% function pecstrum.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Computes pecstrum of the object
%
% Input Variables:
%      size_distribution           Size distribution of the object
%      area                        Actual area of the object.
%
% Returned Results:
%      f             Normalized pecstrum of object   
%
% Processing Flow:
%      1.  Subtract previous element of size distribution array from current. 
%      2.  Normalize the array with the area of object.
%
%  Restrictions/Notes:
%      None. 
%
%  The following functions are called:
%      None 
%
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = pecstrum(size_distribution,area)
   f = [];
   size_distribution = [size_distribution 0];
   for i=1:(length(size_distribution)-1);
       f(i) = (size_distribution(i) - size_distribution(i+1))./(area);
   end
end


