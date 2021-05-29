function gc = find_gc(img, lambda_h, lambda_l, mu)
    [Gmag,Gdir] = imgradient(img, 'central');
    Gmag = imcomplement(Gmag);
    Gmag = (Gmag - min(min(Gmag))) / (max(max(Gmag)) - min(min(Gmag)));
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
end

