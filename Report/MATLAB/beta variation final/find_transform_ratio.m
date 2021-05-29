function [Gc_T, Gr_T] = find_transform_ratio(D, Gr, Gc, Sigma_high, Sigma_low, lambda_high, lambda_low)
    [numRows,numCols] = size(D);
    Gr_T = Gr;
    Gc_T = Gc;
    for r = 2 : numRows-1
        for c = 2 : numCols-1
            s_h = Sigma_high(r,c);
            s_l = Sigma_low(r,c);
            if s_h == 0 || s_l == 0
                continue;
            end
            dist = D(r,c);
            AlphaLambda_high = sqrt(gamma(3 / lambda_high) / gamma(1 / lambda_high));
            AlphaLambda_low = sqrt(gamma(3 / lambda_low) / gamma(1 / lambda_low));
            ValueC_exceptSigma = lambda_high / lambda_low * AlphaLambda_high / AlphaLambda_low * gamma(1 / lambda_low) / gamma(1 / lambda_high);
            ValueC = ValueC_exceptSigma * s_l / s_h;
            Ratio = ValueC * exp(-(AlphaLambda_high*dist / s_h) ^ lambda_high + (AlphaLambda_low*dist / s_l) ^ lambda_low);
%             if (Ratio * Gr_T(r,c) < 0) || (1 < Ratio * Gr_T(r,c)) || (Ratio * Gc_T(r,c) < 0) || (1 < Ratio * Gc_T(r,c))
%                 continue;
%             end
            Gr_T(r,c) = Ratio * Gr_T(r,c);
            Gc_T(r,c) = Ratio * Gc_T(r,c);
        end
    end
end

