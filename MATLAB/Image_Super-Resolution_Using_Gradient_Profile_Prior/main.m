up_scale = 2;
input_folder = './input/Set5';

ground_truth = imread(fullfile(input_folder, 'untitled2.png'));
up_scale_factor = 2;
t_max = 25;
tau = 0.2; % 0.2
beta = 0.05; % 0.05
lambda_h = 1.63;
lambda_l = 1.6;
gau_sigma = 0.8;

ground_truth = rgb2gray(ground_truth);
ground_truth = im2double(ground_truth);

input = imresize(ground_truth, 1/up_scale^up_scale_factor, 'bilinear');
up_input = imresize(input, up_scale^up_scale_factor, 'bilinear');
img = input;

for scale = 1 : up_scale_factor

    img_input = img;
    img = imresize(img, up_scale, 'bilinear');

    for iter = 1 : t_max
        img_filter = imgaussfilt(img, gau_sigma);
        img_filter_down = imresize(img_filter, 1/up_scale, 'bilinear');
        rc = img_filter_down - img_input;
        rc_up = imresize(rc, up_scale, 'bilinear');
        rc_up_filter = imgaussfilt(rc_up, gau_sigma);

        [Gmag,Gdir] = imgradient(img, 'central');
        Gmag = imcomplement(Gmag);
        Gmag = (Gmag - min(min(Gmag))) / (max(max(Gmag)) - min(min(Gmag)));
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
        img = min(img, 1);
        img = max(img, 0);
        if mod(iter, 5) == 0
            subplot(1, up_scale_factor+3, 1);
            imshow(up_input);
            title('bicubic');
            subplot(1, up_scale_factor+3, 2);
            imshow(Gmag);
            title('Gmag');
            subplot(1, up_scale_factor+3, scale+2);
            imshow(img);
            title([num2str(up_scale^scale), 'X']);
            subplot(1, up_scale_factor+3, up_scale_factor+3);
            imshow(ground_truth);
            title('ground truth');
            pause(0.001);
        end
    end
end