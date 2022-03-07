%accepts a column vector of normalised complex numbers of length 'numsymbols'
%and returns a matrix of bits of desired dimensions as per the the modulation scheme
%scheme chosen (1 for BPSK, 2 for QPSK, 4 for 16 QAM)

function output = final_demodulator(received_signal, mod_type)
    numsymbols = length(received_signal);
    matrix_output = zeros(numsymbols, mod_type);

    %output = matrix_to_column_convertor(matrix_output, mod_type);
    
    %for BPSK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if mod_type == 1

        for k=1:numsymbols

            if received_signal(k) > 0
                matrix_output(k, 1) = 1;

            elseif received_signal(k) < 0
                matrix_output(k, 1) = 0;

            end
        end

        output = matrix_to_column_convertor(matrix_output, mod_type);
    
    %for QPSK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif mod_type == 2

        for k=1:numsymbols

            if real(received_signal(k)) > 0
                matrix_output(k, 1) = 1;
            elseif real(received_signal(k)) < 0
                matrix_output(k, 1) = 0;
            end

            if imag(received_signal(k)) > 0
                matrix_output(k, 2) = 1;
            elseif imag(received_signal(k)) < 0
                matrix_output(k, 2) = 0;
            end
        end

        output = matrix_to_column_convertor(matrix_output, mod_type);

    
    %for 16QAM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %using Gray code scheme
    elseif mod_type == 4

        for k=1:numsymbols
            if real(received_signal(k)) < -2/sqrt(10)
                matrix_output(k, 1) = 0;
                matrix_output(k, 2) = 0;
            elseif real(received_signal(k)) > 2/sqrt(10)
                matrix_output(k, 1) = 1;
                matrix_output(k, 2) = 0;
            elseif real(received_signal(k)) >= -2/sqrt(10) && real(received_signal(k)) < 0
                matrix_output(k, 1) = 0;
                matrix_output(k, 2) = 1;
            elseif real(received_signal(k)) <= 2/sqrt(10) && real(received_signal(k)) >= 0
                matrix_output(k, 1) = 1;
                matrix_output(k, 2) = 1;
            end
    
            if imag(received_signal(k)) < -2/sqrt(10)
                matrix_output(k, 3) = 0;
                matrix_output(k, 4) = 0;
            elseif imag(received_signal(k)) > 2/sqrt(10)
                matrix_output(k, 3) = 1;
                matrix_output(k, 4) = 0;
            elseif imag(received_signal(k)) >= -2/sqrt(10) && imag(received_signal(k)) < 0
                matrix_output(k, 3) = 0;
                matrix_output(k, 4) = 1;
            elseif imag(received_signal(k)) <= 2/sqrt(10) && imag(received_signal(k)) >= 0
                matrix_output(k, 3) = 1;
                matrix_output(k, 4) = 1;
            end
        end

        output = matrix_to_column_convertor(matrix_output, mod_type);
    end

