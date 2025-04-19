clear all; close all

%Chargement, lecture et échantillonnage du signal audio
filename = 'Pa11.wav'; 
[x, fe]=audioread(filename);
T = 1/fe ;
N=length(x);

% Affichage du signal original
t = (0:N-1)*T;
figure(1)
plot(t, x);
title('Signal original');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_1','Format','png','color','cmyk');

%Observation de l'autocorrelation du signal x 
rxx=xcorr(x);
figure(2)
plot(rxx);
title("Fonction autocorrelation du signal x") ;
axis tight;
exportfig(gcf,'figure_2','Format','png','color','cmyk');


%Determination de to 
[rx1,ind_1]=max(rxx);
rxx(ind_1-50:ind_1+100)=0;                   % Elimination du pic principal pour conserver que les seconds
[rx2,ind_2]=max(rxx);
p0=abs(ind_2-ind_1);

%Calcul du parametre alpha 
alpha=0.5*(rx1/rx2-sqrt((rx1/rx2)^2-4));  % Formule vue en classe avec le chargé de TD 

%Filtrage de l'echo dans le signal et affichage
H = [1 zeros(1,p0-1) alpha];
x_new=filter(1, H ,x);
figure(3)
plot(t, x_new);
title('Signal filtré des échos');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_3','Format','png','color','cmyk');

%Observation de l'autocorrelation du signal x_new
rxx_new=xcorr(x_new);
figure(4)
plot(rxx_new);
title("Fonction autocorrelation du signal x_new") ;
axis tight;
exportfig(gcf,'figure_4','Format','png','color','cmyk');


%Ecriture et lecture du signal final 
audiowrite('Pa11_new.wav',x_new,fe);
sound(x_new, fe);






