%% do FFT  
%jesli chcemy rysować subploty można je przygotowac w oknie figury z menu -

% figure; hold on;   i myszą ew. Insert > Axes 

datasetNr = 1;

oknoFFT = 256; %liczba próbek w oknie analizy FFT
przes = oknoFFT/2; %liczba próbek o które przesówamy okno analizy połowa okna 

max_Hz = ALLEEG(datasetNr).srate/2;
min_Hz = max_Hz/oknoFFT;
osHz = linspace(min_Hz, max_Hz, (oknoFFT/2)-1);

wynikFFT=eegblockfft(ALLEEG(datasetNr).data,oknoFFT,przes);

figure; 
plot(osHz, wynikFFT,'-*');
    xlim([0 45]);
    legend(EEG.chanlocs.labels)
    xlabel('czestotliwosci [Hz]');
    ylabel('amplituda [mV^2]');
    grid on;
    title(['FFT, osoba z grupy  ', ALLEEG(datasetNr).group,', elektroda ',ALLEEG(datasetNr).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuł podaje liczbe próbek w oknie

%clear okno* przes *Hz



