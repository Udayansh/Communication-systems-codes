%accepts a column vector of length "numbits" and returns a column vector 
%consisting of normalised complex numbers acc. to the modulation
%scheme chosen ('mod_type' = 1 for BPSK, 2 for QPSK, 4 for 16QAM)

function output = final_modulator(bit_signal, mod_type)

    %first converting the column vector into an acceptable matrix for the
    %different modulator functions
    bit_matrix = column_to_matrix_convertor(bit_signal, mod_type);

    %the number of different symbols in the bit_matrix
    numsymbols = length(bit_matrix);

    output = zeros(numsymbols, 1);
    
    %for BPSK modulation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if mod_type == 1

        for k=1:numsymbols

            if bit_matrix(k, 1) == 0
                real_part = -1;
            elseif bit_matrix(k,1) == 1
                real_part = 1;
            end

            output(k, 1) = real_part;
        end

            
    %for QPSK modulation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %using Gray code scheme
    elseif mod_type == 2

        for k=1:numsymbols

            if bit_matrix(k, 1) == 0
                real_part = -1;
            elseif bit_matrix(k, 1) == 1
                real_part = 1;
            end

            if bit_matrix(k, 2) == 0
                imag_part = -1;
            elseif bit_matrix(k, 2) == 1
                imag_part = 1;
            end

            output(k, 1) = (real_part + 1j*imag_part)/sqrt(2);
        end

    %for 16QAM modulation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %using Gray code scheme
    elseif mod_type == 4

        for k=1:numsymbols

            if bit_matrix(k,1) == 0 && bit_matrix(k,2) == 0
                real_part = -3;
            elseif bit_matrix(k,1) == 0 && bit_matrix(k,2) == 1
                real_part = -1;
            elseif bit_matrix(k,1) == 1 && bit_matrix(k,2) == 1
                real_part = 1;
            elseif bit_matrix(k,1) == 1 && bit_matrix(k,2) == 0
                real_part = 3;
            end
    
            if bit_matrix(k,3) == 0 && bit_matrix(k,4) == 0
                imag_part = -3;
            elseif bit_matrix(k,3) == 0 && bit_matrix(k,4) == 1
                imag_part = -1;
            elseif bit_matrix(k,3) == 1 && bit_matrix(k,4) == 1
                imag_part = 1;
            elseif bit_matrix(k,3) == 1 && bit_matrix(k,4) == 0
                imag_part = 3;
            end

            output(k) = (real_part + 1j*imag_part)/sqrt(10);
        end
    end

   



    