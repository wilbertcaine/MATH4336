addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\dataset');

filename = 'barbara11.png';
up_scale = 2; % 2
up_scale_factor = 1;
t_max = 200; % 100
tau = 0.2; % 0.2
beta = 0.05; % 0.05
lambda_h = 1.63; % 1.63
lambda_l = 1.6; % 1.6
gau_sigma = 0.8; % 0.8
mu = Inf; % 0.1 - 0.5 / Inf

ground_truth = imread(filename);    
if size(size(ground_truth), 2) > 2
    ground_truth = rgb2gray(ground_truth);
end
ground_truth = im2double(ground_truth);
[rows, columns] = size(ground_truth);
for i = 1 : mod(rows, 4)
    ground_truth(1,:) = [];
end
for i = 1 : mod(columns, 4)
    ground_truth(:,1) = [];
end

input = ground_truth;
input = imresize(input, 1/up_scale^up_scale_factor, 'bilinear');
n = 9;
n=3;

% subplot(2, n, 1);
% imshow(input);
% title({'input', 'bilinear down-sample', '(factor of 4)'});
% [Gmag,Gdir] = imgradient(input, 'central');
% subplot(2, n, n+1);
% imshow(imcomplement(Gmag));
% imshow(Gmag);

up_input = imresize(input, up_scale^up_scale_factor, 'bicubic');

subplot(2, n, 1);
imshow(up_input);
title({'bicubic up-sample', ['SSIM = ', num2str(ssim(up_input, ground_truth))]});
[Gmag,Gdir] = imgradient(up_input, 'central');
subplot(2, n, n+1);
imshow(imcomplement(Gmag));
imshow(Gmag);

mu = inf;
subplot(2, n, 2);
img_inf = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
imshow(img_inf);
title({['\mu = ', num2str(mu)], ['SSIM = ', num2str(ssim(img_inf, ground_truth))]});
[Gmag,Gdir] = imgradient(img_inf, 'central');
subplot(2, n, n+2);
imshow(imcomplement(Gmag));
imshow(Gmag);

mu=0.01;
    subplot(2, n, 3);
    img = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
    imshow(img);
    title({['\mu = ', num2str(mu)], ['SSIM = ', num2str(ssim(img, ground_truth))]});
    [Gmag,Gdir] = imgradient(img, 'central');
    subplot(2, n, n+3);
    imshow(imcomplement(Gmag));
imshow(Gmag);

% for i = 5 : -1 : 1
%     if i == 5
%         mu = 10;
%     elseif i == 4
%         mu = 1;
%     elseif i == 3
%         mu = 0.5;
%     elseif i == 2
%         mu = 0.1; 
%     elseif i == 1
%         mu = 10^-10; 
%     end
%     subplot(2, n, 9-i);
%     img = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
%     imshow(img);
%     title({['\mu = ', num2str(mu)], ['SSIM = ', num2str(ssim(img, ground_truth))]});
%     [Gmag,Gdir] = imgradient(img, 'central');
%     subplot(2, n, n+9-i);
%     imshow(imcomplement(Gmag));
% imshow(Gmag);
% end
% 
% subplot(2, n, n);
% imshow(ground_truth);
% title('ground truth');
% [Gmag,Gdir] = imgradient(ground_truth, 'central');
% subplot(2, n, n+n);
% imshow(imcomplement(Gmag));
% imshow(Gmag);