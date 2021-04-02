function [S, D] = sigma_distance_matrix(Gmag, Gc, Gr)
    [numRows,numCols] = size(Gc);
    S = zeros(numRows,numCols);
    D = zeros(numRows,numCols);
    for r = 2 : numRows-1
        for c = 2 : numCols-1
            len = zeros(2,1);
            pr = zeros(2, 4*max(numRows,numCols));
            pc = zeros(2, 4*max(numRows,numCols));
            mag = zeros(2, 4*max(numRows,numCols));
            for dir = -1 : 2 : 1
                if dir == -1
                    id = 1;
                else
                    id = 2;
                end
                    
                curr_mag = Gmag(r, c);
                prev_mag = curr_mag;
                has_next = true;
                curr_r = r;
                curr_c = c;
                dir_r = dir * Gr(r,c);
                dir_c = dir * Gc(r,c);
                while true
                    len(id) = len(id) + 1;
                    pr(id, len(id)) = curr_r;
                    pc(id, len(id)) = curr_c;
                    mag(id, len(id)) = curr_mag;
                    
                    ratio_r = find_increase_rate(curr_r, dir_r);
                    ratio_c = find_increase_rate(curr_c, dir_c);
                    
                    ratio = min(ratio_r, ratio_c);
%                     if ratio == 0
%                         ratio = max(ratio_r, ratio_c);
%                     end
%                     if ratio == 0
%                         break;
%                     end
                    curr_r = curr_r + ratio*dir_r;
                    curr_c = curr_c + ratio*dir_c;
%                     disp(curr_r);
                    has_next = (2 < curr_r) && (curr_r < numRows-1) && (2 < curr_c) && (curr_c < numCols-1);
                    if ~has_next
                        break;
                    end
                    
                    prev_mag = curr_mag;
                    curr_mag = find_magnitude(Gmag, curr_r, curr_c);
                    if prev_mag >= curr_mag
                        break;
                    end
                    
                end
            end
                
            id = 2;
            if len(1) > 1 && len(2) == 1
                id = 1;
            elseif len(1) == 1 && len(2) > 1
                id = 2;
            else
                D1 = sqrt((pr(1, len(1))-pr(1, 1))^2 + (pc(1, len(1))-pc(1, 1))^2);
                D2 = sqrt((pr(2, len(2))-pr(2, 1))^2 + (pc(2, len(2))-pc(2, 1))^2);
                if D1 < D2
                    id = 1;
                end
            end

            D(r,c) = sqrt((pr(id, len(id))-pr(id, 1))^2 + (pc(id, len(id))-pc(id, 1))^2);
            numer = 0;
            denom = 0;
            for i = 1 : len(id)
                d = sqrt((pr(id, len(id))-pr(id, i))^2 + (pc(id, len(id))-pc(id, i))^2);
                m = mag(id, i);
                numer = numer + m*(d^2);
                denom = denom + m;
            end
            S(r,c) = sqrt(numer/denom);
        end
    end
end

