% CAINE, Wilbert (20584260)

function LAF = linear_average_filter()
    A = imread('Fig3.37(a).jpg');
    LAF = A;
    [row, col] = size(A);
    for i = 2 : row-1
        for j = 2 : col-1
            f = 0;
            for s = i-1 : i+1
                for t = j-1 : j+1
                    f = f + uint64(A(s,t));
                end
            end
            LAF(i,j) = f/9;
        end
    end
    subplot(1, 2, 1);
    imshow(A);
    subplot(1, 2, 2);
    imshow(LAF);
end

