input_folder = './input/Set5';

ground_truth = imread(fullfile(input_folder, 'woman.png'));
up_scale = 2;
t_max = 100;
tau = 0.2;
beta = 0.05;
lambda_h = 1.63;
lambda_l = 1.6;

ground_truth = rgb2gray(ground_truth);
ground_truth = im2double(ground_truth);

input = imresize(ground_truth, 1/up_scale, 'bicubic');

img = imresize(input, up_scale, 'bicubic');

for iter = 1 : t_max
    img_filter = imgaussfilt(img, 0.8);
    img_filter_down = imresize(img_filter, 1/up_scale, 'bicubic');
    rc = img_filter_down - input;
    rc_up = imresize(rc, up_scale, 'bicubic');
    rc_up_filter = imgaussfilt(rc_up, 0.8);
    
    [Gmag,Gdir] = imgradient(img, 'central');
    Gmag = imcomplement(Gmag);
    Gmag = mat2gray(Gmag);
    [Gc,Gr] = imgradientxy(img, 'central');
    [sigma_l_matrix, distance_l_matrix] = sigma_distance_matrix(Gmag, Gc, Gr);
    sigma_h_matrix = find_sigma_h(sigma_l_matrix);
    [Gc_T, Gr_T] = find_transform_ratio(distance_l_matrix, Gr, Gc, sigma_h_matrix, sigma_l_matrix, lambda_h, lambda_l);
    
    [Gc_Gr, Gr_Gr] = imgradientxy(Gr, 'central');
    [Gc_Gc, Gr_Gc] = imgradientxy(Gc, 'central');
    [Gc_Gr_T, Gr_Gr_T] = imgradientxy(Gr_T, 'central');
    [Gc_Gc_T, Gr_Gc_T] = imgradientxy(Gc_T, 'central');
    
    Div_G = Gr_Gr + Gc_Gc;
    Div_G_T = Gr_Gr_T + Gc_Gc_T;
    gc = Div_G - Div_G_T;
    
    img = img - tau * (rc_up_filter - beta * gc);
    
    subplot(1, 3, 1);
    imshow(input);
    subplot(1, 3, 2);
    imshow(img);
    subplot(1, 3, 3);
    imshow(ground_truth);
    pause(1/1000);
end