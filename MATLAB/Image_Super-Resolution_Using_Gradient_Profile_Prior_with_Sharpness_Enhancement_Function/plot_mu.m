function plot_mu(filename, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu)
    addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\dataset');

    ground_truth = imread(filename);

    if size(size(ground_truth), 2) > 2
        ground_truth = rgb2gray(ground_truth);
    end
    ground_truth = im2double(ground_truth);

    input = imresize(ground_truth, 1/up_scale^up_scale_factor, 'bilinear');
    up_input = imresize(input, up_scale^up_scale_factor, 'bicubic');
    img = input;

    for scale = 1 : up_scale_factor
        img_input = img;
        img = imresize(img, up_scale, 'bicubic');

        for iter = 1 : t_max
        disp(iter);
            img_filter = imgaussfilt(img, gau_sigma);
            img_filter_down = imresize(img_filter, 1/up_scale, 'bilinear');
            rc = img_filter_down - img_input;
            rc_up = imresize(rc, up_scale, 'bicubic');
            rc_up_filter = imgaussfilt(rc_up, gau_sigma);

            [Gmag,Gdir] = imgradient(img, 'central');
            Gmag = imcomplement(Gmag);
            [Gc,Gr] = imgradientxy(img, 'central');
            [sigma_l_matrix, distance_l_matrix] = sigma_distance_matrix(Gmag, Gc, Gr);
            sigma_h_matrix = find_sigma_h(sigma_l_matrix, mu);
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
                pos = 0;
                if mu > 0
                    pos = up_scale_factor+3;
                end
                subplot(2, up_scale_factor+3, pos+1);
                imshow(input);
                title('input');
                subplot(2, up_scale_factor+3, pos+2);
                imshow(up_input);
                title('bicubic');
                subplot(2, up_scale_factor+3, pos+scale+2);
                imshow(img);
                title([num2str(up_scale^scale), 'X']);
                subplot(2, up_scale_factor+3, pos+up_scale_factor+3);
                imshow(ground_truth);
                title('ground truth');
                pause(0.01);
            end
        end
    end
end

