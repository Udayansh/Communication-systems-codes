%accepts a column vector of length "numbits" and converts it into a matrix
%of desired no. of columns

function output = column_to_matrix_convertor(bit_column, mod_type)
    numbits = length(bit_column);
    rows = ceil(numbits/mod_type); %deciding number of rows in the output array
    output = zeros(rows, mod_type);

    for i=1:numbits
        row = fix((i-1)/mod_type) + 1;
        column = mod(i-1, mod_type) + 1;
        output(row, column) = bit_column(i);
    end
end






    
