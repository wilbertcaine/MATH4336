function img = plot_mu(input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu)
%     disp(beta);
    img = input;

    for scale = 1 : up_scale_factor
        img_input = img;
        img = imresize(img, up_scale, 'bicubic');

        for iter = 1 : t_max
            disp([scale, iter]);
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
%             disp(sum(sum(sigma_h_matrix)));
            [Gc_T, Gr_T] = find_transform_ratio(distance_l_matrix, Gr, Gc, sigma_h_matrix, sigma_l_matrix, lambda_h, lambda_l);
            [Gc_Gr, Gr_Gr] = imgradientxy(Gr, 'central');
            [Gc_Gc, Gr_Gc] = imgradientxy(Gc, 'central');
            [Gc_Gr_T, Gr_Gr_T] = imgradientxy(Gr_T, 'central');
            [Gc_Gc_T, Gr_Gc_T] = imgradientxy(Gc_T, 'central');

            Div_G = Gr_Gr + Gc_Gc;
            Div_G_T = Gr_Gr_T + Gc_Gc_T;
            gc = Div_G - Div_G_T;

%             disp(sum(sum(Gr ~= Gr_T )));
            img = img - tau * (rc_up_filter - beta * gc);
%             disp(max(max(img)));
            img = min(img, 1);
            img = max(img, 0);
        end
    end
end

