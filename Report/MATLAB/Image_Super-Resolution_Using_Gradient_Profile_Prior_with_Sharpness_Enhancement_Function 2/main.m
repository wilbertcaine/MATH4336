filename = 'head.png';
up_scale = 2; % 2
up_scale_factor = 2;
t_max = 25; % 100
tau = 0.2; % 0.2
beta = 0.05; % 0.05
lambda_h = 1.63; % 1.63
lambda_l = 1.6; % 1.6
gau_sigma = 0.8; % 0.8
mu = 0.2; % 0.1 - 0.5

plot_mu(filename, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, 0);
plot_mu(filename, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);