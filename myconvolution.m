function output = myconvolution(x, y)
    l = length(x);
    m = length(y);

    X = [x, zeros(1, m)];
    Y = [y, zeros(1, l)];

    for i=1:l+m-1
        CV(i)=0;
        for j=1:l
            if ((i-j+1)>0)
                CV(i)=CV(i)+(X(j)*Y(i-j+1));
            else
            end
        end
    end

    output = CV;
