u = img2var('Fig2.21a.tif');
for i = 1: 1: 8
    level = 2^i;
    v = ReduceGreyLevels(u, level);
    filename = strcat('Fig2.21a.', int2str(level), '.tif');
    var2img(v, filename);
end