%accepts a column vector of 'numbits' elements and returns another
%column vector of the same size, but with the positions of the elements
%scrambled (in a deterministic way, that is)
%to be used in combination with a repeater

function output = interleaver_deinterleaver(bit_signal, R, scramble_or_descramble)
    numbits = length(bit_signal);
    output = zeros(numbits, 1);

    if scramble_or_descramble == 1
        columns = R;
        rows = ceil(numbits/R);
    elseif scramble_or_descramble == 0
        columns = ceil(numbits/R);
        rows = R;
    end

    intermediate_matrix = column_to_matrix_convertor(bit_signal, columns);

    for i=1:columns
        for j=1:rows
            output((i-1)*rows + j) = intermediate_matrix(j, i);
        end
    end
end
