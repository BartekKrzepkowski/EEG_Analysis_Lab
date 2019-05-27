%% Ladujemy datasety podzielone na okna

%% 5 1. Pojedyncze figury : rysujemy wszystkie pojedyncze ERP i średnią z każdego datasetu
%EP z kanału np 3 (Cz) ,najpierw dataset 1 potem 2

kanal = 3;
datasetNr = 2;  % tu zmieniamy numer jak chcemy wybrać dataset 
EEG = ALLEEG(datasetNr);

figure; hold on ;
plot(ALLEEG(datasetNr).times, squeeze(ALLEEG(datasetNr).data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
%title('osoba z grupy 1, kanał 3 = elekotrda Cz') % poniżej to samo ale z danych:  
title(['osoba z grupy ',ALLEEG(datasetNr).group, ' kanal ', int2str(kanal),' = elekotrda ',ALLEEG(datasetNr).chanlocs(kanal).labels ]);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;

% dodajemy do rysunku średnia z tych pojedynczych ERP :
plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'k*');

%% 2. Figura złożona z wielu (10) obrazów: ERP i średnie ze wszystkich kanałów obok siebie i z obu datasetów ( w 2 wierszach):
figure; hold on;

datasetNr = 1; % wybór dataset'u
EEG = ALLEEG(datasetNr); % załadowanie do roboczej zmiennej EEG datasetu nr 1/2 - 

for kanal = 1:EEG.nbchan
    subplot(2,EEG.nbchan, kanal); % komenda wyznacza ile będzie małych rysunków w figurze - w jakiej konfiguracji i gdzie będzie umieszczony bieżąc rysunek - subplot(liczba_wierszy, liczba_kolumn, Nr_obrazka)
    hold on; %komenda pozwala dodawać do obrazka kolejne wykresy
        plot(EEG.times, squeeze(EEG.data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
        plot(EEG.times, squeeze(mean(EEG.data(kanal,:,:),3)),'k*'); %plot(dane_na_ośX, dane_na_ośY)
    %title('osoba z grupy 6, kanał 3 = elekotrda Cz'): 
    title(['osoba z grupy ',EEG.group, ' kanal ', int2str(kanal),'= elekotrda ',EEG.chanlocs(kanal).labels ]);
    xlabel('czas [ms]');
    ylabel('potencjal [mV]');
    grid on;  
end;


%% 3. Rysujemy na jednej figurze dwa wykresy (subplot) - średnie AEP ze wszystkich elekotrod dla obu datasetów 

figure; hold on;
for datasetNr = 1:2 
    subplot(1,2,datasetNr); hold on;
    for kanal = 1:ALLEEG(datasetNr).nbchan
      plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'LineWidth',1.5,'Color',[kanal/10 kanal/5 kanal/5]); 
    end
    legend(ALLEEG(datasetNr).chanlocs.labels);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
title(['Srednie potencjały słuchowe grupa ', ALLEEG(datasetNr).group])
end;


%% 4. Rysujemy w 5 subplotach (dla każdej elekotrdy) średnie AEP z obu datasetów 
figure; hold on;
for kanal = 1:EEG.nbchan
    subplot(1,EEG.nbchan, kanal); hold on; 
    for datasetNr = 1:2 
        plot(ALLEEG(datasetNr).times, squeeze(mean(ALLEEG(datasetNr).data(kanal,:,:),3)),'LineWidth',1,'Color',[datasetNr/3 datasetNr/4 datasetNr/5]); 
        xlim([-100 ALLEEG(datasetNr).xmax*1000]) 
        title(['elektorda ', ALLEEG(datasetNr).chanlocs(kanal).labels])
    end;    
    legend(['grupa ',ALLEEG(1).group; 'grupa ',ALLEEG(2).group]);
    xlabel('czas [ms]');
    ylabel('potencjal [mV]');
    grid on;  
end

%% 5.A  proste statystyki - t-test dla różnicy amplitud w danej latencji   u jednej osoby 
datasetNr = 1;
kanal1 = 3;
kanal2 =4;
lat = 235; %punkty od lewej krawedzi okna, nie ms od 0
[h p] = ttest2(ALLEEG(datasetNr).data(kanal1,lat,:), ALLEEG(datasetNr).data(kanal2,lat,:));
p

%% 5.B. proste statystyki - t-test dla różnicy amplitud danej fali między osobami 
kanal = 3;
lat1 = 235; %punkty od lewej krawedzi okna, nie ms od 0
lat2 = 247;
[h p] = ttest2(ALLEEG(1).data(kanal,lat1,:), ALLEEG(2).data(kanal,lat2,:));
p


%% 5.C. proste statystyki - t-test dla różnucy amplitud pik-to-pik (wybrane ekstremalne latencje dla każdej osoby ) między osobami 
kanal = 3;
lat1 = 242; 
lat2 = 275; %punkty od lewej krawedzi okna, nie ms od 0
lat3 = 224;
lat4 = 236;
[h p] = ttest2(abs(ALLEEG(1).data(kanal,lat1,:))+abs(ALLEEG(1).data(kanal,lat2,:)) , abs(ALLEEG(2).data(kanal,lat3,:))+abs(ALLEEG(2).data(kanal,lat4,:)));
p

%% ew analiza na całkiach z ERP 
