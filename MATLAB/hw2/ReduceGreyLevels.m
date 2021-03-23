function v = ReduceGreyLevels(u, Level)
    A = round(u * (Level-1));
    v = double(A)/(Level-1);
end