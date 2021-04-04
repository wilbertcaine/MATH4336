function mag = find_magnitude(Gmag, curr_r, curr_c)
    diff_r = curr_r - floor(curr_r);
    diff_c = curr_c - floor(curr_c);
    if diff_r == 0 && diff_c == 0
        mag = Gmag(floor(curr_r), floor(curr_c));
    elseif diff_r > diff_c
        mag = Gmag(floor(curr_r), floor(curr_c))*(1-diff_r) + Gmag(ceil(curr_r), floor(curr_c))*diff_r;
    else
        mag = Gmag(floor(curr_r), floor(curr_c))*(1-diff_c) + Gmag(floor(curr_r), ceil(curr_c))*diff_c;
    end
end

