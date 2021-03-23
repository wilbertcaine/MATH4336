original_image = 'Fig3.37(a).jpg';
A = imread(original_image);

for i = 0 : 5
    n = 2^i;
    B = svd_for_image_compression(original_image, n);
    close(1);
    figure(2);
    subplot(6, 2, 2*i+1);
    imshow(A);
    subplot(6, 2, 2*i+2);
    imshow(B);
    rel_err = norm(B, 'fro');
    title(rel_err);
end