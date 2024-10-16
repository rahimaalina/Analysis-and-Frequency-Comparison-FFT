%% Load Recorded Signal
[recorded_audio, fs] = audioread('/Users/linarahima/Documents/22051 Signals and Linear Systems In Discrete Time/Record.mp3');

start_time = 0.15;  
end_time = 0.65;    

time_rec = (0:length(recorded_audio)-1) / fs;

start_index = round(start_time * fs);
end_index = round(end_time * fs);

end_index = min(end_index, length(recorded_audio));

trimmed_time = time_rec(start_index:end_index);
trimmed_audio = recorded_audio(start_index:end_index);
num_samples_trimmed = length(trimmed_audio);

subplot(2, 2, 2);
plot(trimmed_time, trimmed_audio, 'r', 'LineWidth', 1.5);  
title('Trimmed Recorded Signal - Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');

%% FFT and Magnitude Spectrum of Recorded Signal
fft_recorded = fft(trimmed_audio);  
n_fft_rec = length(trimmed_audio);  
frequencies_rec = (0:n_fft_rec-1) * (fs / n_fft_rec);  

magnitude_rec = abs(fft_recorded) / n_fft_rec;
magnitude_db_rec = 20 * log10(max(magnitude_rec, eps));  

subplot(2, 2, 4);
plot(frequencies_rec(1:floor(n_fft_rec/2)), magnitude_db_rec(1:floor(n_fft_rec/2)), 'b', 'LineWidth', 1.5);  
title('Magnitude Spectrum of Recorded Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 3000]);

[~, peak_index] = max(magnitude_rec);
detected_frequency = frequencies_rec(peak_index); 

%% Generate Clean Sine Wave Based on Detected Frequency
clean_signal = sin(2 * pi * detected_frequency * trimmed_time);

subplot(2, 2, 1);
plot(trimmed_time, clean_signal, 'g', 'LineWidth', 1.5); 
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Clean Signal - Time Domain');

%% FFT and Magnitude Spectrum of Clean Signal
fft_clean = fft(clean_signal);  
n_fft_clean = length(clean_signal);  

frequencies_clean = (0:n_fft_clean/2-1) * (fs / n_fft_clean);

magnitude_clean = abs(fft_clean(1:n_fft_clean/2)) / n_fft_clean;
magnitude_db_clean = 20 * log10(magnitude_clean);

subplot(2, 2, 3);
plot(frequencies_clean, magnitude_db_clean, 'k', 'LineWidth', 1.5);  
title('Magnitude Spectrum of Clean Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 3000]);
