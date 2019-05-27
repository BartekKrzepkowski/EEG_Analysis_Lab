%% do FFT

oknoFFT = 256; %liczba próbek w oknie analizy FFT
przes = oknoFFT/2; %liczba próbek o które przesówamy okno analizy połowa okna 

max_Hz = sampling_rate/2;
min_Hz = max_Hz/oknoFFT;
osHz = linspace(min_Hz, max_Hz, (oknoFFT/2)-1);

wynikFFT=eegblockfft(EEG.data,oknoFFT,przes);

figure; plot(osHz, wynikFFT,'-*');
legend(EEG.chanlocs.labels)
%title('otwarte') %wpisać właścity tytuł 
title(['oczy zamkniete, okno FFT ',int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuł podaje liczbe próbek w oknie

clear okno* przes *Hz



