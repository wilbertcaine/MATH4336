addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\dataset');
addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\Non-Local-Means-master');
addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\NoiseLevel20150203');

filename = 'bird.png';
up_scale = 2; % 2
up_scale_factor = 1;
t_max = 100; % 100
tau = 0.2; % 0.2
beta = 0.05; % 0.05
lambda_h = 1.63; % 1.63
lambda_l = 1.6; % 1.6
gau_sigma = 0.8; % 0.8
mu = 0.1; % 0.1 - 0.5 / Inf

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

noise_sigma = 0.25;
noise = randn(size(input)) * noise_sigma;
input = input + noise;
input = max(input, 0);
input = min(input, 1);

subplot(2, 3, 1);
imshow(input);
title({'noisy LR'});

up_input = imresize(input, up_scale^up_scale_factor, 'bicubic');

subplot(2, 3, 2);
imshow(up_input);
title({'bicubic up-sample', ['SSIM = ', num2str(ssim(up_input, ground_truth))]});

subplot(2, 3, 3);
img = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
imshow(img);
title({'HR of noisy LR', ['SSIM = ', num2str(ssim(img, ground_truth))]});

subplot(2, 3, 4);
denoised_lr = nonLocalMeans(input, noise_sigma, noise_sigma, 7, 21);
noise = input - denoised_lr;
imshow(denoised_lr);
title({'denoised LR'});

subplot(2, 3, 5);
img = plot_mu(denoised_lr, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
imshow(img);
title({'HR of denoised LR'});

subplot(2, 3, 6);
noise_up = imresize(noise, up_scale^up_scale_factor, 'bilinear');
img = img + noise_up;
imshow(img);
title({'HR of denoised LR with noise', ['SSIM = ', num2str(ssim(img, ground_truth))]});
