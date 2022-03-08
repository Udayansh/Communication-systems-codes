%accepts a matrix and converts it into a column vector
%acc to the modulation scheme

function output = matrix_to_column_convertor(bit_matrix, mod_type)
    numsymbols = length(bit_matrix)*mod_type;
    columns = mod_type;
    rows = length(bit_matrix);
    output = zeros(rows*columns, 1);

    for i=1:rows
        for j=1:columns
            output((i-1)*columns + j) = bit_matrix(i, j);
        end
    end
end