%%%%%%%%%%%%% function sym_matrix.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Computes symmetric matrix
%
% Input Variables:
%      input_matrix           Structuring element
%
% Returned Results:
%      output           Output symmetric matrix of input_matrix
%
% Processing Flow:
%      1.  Write all the elements of input_matrix in output in the manner such that
%      output=input_matrix(-i,-j)as discussed in notes.
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      None
%
%  Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = sym_matrix(input_matrix)
    [m n] = size(input_matrix);
    output = zeros(m,n);
    for i=1:m
        for j=1:n
            output(m-i+1, n-j+1) = input_matrix(i,j);
        end
    end
end
