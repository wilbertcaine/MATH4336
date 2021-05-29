addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\dataset');

filename = 'Ringing_artifact.png';
up_scale = 2; % 2
up_scale_factor = 1;
t_max = 100; % 100
tau = 0.2; % 0.2
beta = 0.05; % 0.05
lambda_h = 1.63; % 1.63
lambda_l = 1.6; % 1.6
gau_sigma = 0.8; % 0.8
mu = 0.5; % 0.1 - 0.5 / Inf

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


subplot(1, 3, 2);
imshow(ground_truth);
title('ground truth');
subplot(1, 3, 1);

beta = 0.0000001;
img = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
imshow(img);
title(['\beta = ', num2str(beta)]);

beta = 0.25;
img = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
subplot(1, 3, 3);
imshow(img);
title(['\beta = ', num2str(beta)]);