clear all; close all

%Chargement, lecture et échantillonnage des signaux audios
filename_1 = 'x1.wav'; 
[x1, fe_1]=audioread(filename_1);
T1 = 1/fe_1 ;
N1=length(x1);

filename_2 = 'x2.wav'; 
[x2, fe_2]=audioread(filename_2);
T2 = 1/fe_2 ;
N2=length(x1);


% Affichage des signaux originaux

t1 = (0:N1-1)*T1;    % Affichage x1
figure(1)
plot(t1, x1);
title('Signal original x1');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_1','Format','png','color','cmyk');

t2 = (0:N2-1)*T2;          % Affichage x2
figure(2)
plot(t2, x2);
title('Signal original x2');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_2','Format','png','color','cmyk');



%Determination de ro par Graam-Scmidt ( Sous impulsion du chargé de TD )

ro=mean(x1.*x2)/mean(x2.^2);

%Le signal x recherche est une combinaison lineaire de x1 et x2 :

x=x1-ro*x2;

r_x_x1=xcorr(x,x2);
n=length(r_x_x1);
f=linspace(-n/2,n/2,n);
figure(3) 
plot(f,r_x_x1) ;
title('Intercorrelation entre les signaux x2 bruité et le signal utile x');
axis tight;
exportfig(gcf,'figure_3','Format','png','color','cmyk');

%Ecriture et lecture du signal final 
audiowrite('x_new.wav',x,fe_1); 
sound(x,fe_1)


