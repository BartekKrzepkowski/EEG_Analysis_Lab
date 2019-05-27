% wyciaga dane numeryczne z kazdego pojedynczego kanalu ADC (EEG i markery cyfrowane jako sygna? ciag?y [ADC] (pole .values)
% i tworzy z nich oddzielne zmienne:

ch1 = Ch1.values';
ch2 = Ch2.values';
ch3 = Ch3.values';
ch4 = Ch4.values';
ch5 = Ch5.values';
%ch6 = Ch6.values';
ch7 = Ch7.values';
%ch9 = Ch9.values';
%
%... 
%ze zmienych z pojedynczymi kanalami sklada macierz ze wszystkimi kanalami data, dla EEGlaba (:
data = [ch1; ch2; ch3; ch4; ch5; ch7];% ch7];% ch9]; %... wszystkie wpisa? 
%clear ch*
%%  %wyciaga nazwy pojedynczych kanalow  
n1 = Ch1.title;
n2 = Ch2.title;
n3 = Ch3.title;
n4 = Ch4.title;
n5 = Ch5.title;
n6 = Ch6.title;
n7 = Ch7.title;
%  n8 = Ch8.title;
%  n9 = Ch9.title;
%n8 = Ch31.title;
%...
% i sklada z nich macierz z nazwami kanalow:
titles = {n1;n2;n3;n4;n5;n6;n7;n8}%;n9;n10}; % ;
clear n*

%%  zapisuje informacje o czestosci probkowania (bierze ja z pierwszego kanalu dancyh Ch1
sampling_rate = 1/Ch1.interval;
%%  wyciaga informacje o markerach z kanalow z dabtycmi event i klawiatura
markery(:,1) = Ch6.times ;  % czasy wyst?pienia znacznika !!!wpisa? z kanal o wla?ciwym numerze Ch..!!! 
markery(:,2) = 2;  % kod znacznika (unikamy 1 jedynka jest stosowana przez import z kana?u dancych 
% inne  kana?y inne znaczniki  - tworymy kolejne zmienne jak powy?ej
% odpowieeni je nazywajac

%% kody z klawiatury do zmiennej 
kody_klawiatury = double(Ch31.codes); % miacierz z kodami pierwszej kolumnie, kolejne kolumny niewa?ne, 
kody_klawiatury(:,2) = Ch31.times; % do drugiej kolumny wk?adamy czasy wystapienia kolejnych kod�w
kody_klawiatury(:,3:4) = []; %likwidujemy niepotrzeben dwie osatnie kolumny

%%
