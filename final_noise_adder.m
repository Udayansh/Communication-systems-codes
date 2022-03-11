%adds guassian noise to the signal with given value of esn0 in dB
%adds noise to all elements of a 'rows' * 'columns' matrix
%for column vectors, set 'columns' = 1

function output = normalised_gaussian_noise_adder(transmitted_signal, rows, columns, start_index, stop_index, esn0_dB)
    output = zeros(rows, columns);
    esn0 = 10^(-esn0_dB/20);

    for k=start_index:stop_index
        for j=1:columns
            noise = (randn(1,1) + 1j*randn(1,1))/sqrt(2);
            output(k,j) = transmitted_signal(k,j) + noise*esn0;
        end
    end
end

