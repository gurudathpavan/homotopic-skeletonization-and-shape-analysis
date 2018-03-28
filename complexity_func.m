%%%%%%%%%%%%% function complexity_func.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      To compute the entropy of a given object in the pecstrum analysed
%      image
% Input Variables:
%      input_f      pecstrum of objects
% 
% Returned Results:
%      h        Entropy of the test image respectively
%  
% Processing Flow:
%     1) for all non zero elements in f, calculate corresponding
%     complexities
%
%  Restrictions/Notes:
%      None
% 
%  The following functions are called:
%      None
% 
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [h] = complexity_func(input_f)
   h=0;
    for i=1:length(input_f);
        if input_f(i) ~=0
            h=h+(input_f(i)*log(input_f(i)));
        end
    end
    h=-h;
end
