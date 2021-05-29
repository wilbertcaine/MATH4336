% CAINE, Wilbert (20584260)

function MF = median_filter()
    LAF = linear_average_filter();
    A = imread('Fig3.37(a).jpg');
    MF = A;
    [row, col] = size(A);
    for i = 2 : row-1
        for j = 2 : col-1
            f = [];
            for s = i-1 : i+1
                for t = j-1 : j+1
                    f(end+1) = A(s,t);
                end
            end
            MF(i,j) = median(f);
        end
    end
    subplot(2, 2, 1);
    imshow(A);
    subplot(2, 2, 2);
    imshow(LAF);
    subplot(2, 2, 3);
    imshow(A);
    subplot(2, 2, 4);
    imshow(MF);
end

