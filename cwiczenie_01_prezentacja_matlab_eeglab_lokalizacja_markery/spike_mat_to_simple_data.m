%%  1   wstawic właciwą nazwe  !!!!
plik = 'V2016_10_21_grupa4'; %rdzeń nazw zmiennych z kanałów Spike 

%%  2    wstawic właciwe numery !!!!
kanaly_wszystkie = [1:8 31];

%% 3  tworzymy zmienna "titles" z nazwami kanalow 
titles{size(kanaly_wszystkie,2),2} = NaN;
for kanal_nr = 1:size(kanaly_wszystkie,2)
    kanal = kanaly_wszystkie(kanal_nr);
    eval(['titles{',int2str(kanal_nr),',1} = ''kanalNo ', int2str(kanal),''';'])
    eval(['titles{',int2str(kanal_nr),',2} = ',plik,'_Ch',int2str(kanal),'.title;'])
end;

%%  4    wstawic właciwe numery, !!!!
kanaly_ADC = [1 2 3 4 5 6 7 8];   %kanaly z EEG i cyfrowanym 'cięgiem' sygnalem bodzcow patrz - protokoły i {titles}
kanaly_event = [31];     % kanaly znacznikow cyfrowych i klawiatura

%% 5  tworzymy zmienna "data" dla EEGlaba 
ileKanalow = max(size(kanaly_ADC)); %
data_lenght = eval([plik,'_Ch',int2str(kanaly_ADC(1)),'.length']); %ile probel czasowych maja dane 
data(ileKanalow,data_lenght) = NaN; %pusta macierz na dane w 
for kanal_nr = 1:ileKanalow 
    kanal = kanaly_ADC(kanal_nr);
    eval(['data(',int2str(kanal_nr),',:) = ',plik,'_Ch',int2str(kanal),'.values;'])
end;

%%  6
eval(['sampling_rate = 1/',plik,'_Ch',int2str(kanaly_ADC(1)),'.interval']); 

eval(['save ', plik,'_mat_doEEGlaba data eventy titles sampling_rate ']);

%%   zmienne z czasami wystąpienia triggerow 
ileKanalow_event = size(kanaly_event,2);
for kanal_nrr = 1:ileKanalow_event
    kanal_ev = kanaly_event(kanal_nrr);
    eval(['eventy{',int2str(kanal_nrr),',:} = ',plik,'_Ch',int2str(kanal_ev),'.times;'])
end;

%%  kody z klawiatury do zmiennej 
     eval(['kody_klawiatury = ',plik,'_Ch31.codes;']); 
       

%%  8
eval(['clear ', plik,'* ile* kanal* data_lenght ans plik'])

%% 
save ????????.mat % zapamieetujemy dane matlabowe
