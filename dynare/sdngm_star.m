function [starK,starc,starY,starI,starz]= sdngm_star(p)
%SDNGM_STAR Steady-state of neoclassical growth model with exogenous labor
%   [starK,starc,starY,starI,starz]= SDNGM_STAR(p)
%   The parameters of the model alpha, beta, and delta must be passed
%   in the structure p.
%   The steady-state levels of capital, consmumption, output, investment,
%   and total-factor productivity are returned in the variables
%   starK,starc,starY,starI, and starz, respectively.

%   This file is part of: Macro I 2019, lecture 6.

% Revision History:
%   Nov 25 2012     Bjoern Bruegemann   Original code

starK=(p.alpha/( (1/p.beta)-(1-p.delta) ))^(1/(1-p.alpha));
starc=starK^p.alpha-p.delta*starK;
starY=starK^p.alpha;
starI=p.delta*starK;
starz=1;

end

