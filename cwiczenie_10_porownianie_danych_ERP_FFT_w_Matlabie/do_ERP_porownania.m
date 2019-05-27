%% Ladujemy datasety podzielone na okna

%%  1. Pojedyncze figury : rysujemy wszystkie pojedyncze ERP i srednia� z każdego datasetu
%EP z kanału np 3 (Cz) ,najpierw dataset 1 potem 2

kanal = 3;
datasetNr = 1;  % !!! tu zmieniamy numer jak chcemy wybrac dataset !!!
%EEG = ALLEEG(datasetNr); % załadowanie do roboczej zmiennej EEG datasetu nr 1 lub 2 - 

figure; hold on ;
plot(ALLEEG(datasetNr).times, squeeze(ALLEEG(datasetNr).data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
%title('osoba z grupy 1, kanał 3 = elekotrda Cz') % poniżej to samo ale z danych:  
title(['osoba z grupy ',ALLEEG(datasetNr).group, ' kanal ', int2str(kanal),' = elekotrda ',ALLEEG(datasetNr).chanlocs(kanal).labels ]);
xlabel('czas [ms]');    % opis osi X 
ylabel('potencjal [mV]');   % opis osi Y
grid on;  % wyświetlanie lini siatki 

% dodajemy do rysunku średnia z tych pojedynczych ERP :
plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'k*');

%% 2.a Figura zlona z wielu (10) obrazow (subplots): ERP i srednie ze wszystkich kanałów obok siebie i z obu datasetów ( w 2 wierszach):
figure; hold on;
% gorny rzad:

datasetNr = 1; % wybor dataset'u
for kanal = 1:ALLEEG(datasetNr).nbchan
    subplot(2,ALLEEG(datasetNr).nbchan, kanal); % komenda wyznacza ile będzie małych rysunków w figurze - w jakiej konfiguracji i gdzie będzie umieszczony bieżąc rysunek - subplot(liczba_wierszy, liczba_kolumn, Nr_obrazka)
    hold on; %komenda pozwala dodawać do obrazka kolejne wykresy
        plot(ALLEEG(datasetNr).times, squeeze(ALLEEG(datasetNr).data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
        plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'k*'); %plot(dane_na_ośX, dane_na_ośY)
    %title('osoba z grupy 6, kanał 3 = elekotrda Cz'): 
    title(['osoba z grupy ',ALLEEG(datasetNr).group, ' kanal ', int2str(kanal),' = elekotrda ',ALLEEG(datasetNr).chanlocs(kanal).labels ]);
    xlabel('czas [ms]');   % opis osi X
    ylabel('potencjal [mV]');  % opis osi Y
    grid on;  % wyświetlanie lini siatki 
end;
%% 2.b drugi wiersz z drugiego zestawu danych:
datasetNr = 2; % wybor dataset'u

for kanal = 1:ALLEEG(datasetNr).nbchan
    subplot(2, ALLEEG(datasetNr).nbchan, ALLEEG(datasetNr).nbchan+kanal); % komenda wyznacza ile będzie małych rysunków w figurze - w jakiej konfiguracji i gdzie będzie umieszczony bieżąc rysunek - subplot(liczba_wierszy, liczba_kolumn, Nr_obrazka)
    hold on; %komenda pozwala dodawać do obrazka kolejne wykresy
        plot(ALLEEG(datasetNr).times, squeeze(ALLEEG(datasetNr).data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
        plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'k*'); %plot(dane_na_ośX, dane_na_ośY)
    %title('osoba z grupy 6, kanał 3 = elekotrda Cz'): 
    title(['osoba z grupy ',ALLEEG(datasetNr).group, ' kanal ', int2str(kanal),' = elekotrda ',ALLEEG(datasetNr).chanlocs(kanal).labels ]);
    xlabel('czas [ms]');
    ylabel('potencjal [mV]');
    grid on;  
end;

%% 3. Rysujemy na jednej figurze dwa wykresy (subplot) - srednie AEP ze wszystkich elekotrod dla obu datasetów 

figure; hold on;
for datasetNr = 1:2 
    subplot(1,2,datasetNr); hold on;
        for kanal = 1:ALLEEG(datasetNr).nbchan
          plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'LineWidth',1.5,'Color',[kanal/5 kanal/15 kanal/15]); % kolor - wartości [R G B]
        end
    legend(ALLEEG(datasetNr).chanlocs.labels);
    xlim([-100 ALLEEG(datasetNr).xmax*1000]);  % ograniczenie zakresu osi X 
    ylim([-15 25]); % ustawienie zakresu osi Y
    xlabel('czas [ms]'); %opis osi X
    ylabel('potencjal [mV]'); %opis osi Y
    grid on; % wywietlanie linii siatki
    title(['Srednie potencjaly sluchowe grupa ', ALLEEG(datasetNr).group])
end;


%% 4. Rysujemy w 5 subplotach (dla kazdej elekotrody) srednie AEP z obu datasetow 
figure; hold on;
for kanal = 1:EEG.nbchan
    subplot(1, EEG.nbchan, kanal); hold on; 
    for datasetNr = 1:2 
        plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'LineWidth',1,'Color',[datasetNr/2 datasetNr/10 datasetNr/5]); 
        xlim([-100 ALLEEG(datasetNr).xmax*1000]) 
        ylim([-15 25]) 
        title(['elektorda ', ALLEEG(datasetNr).chanlocs(kanal).labels])
    end;    
    legend(['grupa ',ALLEEG(1).group; 'grupa ',ALLEEG(2).group]);
    xlabel('czas [ms]');
    ylabel('potencjal [mV]');
    grid on;  
end

%% 5.A  proste statystyki - t-test dla roznicy amplitud w danej latencji u jednej osoby 
% tu w petli - jedna elektorda (Cz - kanal 3) versus pozostale
datasetNr = 1; 
kanal1 = 3;
lat = 115; % w ms od 0, (grupa 1. 115 i 175, gr 6 : 140 i 205, 370)
lat_pkt = (lat+abs(ALLEEG(datasetNr).xmin)*1000)/5; %punkty od początku okna, nie ms od 0 , podiał przez 5 bo taka jest długość próbki przy częstości próbkowanie 200 Hz
for kanal2 = [1 2 4 5];
%fala  P200
[h p] = ttest2(ALLEEG(datasetNr).data(kanal1, lat_pkt,:), ALLEEG(datasetNr).data(kanal2, lat_pkt,:));
%UWAGA - trzeba mysza wskazac miejsce na figurze gdzie b�dzie wklejony tekst;
   gtext(['Cz ver ', ALLEEG(datasetNr).chanlocs(kanal2).labels, ' p= ', num2str(p)])
%UWAGA - trzeba mysza wskaza� miejsce na figurze gdize b�dzie wklejony tekst;
end;

%% 5.B. proste statystyki - t-test dla roznicy amplitud danej fali miedzy osobami - 
% wpisac w obrazek z punktu 4 statystyk? dla co najmniej elektrody Cz 
kanal = 2;
%N100, P200, N400 ew, P300
lat1 = 175; % ms po 0 %latencja fali dla osoby 1.
lat1_pkt = (lat1+abs(ALLEEG(1).xmin)*1000)/5 %punkty od początku okna, nie ms od 0 , podiał przez 5 bo taka jest długość próbki przy częstości próbkowanie 200 Hz
lat2 = 205;  % ms po 0 %latencja fali dla osoby 2.
lat2_pkt = (lat2+abs(ALLEEG(2).xmin)*1000)/5 %punkty od początku okna,

[h p] = ttest2(ALLEEG(1).data(kanal, lat1_pkt,:), ALLEEG(2).data(kanal,lat2_pkt,:));
%UWAGA - trzeba mysza wskaza� miejsce na figurze gdize b�dzie wklejony tekst;
gtext([ALLEEG(datasetNr).chanlocs(kanal).labels, ' osoba z gr 1 ver gr 6  p= ', num2str(p)])


%% 5.C. proste statystyki - t-test dla roznicy amplitud pik-to-pik (wybrane ekstremalne latencje dla kazdej osoby ) miedzy osobami 
kanal = 3; %elekoroda Cz
lat1_1 = 115; %N100 grupa 1
lat1_2 = 175; %P200 grupa 1
lat2_1 = 205; %P200 grupa 6
lat2_2 = 370; % N400 grupa 6

%przeliczenie ms na punkty :exit
lat1_1pkt = (lat1_1+abs(ALLEEG(2).xmin)*1000)/5
lat1_2pkt = (lat1_2+abs(ALLEEG(2).xmin)*1000)/5
lat2_1pkt = (lat2_1+abs(ALLEEG(2).xmin)*1000)/5
lat2_2pkt = (lat2_2+abs(ALLEEG(2).xmin)*1000)/5

[h p] = ttest2(abs(ALLEEG(1).data(kanal,lat1_1pkt,:))+abs(ALLEEG(1).data(kanal,lat1_2pkt,:)) , abs(ALLEEG(2).data(kanal,lat2_1pkt,:))+abs(ALLEEG(2).data(kanal,lat2_2pkt,:)));
%UWAGA - trzeba mysza wskaza� miejsce na figurze gdize b�dzie wklejony tekst;
gtext(['amplituda pik-to-pik osoba z gr 1 ver gr 6  p= ', num2str(p)])


%%

