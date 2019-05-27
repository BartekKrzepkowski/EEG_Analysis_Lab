%% wybieramy właściwy dataset (podzielony na okna!) jako aktualny w EEGlab
%% rysujemy wszystkie pojedyncze ERP
%EP z kanału np 3 (Cz)

kanal = 3;

EEG = ALLEEG(1); %ładujemy do 
figure; hold on ;
plot(EEG.times, squeeze(EEG.data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
%title('osoba z grupy 6, kanał 3 = elekotrda Cz')   
title(['osoba z grupy ',EEG.subject, ' kanal ', int2str(kanal),'= elekotrda ',EEG.chanlocs(kanal).labels ]);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
% dodajemy do rysunku średnia z tych pojedynczych ERP :
plot(EEG.times, squeeze(mean(EEG.data(kanal,:,:),3)),'k*');


%% drugi dataset
EEG = ALLEEG(2);
figure; hold on ;
plot(EEG.times, squeeze(EEG.data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
%title('osoba z grupy 6, kanał 3 = elekotrda Cz')   
title(['osoba z grupy ',EEG.subject, ' kanal ', int2str(kanal),'= elekotrda ',EEG.chanlocs(kanal).labels ]);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
% dodajemy do rysunku średnia z tych pojedynczych ERP :
plot(EEG.times, squeeze(mean(EEG.data(kanal,:,:),3)),'k*');

%% figury ze wszystkich kanałów obok siebie:
figure; hold on;
EEG = ALLEEG(1);
for kanal = 1:EEG.nbchan
subplot(2,EEG.nbchan, kanal); % 
hold on; plot(EEG.times, squeeze(EEG.data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
%title('osoba z grupy 6, kanał 3 = elekotrda Cz')   
title(['osoba z grupy ',EEG.subject, ' kanal ', int2str(kanal),'= elekotrda ',EEG.chanlocs(kanal).labels ]);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
plot(EEG.times, squeeze(mean(EEG.data(kanal,:,:),3)),'k*');
end;
%% dane z 2. datasetu w drugim wierszu figury:
EEG = ALLEEG(2);
for kanal = 1:EEG.nbchan
subplot(2,EEG.nbchan, kanal+EEG.nbchan); % 
hold on; plot(EEG.times, squeeze(EEG.data(kanal,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
%title('osoba z grupy 6, kanał 3 = elekotrda Cz')   
title(['osoba z grupy ',EEG.subject, ' kanal ', int2str(kanal),'= elekotrda ',EEG.chanlocs(kanal).labels ]);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
plot(EEG.times, squeeze(mean(EEG.data(kanal,:,:),3)),'k*');
end;

%% można wyciągnac zmienna data ze struktury EEG i nadać jej nową nazwę:
% można zrobić nową zmienną ze średnimi - 
% dane z gr 1:

AEP_gr1_all =  EEG.data; % lub inna właściwa nazwa
AEP_gr1_av =  mean(EEG.data,3); % lub inna właściwa nazwa
%% wybieramy drugi dataset (podzielony na okna!) jako aktualny w EEGlab
% można zrobić nową zmienną ze średnimi - 
% dane z gr 6:
EEG = ALLEEG(?); % wstawic właściwy numer
AEP_gr6_all =  EEG.data; % lub inna właściwa nazwa
AEP_gr6_av =  mean(EEG.data,3); % lub inna właściwa nazwa

% %% rysujemy wszystkie pojedyncze ERP
%EP z kanału 3. i średni EP z kanału 3 (Cz):

%% wszystkie kanały z pliku z grupy 1.
figure; 
plot(EEG.times, AEP_gr1_av); 
legend(EEG.chanlocs.labels); 
title('AEP grupa 1')
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
%% wszystkie kanały z pliku 2
figure; 
plot(EEG.times, AEP_gr6_av, '-'); 
legend(EEG.chanlocs.labels);
title('AEP grupa 6')
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
%% Rysujemy na jednym wykresie  aep_gr1 i aep_gr6:
figure; hold on;
plot(EEG.times, AEP_gr1_av); 
plot(EEG.times, AEP_gr6_av, '.-');  % '.-'  cechy rysowanego wykresu
legend(EEG.chanlocs.labels, EEG.chanlocs.labels);
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
title('AEP, ___ gr 1 , -*--*- gr 6')
% view -> plot browser -> wyświetlamy i znikamy wybrane kanały
%→ PRINscreen !

%% Rysujemy na jednym wykresie dla wybranego kanału EP z aep_gr1 i aep_gr6 :
kanal = 3;
figure; hold on;
plot(EEG.times, AEP_gr1_av(kanal,:), 'b'); %zamiast X wstawiamy numer kanału np. 3 dla Cz
plot(EEG.times, AEP_gr6_av(kanal,:), 'r'); %zamiast X wstawiamy numer kanału
legend('gr 1  ', 'gr 6')
title(['kanal ', int2str(kanal), ' = elektroda ', EEG.chanlocs(kanal).labels ]); % nazwa elektrody
xlabel('czas [ms]');
ylabel('potencjal [mV]');
grid on;
%% Rysujemy na jednym wykresie dla wybranego kanału EP z aep_gr1 i aep_gr6 :
kanal = 3;
figure; hold on;
plot(AEP_gr1_av(kanal,:), 'b'); %zamiast X wstawiamy numer kanału np. 3 dla Cz
plot(AEP_gr6_av(kanal,:), 'r'); %zamiast X wstawiamy numer kanału
legend('gr 1  ', 'gr 6')
title(['kanal ', int2str(kanal), ' = elektroda ', EEG.chanlocs(kanal).labels ]); % nazwa elektrody
xlabel('czas [pkt]');
ylabel('potencjal [mV]');
grid on;
%% proste statystyki - t-test dla różnucy amplitud w danej latencji 
kanal = 3;
lat = 200; %punkty od lewej krawedzi okna, nie ms od 0
[h p] = ttest2(AEP_gr6_all(kanal,lat,:), AEP_gr1_all(kanal,lat,:));
p

%% proste statystyki - t-test dla różnucy amplitud w danej latencji 
kanal1 = 4;
kanal2 = 3;
lat = 242; %punkty od lewej krawedzi okna, nie ms od 0
[h p] = ttest2(AEP_gr6_all(kanal1,lat,:), AEP_gr6_all(kanal2,lat,:));
p
%% proste statystyki - t-test dla różnucy amplitud w danej latencji między osobami 
kanal = 1;
lat = 242; %punkty od lewej krawedzi okna, nie ms od 0
[h p] = ttest2(AEP_gr6_all(kanal,lat,:), AEP_gr1_all(kanal,lat,:));
p

%% proste statystyki - t-test dla różnucy amplitud w latencji pik-to-pik między osobami 
kanal = 3;
lat1 = 242; 
lat2 = 275; %punkty od lewej krawedzi okna, nie ms od 0
lat3 = 224;
lat4 = 236;
[h p] = ttest2(abs(AEP_gr6_all(kanal,lat1,:))+abs(AEP_gr6_all(kanal,lat2,:)) , abs(AEP_gr1_all(kanal,lat3,:))+abs(AEP_gr1_all(kanal,lat4,:)));
p
