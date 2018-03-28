clc;
clear all;
close all;


%% Training
im_ref_1=logical(imread('shadow1.gif'));
fig_1 = figure();imshow(im_ref_1);
m_area_1= zeros(8,1);
s1 = regionprops(im_ref_1,'BoundingBox');

%  Reordering the bounnding box labels to cater to our needs
s_new_1=s1;
s_new_1(1) = s1(2);
s_new_1(2) = s1(4);
s_new_1(3) = s1(5);
s_new_1(4) = s1(10);
s_new_1(5) = s1(1);
s_new_1(6) = s1(3);
s_new_1(7) = s1(6);
s_new_1(8) = s1(9);
% s_new_1(9) = s1(7);
% s_new_1(10) = s1(8);

%displaying the bounding boxes
for i=1:8
    rectangle('Position',[cell2mat(struct2cell(s_new_1(i)))],'EdgeColor','r','LineWidth',2);
end
saveas(fig_1,'Bounding_box_peanuts.png');
size_distribution_full_1=[];f_rfull_1=[];
shape_complexity_full_1=[];
edge=1;
label_1 ={'outline_1','outline_2','outline_3','outline_4',...
            'shaded_1','shaded_2','shaded_3','shaded_4'};
for k=1:8
%     Extracting each object from the image
    img_1{k} = extract_images(im_ref_1,s_new_1,k, edge);
    temp_img_1 = img_1{k};
    imshow(temp_img_1);
    m_area_1(k) = area_func(temp_img_1);
%     Calculating size distribution    
    size_d_1=[];
    for r=1:12
        rB_1 = ones(3+(r-1)*2);
        rBs_1 = sym_matrix(rB_1);
        Y_1=dilation_amg(erosion_amg(temp_img_1,rBs_1),rB_1);
        loc_ar_1 = area_func(Y_1);
        size_d_1 =[size_d_1 loc_ar_1];
    end
    
    size_distribution_full_1 = [size_distribution_full_1;size_d_1];
%     Calculating pecstrum       
    f_r_1 = pecstrum(size_d_1,m_area_1(k));
    f_rfull_1 = [f_rfull_1 ; f_r_1];
%     Removing the zeros from the pecstrum
    f_r_wo_zeros_1=[];
    for i = 1 :length(f_r_1)
       if f_r_1(i) ~= 0
           f_r_wo_zeros_1(i)=f_r_1(i);     
       end
    end
%     Calculating entropy      
    shape_complexity_1 = complexity_func(f_r_wo_zeros_1);
    shape_complexity_full_1 = [shape_complexity_full_1; shape_complexity_1];
%     Displaying results      
    fprintf(['Label --> ',num2str(k),'\n',label_1{k},':- \n ']);
    fprintf(['Size distribution:  ', num2str(size_d_1),'\n']);
    fprintf(['Pecstrum:',num2str(f_r_wo_zeros_1),'\n']);
    fprintf(['Entropy: ',num2str(shape_complexity_1),'\n \n']);
    disp('-- -- -- -- -- -- -- -- -- -- -- -- -- --');
end
disp('%%%%%%%%%%%%%%%%%%%%%%');
% Finding max and min entropy
[val,pos]=min(shape_complexity_full_1);
fprintf(['The least complex object corresponds to minimum entropy and it is ',num2str(label_1{pos}),'.\n']);
[val,pos]=max(shape_complexity_full_1);
fprintf(['The most complex object corresponds to maximum entropy and it is ',num2str(label_1{pos}),'.\n']);
fprintf('\n---------END OF TRAINING--------\n');
%% Testing

im_ref_2=logical(imread('shadow1rotated.gif'));
fig_2=figure;imshow(im_ref_2);
m_area_2= zeros(8,1);
s2 = regionprops(im_ref_2,'BoundingBox');
%  Reordering the bounnding box labels to cater to our needs
s_new_2=s2;
s_new_2(1) = s2(1);
s_new_2(2) = s2(4);
s_new_2(3) = s2(5);
s_new_2(4) = s2(9);
s_new_2(5) = s2(2);
s_new_2(6) = s2(3);
s_new_2(7) = s2(6);
s_new_2(8) = s2(8);
% s_new_2(9) = s2(7);
% s_new_2(10) = s2(8);

%displaying the bounding boxes
for i=1:8
    rectangle('Position',[cell2mat(struct2cell(s_new_2(i)))],'EdgeColor','r','LineWidth',2);
end
saveas(fig_2,'Bounding_box_rotated_peanuts.png');
size_distribution_full_2=[];f_rfull_2=[];
shape_complexity_full_2=[];
edge=1;
label_2 ={'test_outline_1','test_outline_2','test_outline_3','test_outline_4',...
            'test_shaded_1','test_shaded_2','test_shaded_3','test_shaded_4'};
for k=1:8
%     Extracting each object from the image
    img_2{k} = extract_images(im_ref_2,s_new_2,k, edge);
    temp_img_2 = img_2{k}; 
    imshow(temp_img_2);
    m_area_2(k) = area_func(temp_img_2);
%     Calculating size distribution   
    size_d_2=[];
    for r=1:12
        rB_2 = ones(3+(r-1)*2);
        rBs_2 = sym_matrix(rB_2);
        Y_2=dilation_amg(erosion_amg(temp_img_2,rBs_2),rB_2);
        loc_ar_2 = area_func(Y_2);
        size_d_2 =[size_d_2 loc_ar_2];
    end
    
    size_distribution_full_2 = [size_distribution_full_2;size_d_2];
%     Calculating pecstrum       
    f_r_2 = pecstrum(size_d_2,m_area_2(k));
    f_rfull_2 = [f_rfull_2 ; f_r_2];
%     Removing the zeros from the pecstrum
    f_r_wo_zeros_2=[];
    for i = 1 :length(f_r_2)
       if f_r_2(i) ~= 0
           f_r_wo_zeros_2(i)=f_r_2(i);    
       end
    end
%     Calculating entropy      
    shape_complexity_2 = complexity_func(f_r_wo_zeros_2);
    shape_complexity_full_2 = [shape_complexity_full_2; shape_complexity_2];
%     Displaying results    
    fprintf(['Label --> ',num2str(k),'\n',label_2{k},':- \n ']);
    fprintf(['Size distribution:  ', num2str(size_d_2),'\n']);
    fprintf(['Pecstrum:',num2str(f_r_wo_zeros_2),'\n']);
    fprintf(['Entropy: ',num2str(shape_complexity_2),'\n \n']);
    disp('-- -- -- -- -- -- -- -- -- -- -- -- -- --');
end

% Finding max and min entropy
[val,pos]=min(shape_complexity_full_1);
fprintf(['The least complex object corresponds to minimum entropy and it is ',num2str(label_1{pos}),'\n']);
[val,pos]=max(shape_complexity_full_1);
fprintf(['The most complex object corresponds to maximum entropy and it is ',num2str(label_1{pos}),'\n']);
fprintf('\n--------END OF TESTING--------\n');
disp('%%%%%%%%%%%%%%%%%%%%%%');

fprintf('Plotting figures for size distribution and pattern spectrum... \n');
% PLotting figures for size distribution and pattern spectrum of flower
fig_f = figure('OuterPosition',[250 500 700 500]);
subplot(1,2,1)
plot(size_distribution_full_1(5,:))
hold on
plot(size_distribution_full_2(5,:));title('size distribution of shaded object 1')
legend('shadow1','shadow1rotated')
% 
subplot(1,2,2)
stem(f_rfull_1(5,:),'o')
hold on
stem(f_rfull_2(5,:),'*');title('pecstrum of flower')
legend('shadow1','shadow1rotated')
saveas(fig_f,'Size_distri_pecstrum_shaded_1.png');

% PLotting figures for size distribution and pattern spectrum of bull
fig_b=figure('OuterPosition',[250 500 700 500]);
subplot(1,2,1)
plot(size_distribution_full_1(6,:))
hold on
plot(size_distribution_full_2(6,:));title('size distribution of shaded object 2')
legend('shadow1','shadow1rotated')

subplot(1,2,2)
stem(f_rfull_1(6,:),'o')
hold on
stem(f_rfull_2(6,:),'*');title('pecstrum of bull')
legend('shadow1','shadow1rotated')
saveas(fig_b,'Size_distri_pecstrum_shaded_2.png');

% PLotting figures for size distribution and pattern spectrum of airplane
fig_a=figure('OuterPosition',[250 500 700 500]); 
subplot(1,2,1)
plot(size_distribution_full_1(7,:))
hold on
plot(size_distribution_full_2(7,:));title('size distribution of shaded object 3')
legend('shadow1','shadow1rotated')

subplot(1,2,2)
stem(f_rfull_1(7,:),'o')
hold on
stem(f_rfull_2(7,:),'*');title('pecstrum of airplane')
legend('shadow1','shadow1rotated')
saveas(fig_a,'Size_distri_pecstrum_shaded_3.png');

% PLotting figures for size distribution and pattern spectrum of spade
fig_s=figure('OuterPosition',[250 500 700 500]);
subplot(1,2,1)
plot(size_distribution_full_1(8,:));title('size distribution of shaded object 4')
hold on
plot(size_distribution_full_2(8,:));title('size distribution of shaded object 4')
legend('shadow1','shadow1rotated')

subplot(1,2,2)
stem(f_rfull_1(8,:),'o')
hold on
stem(f_rfull_2(8,:),'*');title('pecstrum of spade')
legend('shadow1','shadow1rotated')
saveas(fig_s,'Size_distri_pecstrum_shaded_4.png');


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

%%
fprintf(['Matching each of the labels']);

for check = 5:8
    k_ref = check;
    label_ref = label_2{k_ref};
    size_d_ref = size_distribution_full_2(k_ref,:);
    pecstrum_ref = f_rfull_1(k_ref,:);
    pecstrum_test = f_rfull_2;
    % testing
    fprintf(['Performing pattern recognition using pecstral analysis for ',label_ref,'...\n'])
    % Create weight vector for finding appropriate object from test image. This
    % is chosen by trial and error method. 
    C = [1 2 1 0 1 0 0 0 0 0 0 2];     
%     C = [1 2 1 0 1 0 0 0 0 0 0 2];         

    [d, ri] = pecstral_analysis(pecstrum_ref,pecstrum_test,C);
    % displaying output
    fprintf(['Matched label number of ',num2str(label_1{k_ref}),' in shadow1.gif image is ',num2str(label_2{ri}),' in shadow1rotated.gif \n']);  
    % Plotting
    % Reference Image Plot
    figu1=figure();
    imshow('shadow1.gif'); title('Reference image');
    referred_BB = s_new_1(k_ref).BoundingBox;
    rectangle('Position', [referred_BB(1),referred_BB(2),referred_BB(3),referred_BB(4)],...
        'EdgeColor','r','LineWidth',2 )
    saveas(figu1,['Reference_Image_',num2str(check),'.png']);
    hold on;
    
    figu2 = figure();
    imshow('shadow1rotated.gif'); title('matched object is in bounding box');
    test_BB = s_new_2(ri).BoundingBox;
    rectangle('Position', [test_BB(1),test_BB(2),test_BB(3),test_BB(4)],...
        'EdgeColor','r','LineWidth',2 )
    saveas(figu2,['Matched_Image_',num2str(check),'.png']);
    hold on;
end