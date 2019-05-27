%% w EEGlabie zaladowany dataset z surowym sygnalem 
% rysujemy pierwszy kanal
kanal = 1; % wskazujemy numer kana?u (czyli numer wiersza w macierzy strukturalnej z danymi i metadanymi EEG), z którego rysujemy wynikowe figury
fh=figure; hold on; grid on;  
plot(EEG.times, EEG.data(kanal,:),'k'); %zmienna kanal wskazuje nr wiersza w macierzy strukturalnej EEG.data
title(EEG.chanlocs(kanal).labels); %lub recznie podajemy tresc tytulu np.: title('kanal O1')
legend('surowy sygnal');

%% !!! w EEGlabie przeladowyjemy dataset na dane przefiltrowane

figure(fh); % przywo³anie na "pierwszy plan" naszej roboczej figury 
plot(EEG.times, EEG.data(kanal,:),'b');  %'b' to niebieska linia
legend('surowy sygnal', 'pasmo alfa');  %

%% prostowanie sygnalu, zeby miec jedynie wartosci dodatnie - wartoœci absolutne, lub 
prosty = abs(EEG.data); % wartosci absolutne sygnalu

% dorysowujemy wyprostowany sygna?:
figure(fh);
plot(EEG.times, prosty(kanal,:)','m--')
legend('surowy sygnal', 'pasmo alfa', 'alfa wyporostowany sygnal');
% dane zachowuja wszystkie dynamiczne "gorki i dolki" - wato je wygladzic

%% liczenie obwiedni przy pomocy transformaty Hilbera od razu daje "gladki' przebieg amplitidy sygnalu 
hhhhh = hilbert(EEG.data'); %funkcja dziala wzdloz kolumn - nasze dane trzeba obrócic bo sa w wierszach
%plot(EEG.times,hhhhh,'g')
obwiednie = abs(hhhhh'); %wynik z Hilberta jest liczb? zespolon? - nas interesuje jej modul (abs)
clear hhhhh; % wyrzucamy juz niepotrzebna, robocza zmienna;
figure(fh);
plot(EEG.times, obwiednie(kanal,:), 'r');
legend('surowy sygnal', 'pasmo alfa', 'alfa wyporostowany sygnal', 'alfa transforamata Hilberta')

%% EEGlabie tworzymy dataset zawierajacy dane z obwiednami wklajemy je do aktualnego datasetu 
% i zapisujemy pod nowa nazwa
EEG.data = obwiednie;  
EEG.setname = 'otwarte zamkniete alfa obwiednie'
eeglab redraw;

% !!!!  po tej operacji trzeba jeszcze zapisac dane jako nowy plik *.set (z odpowiedn¹ nazawa)

%% 
clear kanal prosty obwiednie

