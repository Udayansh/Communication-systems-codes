%accepts a column vector of length 'numbits' and returns another column
%vector of length 'numbits * R' with each bit repeated 'R' times

function output = final_repeater(bit_signal, R)
    numbits = length(bit_signal);
    output = zeros(R*numbits, 1);

    for i=1:numbits
        for j = (i-1)*R + 1 : R*i
            output(j) = bit_signal(i);
        end
    end
end
