%LECTURE_SDNGM Solve and simulate stochastic neoclassical growth model with
%           exogenous labor supply using DYNARE

%   This file is part of: Macro I 2019, lecture 6.

% Set parameters that will be used by DYNARE
p.beta=0.984;
p.sigma=0.5;
p.alpha=1/3;
p.delta=0.025;
p.rhoz=0.979;
p.sigmaz=0.0072;

% Call DYNARE
% (argument noclearall is needed so that parameters are not deleted)
dynare lecture_sdngm.mod noclearall;

