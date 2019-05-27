%% do FFT
oknoFFT = 256; %liczba probek w oknie analizy FFT - potegi 2 : 64 , 256, 2048
przes = oknoFFT/2; %liczba pr贸bek o kt贸re przes贸wamy okno analizy po艂owa okna 
kanal = 2; %wybieamy kana? kt髍y zostanie narysowany
tytul = 'oczy zamkniete/otwarte'; % wstawi? w?a?ciwy tekst do tytu?u - jakie to dane? 

max_Hz = EEG.srate/2; %sampling_rate
min_Hz = EEG.srate/oknoFFT;
osHz = linspace(min_Hz, max_Hz, (oknoFFT/2)-1);

dane_EEG_wlinii = reshape(EEG.data,size(EEG.data,1),size(EEG.data,2)*size(EEG.data,3));
wynikFFT=eegblockfft(dane_EEG_wlinii(kanal,:),oknoFFT,przes);
%wynikFFT=eegblockfft(EEG.data(:,:,1),oknoFFT,przes);

figure; bar(osHz, wynikFFT);
%legend(EEG.chanlocs.labels);
legend(EEG.chanlocs(kanal).labels);
%title -> otwarte / zamkniete - wpisa? poprawnie w tytule  
title([tytul,', okno FFT ',int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytu艂 podaje liczbe pr贸bek w oknie
xlabel('Hz');
ylabel('uV')

clear okno* przes *Hz dane_EEG*



% ppoprawic tekst zgodnie z analizowanymidanymi