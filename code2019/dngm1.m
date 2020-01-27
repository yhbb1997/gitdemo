function sol=dngm1(p,ap);
%DNGM Solution to deterministic neoclassical growth model.
%   sol = dngm(p,ap) computes the solution to the deterministic
%   neoclassical growth model.
%   Here p is a structure that must contain the model parameters:
%       p.alpha         capital coefficient of Cobb-Douglas production fun.                   
%       p.beta          discount factor
%       p.sigma         inverse of elasticity of intertemporal substitution
%       p.delta         depreciation rate
%       p.z             total factor productivity
%   The following parameter is optional:
%       p.frac_K0_Kstar initial capital stock as fraction of steady state
%   Here ap is a structure containing the algorithm parameters:
%       ap.eps              stopping criterion for value function iteration
%       ap.frac_Kl_Kstar    lower bound of grid as fraction of steady 
%                           state, must be lower than p.frac_K0_Kstar                            
%       ap.frac_Ku_Kstar    upper bound of grid as fraction of steady 
%                           state, must exceed p.frac_K0_Kstar 
%       ap.n                size of capital grid
%       ap.periods          number of periods for which equilibrium path
%                           is computed%%%%%%%%%%这个是什么意思？追踪最优路径的过程，一共多少次。
%   The solution is returned in the structure sol
%       sol.Kstar           steady state level of capital
%       sol.Kgrid           capital grid
%       sol.V               value function
%       sol.PI_K            policy function for future capital
%       sol.PI_K_IND        grid indices corresponding to policy function
%       sol.PI_C            policy function for consumption
%   The following is computed only if p.frac_K0_Kstar is specfied:
%       sol.Kpath           path of capital starting from K0
%       sol.Cpath           path of consumption starting from K0
%
%   This file is part of: Macro I, Problem Set 2.

% Revision History:
%   

% Check inputs
if (isfield(p,'beta'))
    if (p.beta<=0 || p.beta>=1)
       error('Discount factor p.beta must be in (0,1).'); 
    end
else
    error('Parameter structure must specify discount factor p.beta'); 
end
if (isfield(p,'alpha'))
    if (p.alpha<=0 || p.alpha>=1)
       error('Capital coefficient p.alpha must be in (0,1).'); 
    end
else
    error('Parameter structure must specify capital coefficient p.alpha.'); 
end
if (isfield(p,'sigma'))
    if (p.sigma<0)
       error('Preference parameter p.sigma must be non-negative.'); 
    end
else
    error(['Parameter structure must specify preference parameter ' ...
        'p.sigma.']); 
end
if (isfield(p,'z'))
    if (p.z<=0)
       error('Total factor productivity p.z must be strictly positive.'); 
    end
else
    error(['Parameter structure must specify total factor productivity ' ...
        'p.z.']); 
end
if (isfield(p,'delta'))
    if (p.delta<=0 || p.delta>=1)
       error('Depreciation rate p.delta must be in (0,1).'); 
    end
else
    error('Parameter structure must specify depreciation rate p.delta.'); 
end
if (isfield(p,'frac_K0_Kstar'))
    if (p.frac_K0_Kstar<ap.frac_Kl_Kstar || ...
        p.frac_K0_Kstar>ap.frac_Ku_Kstar)
       error(['Must specifify frac_K0_Kstar in '...
              '(frac_Kl_Kstar,frac_Ku_Kstar)']); 
    end
end


% Compute steady state:
% steady-state capital-labor ratio
sol.kappastar=((1-p.beta*(1-p.delta))/(p.z*p.alpha*p.beta))^(1/(p.alpha-1));
% here labor is exogenous and equal to one
sol.Lstar=1;
% steady-state capital
sol.Kstar=sol.kappastar*sol.Lstar;
% steady-state consumption
sol.Cstar=p.z*sol.Kstar^p.alpha*(sol.Lstar)^(1-p.alpha)-p.delta*sol.Kstar;

% Specify capital grid
sol.Kgrid=linspace(ap.frac_Kl_Kstar*sol.Kstar,ap.frac_Ku_Kstar*sol.Kstar,ap.n)';%注意这里的网格是列向量。

% Specifiy instantaneous utility
if (p.sigma==1)
   u=@(c)log(c); 
else
   u=@(c) ((c.^(1-p.sigma)-1)/(1-p.sigma)); 
end

% Specify inital guess for the value function
V0=zeros(ap.n,1);

% Compute payoff matrix UMAT
KMAT=repmat(sol.Kgrid,1,ap.n);%列与列之间均相同的矩阵
CMAT=KMAT.^p.alpha+(1-p.delta)*KMAT-KMAT';%注意这种矩阵方法
UMAT=zeros(ap.n,ap.n);
UMAT(CMAT>=0)=u(CMAT(CMAT>=0));%这种矩阵填充方法值得学习。a=zeros(2,2);%b=[1,2;-1,3];%a(b>=0)=b(b>=0)
UMAT(CMAT<0)=-Inf;

% Call value function iteration
% tic;
% [sol.V,sol.PI_K_IND]=dvfi(UMAT,V0,p.beta,ap.eps);%这里用到了dvfi文件
% dvfi_toc=toc;
% display(['Value function iteration converged in ' num2str(dvfi_toc) ' seconds.']);
    
% Here the code to comment in for the modified policy function iteration:
tic;
[sol.V2,sol.PI_K_IND2]=dmpfi(UMAT,V0,p.beta,ap.eps,ap.k);
dmpfi_toc=toc;
display(['Modified policy function iteration coverged in ' num2str(dmpfi_toc) ' seconds.']);

% Compute policy function
%sol.PI_K=sol.Kgrid(sol.PI_K_IND);%注意这里sol.Kgrid是列向量，sol.PI_K_IND返回的也是列向量，sol.PI_K返回的是所有的最优路径。
% Here the code to comment in for the modified policy function iteration:
sol.PI_K=sol.Kgrid(sol.PI_K_IND2);
sol.PI_C=sol.Kgrid.^p.alpha+(1-p.delta)*sol.Kgrid-sol.PI_K;

% Compute path，这个本质是计算一部分最优路径并不是所有，但是足矣保证收敛了
if (isfield(p,'frac_K0_Kstar'))
    Kpath_IND=zeros(ap.periods,1);
    [dummy,K0_IND]=min(abs(sol.Kgrid-p.frac_K0_Kstar*sol.Kstar));%为什么要从与初始值相差最小的开始？
    %因为要求从p.frac_K0_Kstar*sol.Kstar出发，不一定恰好能够找到这个值就找离他最近的值。
    Kpath_IND(1)=K0_IND; 
    for path_counter=2:ap.periods
        %Kpath_IND(path_counter)=sol.PI_K_IND(Kpath_IND(path_counter-1));%
        % Here the code to comment in for the modified policy function iteration:
         Kpath_IND(path_counter)=sol.PI_K_IND2(Kpath_IND(path_counter-1));
    end
    sol.Kpath=sol.Kgrid(Kpath_IND);
    sol.Cpath=sol.PI_C(Kpath_IND);
end


