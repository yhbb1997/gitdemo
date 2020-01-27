%MAIN Speed of adjustment in neoclassical growth model.
%   This script solves the stochastic neoclassical growth model for
%   different levels of the inverse elasticity of intertemporal 
%   substitution sigma and creates a figure comparing adjustment paths
%   for sigma=1 and sigma=5 starting from K0=0.5*Kstar where Kstar
%   is steady state captial.
%
%   This file is part of: Macro I, Problem Set 2.

clear;
% Model Parameters (collected in structure p)
p.alpha=1/3;
p.beta=0.5;
p.sigma=1;
p.delta=0.025;
p.frac_K0_Kstar=0.5;
p.z=1;

% Algorithm parameters (collected in structure ap)
ap.eps=(1-p.beta)*0.01;     % convergence criterion 
ap.frac_Kl_Kstar=0.5;       % lowest value of capital grid
ap.frac_Ku_Kstar=1.5;       % highest value of capital grid
ap.n=100;                  % number of grid points
ap.periods=250;             % number of periods to be simulated
ap.k=3;                    % modified policy function iteration parameter    

% Compute solution for p.sigma=1
sol=dngm1(p,ap);
Kpath_1=sol.Kpath;
Cpath_1=sol.Cpath;

% Compute solution for p.sigma=5
p.sigma=5;
sol=dngm1(p,ap);
Kpath_5=sol.Kpath;
Cpath_5=sol.Cpath;

% Figure comparing solution paths for p.sigma=1 and p.sigma=5
figure;
clf;
subplot(2,1,1);
set(gca,'FontSize',15);
plot(0:length(Kpath_1)-1,Kpath_1,'k-');
hold on;
plot(0:length(Kpath_5)-1,Kpath_5,'k--');
title_text=title(['Path from $K(0)=\frac{1}{2} K^\ast$ ' 'for different $\sigma$.'],'Interpreter','Latex');
xlabel_text=xlabel('$t$');
ylabel_text=ylabel('$K(t)$');
set([xlabel_text ylabel_text],'Interpreter','Latex');
subplot(2,1,2);
set(gca,'FontSize',15);
plot(0:length(Kpath_1)-1,Cpath_1,'k-');
hold on;
plot(0:length(Kpath_5)-1,Cpath_5,'k--');
xlabel_text=xlabel('$t$');
ylabel_text=ylabel('$C(t)$');
set([xlabel_text ylabel_text],'Interpreter','Latex');
legend_text=legend('$\sigma=1$','$\sigma=5$');
set(legend_text,'Interpreter','Latex','Location','SouthEast','FontSize',15);
% Save figure as pdf file
orient tall;
saveas(gcf,'main','pdf'); 