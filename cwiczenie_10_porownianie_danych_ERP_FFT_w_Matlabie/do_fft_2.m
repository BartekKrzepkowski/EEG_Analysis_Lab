%% funckcja spoectrogram - liczy miegnÄ…ce FFT dla jednego kanaÅ‚u, w wyniku dostajemy zmienna z wynikami z kolejnych okiem - TO nam daje rozrzut konieczny do policzenia statystyk
% musimy policzyÄ‡ dla kolejnych kanaÅ‚Ã³w

oknoFFT = 512; %liczba prÃ³bek w oknie analizy FFT
przes = oknoFFT/2; %liczba prÃ³bek o ktÃ³re przesÃ³wamy okno analizy poÅ‚owa okna 

%% A. policzenie FFT z pojedynczych okienek - dataset 1 
datasetNr = 1;   % tu zmiana datasetu -> zmienia tak?ze nazwe powstajacej zmiennej z wynikami 
for kanal = 1 : 5
    fft = abs(spectrogram(double(ALLEEG(datasetNr).data(kanal,:)), oknoFFT, przes, ALLEEG(datasetNr).srate));
    wynikiFFT_dataset_1 (:, :, kanal) = fft;  % 3-wymiarowa macierz (Hz x okna x kanaly)
    clear fft;
end; 

%%  j.w. dataset 2  (oczywiœcie analizê dla kolejnych datasetów tez mo¿na ustawiæ w pêtle)
datasetNr = 2;   % tu zmiana datasetu -> zmieniÄ‡ odpowiednio nazwe powstajacej zmiennej z wynikami 
for kanal = 1 : 5
    fft = abs(spectrogram(double(ALLEEG(datasetNr).data(kanal,:)), oknoFFT, przes, ALLEEG(datasetNr).srate));
    wynikiFFT_dataset_2 (:, :, kanal) = fft; % 3-wymiarowa macierz (Hz x okna x kanaly)
    clear fft;
end; 

%% 5. rysujemy pojedyncze i srednia z el C3 (k 2) z datasetu 1 i 2  - zeby zobaczyc rozrzut danych !
kanal = 4;
figure; hold on;
subplot(1,2,1); hold on;
    plot(wynikiFFT_dataset_1(:, :, kanal));
    plot(mean(wynikiFFT_dataset_1(:, :, kanal), 2),'-y*')
    xlim([0 45]);    % ograniczenie osi Y do 45 Hz
    xlabel('czestotliwosci [Hz]');   %  opsi osi X
    ylabel('amplituda [mV^2]');    % opis osi Y
    grid on;  % wyswietlanie siatki 
    title(['spectrogram, osoba z grupy  ', ALLEEG(1).group,', elektroda ',ALLEEG(datasetNr).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuÅ‚ podaje liczbe prÃ³bek w oknie
%   
subplot(1,2,2); hold on;
    plot(wynikiFFT_dataset_2(:, :, kanal));
    plot(mean(wynikiFFT_dataset_2(:, :, kanal), 2),'-y*')
    xlim([0 45]);      xlabel('czestotliwosci [Hz]');      ylabel('amplituda [mV^2]');      grid on;  
    title(['spectrogram, osoba z grupy  ', ALLEEG(2).group,', elektroda ',ALLEEG(2).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuÅ‚ podaje liczbe prÃ³bek w oknie

%% 6. obraz wykres srednie dla 5 kanalow - oba datasety
figure; hold on;
subplot(1,2,1), hold on;
    plot(squeeze(mean(wynikiFFT_dataset_1, 2)));
      %  xlim([0 45]);    
        ylabel('amplituda');     xlabel('czestotliwosci [Hz]'); grid on; 
    title(['srednie spektrum mocy, osoba z grupy  ', ALLEEG(1).group,', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuÅ‚ podaje liczbe prÃ³bek w oknie
    legend(ALLEEG(1).chanlocs.labels)

subplot(1,2,2), hold on;
    plot(squeeze(mean(wynikiFFT_dataset_2, 2)));
    xlim([0 45]);      ylabel('amplituda');    xlabel('czestotliwosci [Hz]'); grid on;
    title(['srednie spektrum mocy, osoba z grupy  ', ALLEEG(2).group,', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuÅ‚ podaje liczbe prÃ³bek w oknie   
    legend(ALLEEG(2).chanlocs.labels)
%% 7. figura zestawienie sredniego FFT z 2 osób dla kazej elekotrdy - 5 subplotow
figure; hold on;
for kanal = 1:5
    subplot(1, 5, kanal); hold on; 
        plot(squeeze(mean(wynikiFFT_dataset_1(:, :, kanal), 2)),'r');
        plot(squeeze(mean(wynikiFFT_dataset_2(:, :, kanal), 2)),'b');
        xlim([0 45]) ;  ylim([0 0.8]); ylabel('amplituda');    xlabel('czestotliwosci [Hz]'); grid on;
        title(['elektorda ', ALLEEG(datasetNr).chanlocs(kanal).labels])
        legend(['grupa ',ALLEEG(1).group; 'grupa ',ALLEEG(2).group]);
end;    
    
%%  A. proste statystyki t-test dla 2 probek zmiennych - 1 osoba miedzy kanalami:
% A.  t-test dla roznicy amplitud w danej czestotliwosci u jednej osoby dataset 1 potem 2 
datasetNr = 2;
kanal1 = 2;  
kanal2 = 4; 
freq = 13; %                       (Hz,okna,kanal)
[h p] = ttest2(wynikiFFT_dataset_2(freq, :, kanal1), wynikiFFT_dataset_2(freq, :, kanal2));

%wpisaæ wynik w fugurê z punktu 6
gtext(['osoba z gr 2 , czêstotliwoœæ ',int2str(freq),' Hz ', ALLEEG(datasetNr).chanlocs(kanal1).labels, ' ver ' ALLEEG(datasetNr).chanlocs(kanal2).labels, ' p= ', num2str(p)])


%%  B. proste statystyki - t-test dla roznicy amplitud danej czestotliwosci miedzy osobami - wynik wpisaÄ‡ w obrazek 7 dla el C3 i C4
kanal = 5;  
freq1 = 11; %                       (Hz,okna,kanal)
freq2 = 12

[h p] = ttest2(wynikiFFT_dataset_1(freq1, :, kanal), wynikiFFT_dataset_2(freq2, :, kanal));
p
%wpisaæ wynik w figurê z punktu 7
gtext([ALLEEG(datasetNr).chanlocs(kanal).labels, ' p= ', num2str(p)])





%%
%clear okno* przes *Hz
save AEP_gr1_i_6_wynikiFFT wyn*
