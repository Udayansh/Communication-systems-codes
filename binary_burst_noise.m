function output = binary_burst_noise(bit_signal, start_index, stop_index)
    numbits = length(bit_signal);
    output = zeros(numbits, 1);

    for i=1:numbits
        output(i) = bit_signal(i);
    end

    for j=start_index:stop_index
        output(j) = 1;
    end
end
