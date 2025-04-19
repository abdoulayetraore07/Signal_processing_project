clear all ; close all 

%Chargement,lecture et échantillonnage du signal audio
filename = 'Mo11.wav'; 
[y, fe] = audioread(filename);
T = 1/fe;


% Affichage du signal original brouillé
t = (0:length(y)-1)*T;
figure(1) 
plot(t, y);
title('Signal original');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_1','Format','png','color','cmyk');

%TFy : transformeé de fourier de y ;
% Calcul de la transformée de Fourier des signaux
TFy = fftshift(fft(y));    
f = linspace(-fe/2, fe/2, length(TFy));

% Affichage de la transformée de Fourier du signal original
figure(2)
plot(f, abs(TFy));
title('Transformée de Fourier du signal original');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_2','Format','png','color','cmyk');
figure(3)


%Recherche des valeurs des frequences f0 et f1 à couper par un filtre 
N=length(y);
f_temp=0:fe/N:fe/2; % Pour des raisons de symetrie 

% Première fréquence
[~,indice_1]=max(abs(TFy(1:N/2)));
f0=f(indice_1);

%  Deuxième fréquence
TFy(indice_1)=0;
[~,indice_2]=max(abs(TFy(1:N/2)));
f1=f(indice_2);


%Filtrage du signal original
z0=exp(-1j*2*pi*f0*T);
z1=exp(-1j*2*pi*f1*T);
alpha=0.99;
Z=[z0,conj(z0),z1,conj(z1)];
P=alpha*Z;
b=poly(Z); %Fonction pour trouver les coefficients étant donnés des zéros;
a=poly(P);
y2=filter(b,a,y);

% Affichage du signal filtré 
figure(3)
plot(t, y2);
title('Signal filtré y2');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_3','Format','png','color','cmyk');


%Spectre du signal filtré y2 et affichage
figure(4)
plot(f, abs(fftshift(fft(y2))))
title('Transformée de Fourier du signal filtré ');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_4','Format','png','color','cmyk');

%Ecriture et lecture du son filtré
audiowrite('Mo11_new.wav',y2,fe);
sound(y2, fe);
