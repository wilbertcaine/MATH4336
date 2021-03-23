function var2img(u, imagefile)
    A = uint8(u*255);
    imwrite(A, imagefile);
end