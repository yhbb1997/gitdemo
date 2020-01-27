// 1. Preamble: define variables & parameters
var logc logK logY logI logz;
varexo eps;
parameters beta sigma alpha delta rhoz sigmaz;

set_param_value('beta',p.beta);
set_param_value('sigma',p.sigma);
set_param_value('alpha',p.alpha);
set_param_value('delta',p.delta);
set_param_value('rhoz',p.rhoz);
set_param_value('sigmaz',p.sigmaz);

// 2. Model: spell out equations of model
model;
exp(-sigma*logc)=beta*exp(-sigma*logc(+1))
    *(exp(logz(+1))*alpha*exp((alpha-1)*logK)+1-delta);
exp(logK)=exp(logz+alpha*logK(-1))+(1-delta)*exp(logK(-1))-exp(logc);
logz=rhoz*logz(-1)+eps;
logY=logz+alpha*logK(-1);
exp(logI)=exp(logK)-(1-delta)*exp(logK(-1));
end;

// 3. Steady state 
[starK,starc,starY,starI,starz]=sdngm_star(p);
initval;
  logc = log(starc);
  logK = log(starK);
  logY = log(starY);
  logI = log(starI);
  logz = log(starz);
end;

steady;
check;

// 4. Shocks: define shocks
shocks;
  var eps=sigmaz^2;
end;

// 5. Computation: asks to undertake specific operation
stoch_simul(order=2, periods = 1200, hp_filter=1600);