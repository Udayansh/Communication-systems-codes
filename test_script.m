clc;
close all;
clear;

numbits = 100000;
mod_type = 4; %modulation scheme
numsymbols = numbits/mod_type;
R = 5; %number of repetitions for the Repeater/encoder
I = 4; %parameter for the interleaver

bit_signal = rand(numbits, 1) > 0.5; %original signal
rep_signal = final_repeater(bit_signal, R); %repeated original signal
interleaved_signal = interleaver_deinterleaver(rep_signal, I, 1); %interleaved signal

mod_signal_1 = final_modulator(interleaved_signal, mod_type); %normalised modulated signal
mod_signal_0 = final_modulator(rep_signal, mod_type);

number_of_samples = 20;

BE_prob_values_1 = zeros(number_of_samples, 1);
BE_prob_values_0 = zeros(number_of_samples, 1);

esn0_dB_values = zeros(number_of_samples, 1);

esn0_dB = 0;
for i=1:number_of_samples

    esn0_dB_values(i) = esn0_dB;

    burst_noise_start = ceil(numsymbols/4);
    burst_noise_stop = ceil(3*numsymbols/4);

    %FINDING ERROR PROBABILITY FOR INTERLEAVING/DEINTERLEAVING
    noisy_signal_1 = final_noise_adder(mod_signal_1, length(mod_signal_1), 1, 1, length(mod_signal_1), esn0_dB);
    burst_noisy_signal_1 = final_noise_adder(noisy_signal_1, length(noisy_signal_1), 1, burst_noise_start, burst_noise_stop, esn0_dB/5);
    
    %demod_signal_1 = final_demodulator(noisy_signal_1, mod_type);
    demod_signal_1 = final_demodulator(burst_noisy_signal_1, mod_type);
    deinterleaved_signal = interleaver_deinterleaver(demod_signal_1, I, 0);
    decoded_signal_1 = final_majority_detector(deinterleaved_signal, R);

    %counting bit errors
    bit_error_count = 0;
    for j=1:numbits
        if bit_signal(j) ~= decoded_signal_1(j)
            bit_error_count = bit_error_count + 1;
        end
    end

    BE_prob_values_1(i) = bit_error_count/numbits;
    
    %FINDING ERROR PROBABILITY WITHOUT USING INTERLEAVER/DEINTERLEAVER
    noisy_signal_0 = final_noise_adder(mod_signal_0, length(mod_signal_0), 1, 1, length(mod_signal_0), esn0_dB);
    burst_noisy_signal_0 = final_noise_adder(noisy_signal_0, length(noisy_signal_0), 1, burst_noise_start, burst_noise_stop, esn0_dB/5);
    
    %demod_signal_0 = final_demodulator(noisy_signal_0, mod_type);
    demod_signal_0 = final_demodulator(burst_noisy_signal_0, mod_type);
    decoded_signal_0 = final_majority_detector(demod_signal_0, R);
    
    %counting bit errors
    bit_error_count = 0;
    for j=1:numbits
        if bit_signal(j) ~= decoded_signal_0(j)
            bit_error_count = bit_error_count + 1;
        end
    end

    BE_prob_values_0(i) = bit_error_count/numbits;

    esn0_dB = esn0_dB + 1;
end

figure
semilogy(esn0_dB_values, BE_prob_values_1);
hold on;
semilogy(esn0_dB_values, BE_prob_values_0);
xlabel('Es/N0 in dB');
ylabel('bit error probability');
hold off;
%title('bit error probabilities with presence of burst noise');
legend('with interleaver', 'without interleaver');

    
