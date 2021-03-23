% CAINE, Wilbert (20584260)

function B = svd_for_image_compression(input_image, n)
    A = imread(input_image);
    [U,S,V] = svd(double(A)/255);
    figure(1);
    semilogy(diag(S), 'o-');
    B = U(:, 1:n) * S(1:n, :) * V';
end

