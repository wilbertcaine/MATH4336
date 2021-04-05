function Sigma_high = find_sigma_h(Sigma_low, mu)
    a = [0, 0.100000, 0.300000, 0.500000, 0.700000, 0.900000, 1.100000, 1.300000, 1.500000, 1.700000, 1.900000, 2.100000, 2.300000, 2.500000, 2.700000, 2.900000, 3.100000, 3.300000, 3.500000, 3.700000, 3.900000, 4.100000, 4.300000, 4.500000, 4.700000, 4.900000 ];
    b = [0, 0.1, 0.534504, 0.650185, 0.724020, 0.792875, 0.872219, 0.973969, 1.104349, 1.262270, 1.437783, 1.624416, 1.815510, 2.020180, 2.210189, 2.404601, 2.633510, 2.844732, 3.071728, 3.296107, 3.525818, 3.794026, 4.012113, 4.262773, 4.404142, 4.682555 ];
    [numRows,numCols] = size(Sigma_low);
    Sigma_high = zeros(numRows,numCols);
    for r = 1 : numRows
        for c = 1 : numCols
            bFound = false;
            s_l = Sigma_low(r,c);
            s_h = s_l;
            for i = 1 : size(a,2)-1
                if a(i) <= s_l && s_l < a(i+1)
                    bFound = true;
                    s_h = b(i) + (b(i+1) - b(i))*(s_l - a(i))/0.2;
                    break;
                end
            end
            if mu ~= inf
                Sigma_high(r,c) = (1 - exp(-mu*s_h)) * s_h;
            else
                Sigma_high(r,c) = s_h;
            end
        end
    end
end

