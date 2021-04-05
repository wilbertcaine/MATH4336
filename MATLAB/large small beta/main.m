addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\dataset');

filename = 'Ringing_artifact.png';
up_scale = 2; % 2
up_scale_factor = 2;
t_max = 25; % 100
tau = 0.2; % 0.2
beta = 0.5; % 0.05
lambda_h = 1.63; % 1.63
lambda_l = 1.6; % 1.6
gau_sigma = 0.8; % 0.8
mu = 0.2; % 0.1 - 0.5

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
up_input = imresize(input, up_scale^up_scale_factor, 'bicubic');

mu = 0;
beta = 0;
img_0 = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
% beta = 0.005;
% img_0005 = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
% beta = 0.05;
% img_005 = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
% beta = 0.1;
% img_01 = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
% beta = 1;
% img_1 = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
beta = 1;
img_1 = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);

subplot(1, 2, 1);
imshow(img_0);
title('\beta = 0');
subplot(1, 2, 2);
imshow(img_1);
title('\beta = 0.5');

% subplt(1, 2, 1);
% imshow(img_0);
% title('beta = 0');
% subplot(1, 2, 2);
% imshow(img_05);
% title('beta = 0.5');

% n = 8;
% subplot(1, n, 1);
% imshow(input);
% title({'input', 'bilinear down-sample', '(factor of 4)'});
% subplot(1, n, 2);
% imshow(up_input);
% title({'bicubic up-sample', ['SSIM = ', num2str(ssim(up_input, ground_truth))]});
% subplot(1, n, 3);
% imshow(img_0);
% title({'\beta = 0', ['SSIM = ', num2str(ssim(img_0, ground_truth))]});
% subplot(1, n, 4);
% imshow(img_0005);
% title({'\beta = 0.005', ['SSIM = ', num2str(ssim(img_0005, ground_truth))]});
% subplot(1, n, 5);
% imshow(img_005);
% title({'\beta = 0.05', ['SSIM = ', num2str(ssim(img_005, ground_truth))]});
% subplot(1, n, 6);
% imshow(img_01);
% title({'\beta = 0.1', ['SSIM = ', num2str(ssim(img_01, ground_truth))]});
% subplot(1, n, 7);
% imshow(img_1);
% title({'\beta = 1', ['SSIM = ', num2str(ssim(img_1, ground_truth))]});
% subplot(1, n, n);
% imshow(ground_truth);
% title('ground truth');