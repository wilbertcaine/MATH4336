function u = img2var(imagefile)
    A = imread(imagefile);
    u = double(A)/255;
end