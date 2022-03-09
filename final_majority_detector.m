%accepts an column of size 'numbits' as well as the number of repetitions
%(R) used to obtain it. returns another column of length (numbits/R) with
%each element corresponding the majority element in a set of 'R' elements
%in the original array

function output = final_majority_detector(bit_signal, R)
    numbits = length(bit_signal);
    numsyms = ceil(numbits/R); %number of elements in the majority array
    output = zeros(numsyms, 1);

    for i=1:numsyms
        num_ones = 0;

        for j=(i-1)*R + 1 : R*i
            if j<=numbits
                if bit_signal(j) == 1
                    num_ones = num_ones + 1;
                end
            end
        end

        if num_ones > (R+1)/2
            output(i) = 1;
        end
    end
end

