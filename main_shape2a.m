clc;
clear all;
close all;


%% Training
im_ref_1=logical(imread('match1.gif'));
figure();imshow(im_ref_1);
m_area_1= zeros(4,1);
s1 = regionprops(im_ref_1,'BoundingBox');
size_distribution_full_1=[];f_rfull_1=[];
shape_complexity_full_1=[];
edge=5;
label_1 ={'flower','bull','airplane','spade'};
for k=1:length(s1)
%     Applying bounding box on individual images
    fig_1 = figure(100); 
    imshow(im_ref_1); hold on;
    img_1{k} = extract_images(im_ref_1,s1,k, edge); 
    saveas(fig_1,['Bounding_box_on_',label_1{k},'.png']);
    temp_img_1 = img_1{k};
%     Calculating size distribution
    m_area_1(k) = area_func(temp_img_1);
    
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
% Finding max and min entropy
[val,pos]=min(shape_complexity_full_1);
fprintf(['The least complex object corresponds to minimum entropy and it is ',num2str(label_1{pos}),'.\n']);
[val,pos]=max(shape_complexity_full_1);
fprintf(['The most complex object corresponds to maximum entropy and it is ',num2str(label_1{pos}),'.\n']);
fprintf('\n---------END OF TRAINING--------\n');

%% Testing

im_ref_2=logical(imread('match3.gif'));
figure();imshow(im_ref_2);
m_area_2= zeros(4,1);
s2 = regionprops(im_ref_2,'BoundingBox');
size_distribution_full_2=[];f_rfull_2=[];
shape_complexity_full_2=[];
edge=5;
label_2 ={'flower','bull','spade','airplane'};
for k=1:length(s2)
%     Applying bounding box on individual images
    fig_2 = figure(200); 
    imshow(im_ref_2); hold on;
    img_2{k} = extract_images(im_ref_2,s2,k, edge);
    saveas(fig_2,['Bounding_box_on_rotated_',label_2{k},'.png']);
    temp_img_2 = img_2{k};
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

fprintf('Plotting figures for size distribution and pattern spectrum... \n');
% PLotting figures for size distribution and pattern spectrum of flower
fig_f = figure('OuterPosition',[250 500 700 500]);
subplot(1,2,1)
plot(size_distribution_full_1(1,:))
hold on
plot(size_distribution_full_2(1,:));title('size distribution of flower')
legend('match1','match3')
% 
subplot(1,2,2)
stem(f_rfull_1(1,:),'o')
hold on
stem(f_rfull_2(1,:),'*');title('pecstrum of flower')
legend('match1','match3')
saveas(fig_f,'Size_distri_pecstrum_flower.png');

% PLotting figures for size distribution and pattern spectrum of bull
fig_b=figure('OuterPosition',[250 500 700 500]);
subplot(1,2,1)
plot(size_distribution_full_1(2,:))
hold on
plot(size_distribution_full_2(2,:));title('size distribution of bull')
legend('match1','match3')

subplot(1,2,2)
stem(f_rfull_1(2,:),'o')
hold on
stem(f_rfull_2(2,:),'*');title('pecstrum of bull')
legend('match1','match3')
saveas(fig_b,'Size_distri_pecstrum_bull.png');

% PLotting figures for size distribution and pattern spectrum of airplane
fig_a=figure('OuterPosition',[250 500 700 500]); 
subplot(1,2,1)
plot(size_distribution_full_1(3,:))
hold on
plot(size_distribution_full_2(4,:));title('size distribution of airplane')
legend('match1','match3')

subplot(1,2,2)
stem(f_rfull_1(3,:),'o')
hold on
stem(f_rfull_2(4,:),'*');title('pecstrum of airplane')
legend('match1','match3')
saveas(fig_a,'Size_distri_pecstrum_airplane.png');

% PLotting figures for size distribution and pattern spectrum of spade
fig_s=figure('OuterPosition',[250 500 700 500]);
subplot(1,2,1)
plot(size_distribution_full_1(4,:));title('size distribution of spade')
hold on
plot(size_distribution_full_2(3,:));title('size distribution of spade')
legend('match1','match3')

subplot(1,2,2)
stem(f_rfull_1(4,:),'o')
hold on
stem(f_rfull_2(3,:),'*');title('pecstrum of spade')
legend('match1','match3')
saveas(fig_s,'Size_distri_pecstrum_spade.png');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


fprintf(['\n With SPADE as the reference object...\n']);

for k_ref=1:4

label_ref = label_1{k_ref};
size_d_ref = size_distribution_full_1(k_ref,:);
pecstrum_ref = f_rfull_1(k_ref,:);

pecstrum_test = f_rfull_2;

%% Pattern matching
disp('Performing pattern recognition using pecstral analysis..')
% Create weight vector for finding appropriate object from test image. This
% is chosen by trial and error method. 
C = [1 1 1 1 1 1 1 1 0 0 0 0];         
[d, ri] = pecstral_analysis(pecstrum_ref,pecstrum_test,C); %Pattern matching
% displaying output
fprintf(['Matched label number of ',label_1{k_ref},' in match3.gif image is =',num2str(ri),'\n']);  
% Plotting
% Reference Image Plot
fig_3 = figure; imshow('match1.gif'); title('Reference image');
referred_BB = s1(k_ref).BoundingBox;
rectangle('Position', [referred_BB(1),referred_BB(2),referred_BB(3),referred_BB(4)],...
        'EdgeColor','r','LineWidth',2 )
saveas(fig_3,['Reference_Image_',label_1{k_ref},'.png']);
    
fig_4 = figure; imshow('match3.gif'); title('matched object is in bounding box');
test_BB = s2(ri).BoundingBox;
rectangle('Position', [test_BB(1),test_BB(2),test_BB(3),test_BB(4)],...
        'EdgeColor','r','LineWidth',2 )
saveas(fig_4,['Matched_Image_',label_1{k_ref},'.png']);
end