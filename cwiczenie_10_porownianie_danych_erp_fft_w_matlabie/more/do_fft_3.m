%% funckcja spoectrogram - liczy miegnące FFT dla jednego 
% stałe zmienne: 

oknoFFT = 256; %liczba próbek w oknie analizy FFT
przes = oknoFFT/2; %liczba próbek o które przesówamy okno analizy połowa okna 



%% A. rysunki FFT z pojedynczych okienek i średnie dla kanałów 2 i/lub 4 - elekotrdy C3 i C4 

kanal = 2;
datasetNr = 1;

eval(['wynikiFFT_gr_',ALLEEG(datasetNr).group,'_kanal_', int2str(kanal),' = abs(spectrogram(double(ALLEEG(datasetNr).data(kanal,:)), oknoFFT, przes, ALLEEG(datasetNr).srate))']);
figure; hold on;
subplot(1,2,datasetNr); hold on;
    plot(wynikiFFT1);
    plot(mean(wynikiFFT1,2),'-y*')
    xlim([0 45]);
    xlabel('czestotliwosci [Hz]');
    ylabel('amplituda [mV^2]');
    grid on;  
    title(['spectrogram, osoba z grupy  ', ALLEEG(datasetNr).group,', elektroda ',ALLEEG(datasetNr).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuł podaje liczbe próbek w oknie

datasetNr = 2;
['wynikiFFT_gr_',ALLEEG(datasetNr).group,'_kanal_', int2str(kanal)] = abs(spectrogram(double(ALLEEG(datasetNr).data(kanal,:)), oknoFFT, przes, ALLEEG(datasetNr).srate));
subplot(1,2,datasetNr); hold on;
    plot(wynikiFFT2);
    plot(mean(wynikiFFT2,2),'-y*')
    xlim([0 45]);
    xlabel('czestotliwosci [Hz]');
    ylabel('amplituda [mV^2]');
    grid on;  
    title(['spectrogram, osoba z grupy  ', ALLEEG(datasetNr).group,', elektroda ',ALLEEG(datasetNr).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuł podaje liczbe próbek w oknie

%% obraz wykres 3d FFT z wszystkich wszystkich okien 
figure; hold on;
subplot(2,1,1), hold on;
    imagesc(wynikiFFT1)
    ylim([0 45]); % ograniczenie osi Y do 45 Hz
    set(gca,'YDir','normal')
    colormap(jet); %gray
    xlabel('kolejne okna analizy');
    ylabel('czestotliwosci [Hz]');
    title(['spektrum mocy, osoba z grupy  ', ALLEEG(1).group,', elektroda ',ALLEEG(1).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuł podaje liczbe próbek w oknie
caxis(caxis)
subplot(2,1,2), hold on;
    imagesc(wynikiFFT2)
    ylim([0 45]); % ograniczenie osi Y do 45 Hz
    set(gca,'YDir','normal')
    colormap(jet); %gray
    xlabel('kolejne okna analizy');
    ylabel('czestotliwosci [Hz]');
    grid on;  
    title(['spektrum mocy, osoba z grupy  ', ALLEEG(2).group,', elektroda ',ALLEEG(2).chanlocs(kanal).labels , ', okno FFT ', int2str(oknoFFT),' probek, przesuniecie ',int2str(przes),' probek']) % tytuł podaje liczbe próbek w oknie

%% 
%%   proste statystyki - t-test dla różnicy amplitud w danej częstotkiwosci µ latencji u jednej osoby 
datasetNr = 1;
kanal1 = 2; % C3 albo C4 
kanal2 = 1; % Cz, T3, T4
%f - 12 / 13  Hz 
freq = 12; % w Hz 
[h p] = ttest2(ALLEEG(datasetNr).data(kanal1, lat_pkt,:), ALLEEG(datasetNr).data(kanal2, lat_pkt,:));
p

%% 5.B. proste statystyki - t-test dla różnicy amplitud danej fali między osobami wpisać w obrazek  min. dla ele Cz 
kanal = 3;
%N100, P200, N400 ew, P300
lat1 = 400; % ms po 0
lat1_pkt = (lat1+abs(ALLEEG(1).xmin)*1000)/5 %punkty od początku okna, nie ms od 0 , podiał przez 5 bo taka jest długość próbki przy częstości próbkowanie 200 Hz

lat2 = 400;  % ms po 0
lat2_pkt = (lat2+abs(ALLEEG(2).xmin)*1000)/5 %punkty od początku okna,

[h p] = ttest2(ALLEEG(1).data(kanal, lat1_pkt,:), ALLEEG(2).data(kanal,lat2_pkt,:));
p


%% 5.C. proste statystyki - t-test dla różnucy amplitud pik-to-pik (wybrane ekstremalne latencje dla każdej osoby ) między osobami 
kanal = 3;
lat1_1 = 115; %N100 grupa 1
lat1_2 = 175; %P200 grupa 1
lat2_1 = 205; %P200 grupa 6
lat2_2 = 370; % N400 grupa 6

lat1_1pkt = (lat1_1+abs(ALLEEG(2).xmin)*1000)/5
lat1_2pkt = (lat1_2+abs(ALLEEG(2).xmin)*1000)/5
lat2_1pkt = (lat2_1+abs(ALLEEG(2).xmin)*1000)/5
lat2_2pkt = (lat2_2+abs(ALLEEG(2).xmin)*1000)/5

[h p] = ttest2(abs(ALLEEG(1).data(kanal,lat1_1pkt,:))+abs(ALLEEG(1).data(kanal,lat1_2pkt,:)) , abs(ALLEEG(2).data(kanal,lat2_1pkt,:))+abs(ALLEEG(2).data(kanal,lat2_2pkt,:)));




%%
clear okno* przes *Hz

