%%%%%%%%%%%%%% function extract_images.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Extracts the necessary object
%
% Input Variables:
%      input_image          Image whose object needs to be extracted from
%      regions              x coordinate, ycoordinate, width and height of the object present in the input_image                   weight vector for finding appropriate object from test image
%      k                    Row number of the label
%      edge                 Number of pixels outside the bounding box
%                           region that the image needs to be extracted
% 
% Returned Results:
%      output               Final object necessary output image
% 
% Processing Flow:
%      1. Draws a rectangle using the coordinates specified by regions
%      2. Extracts that part +/- the layer specified by edge
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      None
% 
% Author:      Pavan Gurudath, Ming-Ju Li
%  Date:        02/18/2018
function output = extract_images(input_image, regions,k, extra_edge)
    output=[];
    %sorting the bounding box label such that 
    % label 1 --> outline 1
    % label 2 --> outline 2
    % label 3 --> outline 3
    % label 4 --> outline 4
    % label 5 --> shaded 1
    % label 6 --> shaded 2
    % label 7 --> shaded 3
    % label 8 --> shaded 4    
    
    
    
    
    bb_sorted = cell2mat(struct2cell(regions)');
    
    rectangle('Position', [bb_sorted(k,1),bb_sorted(k,2),bb_sorted(k,3),bb_sorted(k,4)],...
            'EdgeColor','r','LineWidth',2 ) 
    output = input_image(floor(bb_sorted(k,2)-extra_edge):floor(bb_sorted(k,2)+bb_sorted(k,4)+extra_edge),...
                            floor(bb_sorted(k,1)-extra_edge):floor(bb_sorted(k,1)+bb_sorted(k,3)+extra_edge));
    output = logical(output);
        


end