%% wybieramy właściwy dataset (podzielony na okna!) jako aktualny w EEGlab
AEP_gr1 =  mean(EEG.data,3); % lub inna właściwa nazwa
AEP_gr1_all =  EEG.data; % lub inna właściwa nazwa

%% wybieramy drugi dataset (podzielony na okna!) jako aktualny w EEGlab
AEP_gr6 =  mean(EEG.data,3); % lub inna właściwa nazwa
AEP_gr6_all =  EEG.data; % lub inna właściwa nazwa

%% dla ilustracji usredniania -rysujemy wszystkie pojedyncze 
%EP z kanału 3. i średni EP z kanału 3 (Cz):
figure; hold on ;

plot(EEG.times, squeeze(EEG.data(3,:,:)));   %plot(dane_na_ośX, dane_na_ośY)
plot(EEG.times, AEP_gr1(3,:),'k*-');  %plot(dane_na_ośX, dane_na_ośY, 'cechy linii')

%% wszystkie kanały z pliku z grupy 1.
figure; 
plot(EEG.times, AEP_gr1); 
legend(EEG.chanlocs.labels); 
title('AEP grupa 1')

%% wszystkie kanały z pliku 2
figure; 
plot(EEG.times, AEP_gr6, '-'); 
legend(EEG.chanlocs.labels);
title('AEP grupa 6')

%% Rysujemy na jednym wykresie  aep_gr1 i aep_gr6:
figure; hold on;
plot(EEG.times, aep_gr1); 
plot(EEG.times, aep_gr6, '.-');  % '.-'  cechy rysowanego wykresu
legend(EEG.chanlocs.labels, EEG.chanlocs.labels);

% view -> plot browser -> wyświetlamy i znikamy wybrane kanały
%→ PRINscreen !

%% Rysujemy na jednym wykresie dla wybranego kanału EP z aep_gr1 i aep_gr6 :

figure; hold on;
plot(EEG.times, aep_gr1(X,:), 'b'); %zamiast X wstawiamy numer kanału np. 3 dla Cz
plot(EEG.times, aep_gr6(X,:), 'r'); %zamiast X wstawiamy numer kanału
legend(legend('gr 1  ', 'gr 6' );
title('kanał XXX')); % nazwa elektrody

%% proste statystyki - t-test dla różnucy amplitud w danej latencji 
kanal = 3;
lat = 236; %punkty od lewej krawedzi okna, nie ms od 0
[h p] = ttest2(AEP_gr6_all(kanal,lat,:), AEP_gr1_all(kanal,lat,:));
p


