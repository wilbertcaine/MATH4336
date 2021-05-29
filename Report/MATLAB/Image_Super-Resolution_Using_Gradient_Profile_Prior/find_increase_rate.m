function ratio = find_increase_rate(curr, dir)
    ratio = 0;
    if dir == 0
        return;
    end
    next = curr;
    if dir > 0
        next = ceil(curr);
    elseif dir < 0
        next = floor(curr);
    end
    
    if next == curr && dir ~= 0
        if dir > 0
            next = curr + 1;
        else
            next = curr - 1;
        end
    end
    
    ratio = (next - curr)/dir;
end

