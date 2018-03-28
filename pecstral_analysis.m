%%%%%%%%%%%%% function pecstral_analysis.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      performs pecstral analysis
%
% Input Variables:
%      pecstrum_test       pecstrum of test object
%      C                   weight vector for finding appropriate object from test image
%      pecstrum_ref        Pecstrum of reference image
% 
% Returned Results:
%      R        array/number with minimum distance found after pecstral
%               analysis. It also corresponds to the label of the matched
%               object
% 
% Processing Flow:
%      1. Elementwise subtract pecstrum of test object to the pecstrum of
%      reference object which is given as the error distance.
%      2. Square the error distance and multiply by weights.
%      3. Perform for all the objects from reference image.
%      4. Find minimum distance from all such computations for objects
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
function [D R] = pecstral_analysis(pecstrum_test,pecstrum_ref,C)
    [r_ref,c_ref]=size(pecstrum_ref);
    [r_test,~]=size(pecstrum_test);
    R=[];D=[];
    for k=1:r_test
        d=[];
        for i=1:r_ref
            co=0;
            for j=1:c_ref
               co= co + (C(j)*(pecstrum_test(k,j)-pecstrum_ref(i,j)))^2; 
            end
            d=[d;(sqrt(co))];
        end
        D=[D d];
        [vi,ri]=min(d);

        R=[R;ri];
    end
end

