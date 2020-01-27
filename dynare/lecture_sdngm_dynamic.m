function [residual, g1, g2, g3] = lecture_sdngm_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(5, 1);
lhs =exp((-params(2))*y(3));
rhs =params(1)*exp((-params(2))*y(8))*(1+exp(y(9))*params(3)*exp((params(3)-1)*y(4))-params(4));
residual(1)= lhs-rhs;
lhs =exp(y(4));
rhs =exp(y(7)+params(3)*y(1))+(1-params(4))*exp(y(1))-exp(y(3));
residual(2)= lhs-rhs;
lhs =y(7);
rhs =params(5)*y(2)+x(it_, 1);
residual(3)= lhs-rhs;
lhs =y(5);
rhs =y(7)+params(3)*y(1);
residual(4)= lhs-rhs;
lhs =exp(y(6));
rhs =exp(y(4))-(1-params(4))*exp(y(1));
residual(5)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(5, 10);

  %
  % Jacobian matrix
  %

  g1(1,3)=(-params(2))*exp((-params(2))*y(3));
  g1(1,8)=(-((1+exp(y(9))*params(3)*exp((params(3)-1)*y(4))-params(4))*params(1)*(-params(2))*exp((-params(2))*y(8))));
  g1(1,4)=(-(params(1)*exp((-params(2))*y(8))*exp(y(9))*params(3)*(params(3)-1)*exp((params(3)-1)*y(4))));
  g1(1,9)=(-(params(1)*exp((-params(2))*y(8))*exp(y(9))*params(3)*exp((params(3)-1)*y(4))));
  g1(2,3)=exp(y(3));
  g1(2,1)=(-((1-params(4))*exp(y(1))+params(3)*exp(y(7)+params(3)*y(1))));
  g1(2,4)=exp(y(4));
  g1(2,7)=(-exp(y(7)+params(3)*y(1)));
  g1(3,2)=(-params(5));
  g1(3,7)=1;
  g1(3,10)=(-1);
  g1(4,1)=(-params(3));
  g1(4,5)=1;
  g1(4,7)=(-1);
  g1(5,1)=(1-params(4))*exp(y(1));
  g1(5,4)=(-exp(y(4)));
  g1(5,6)=exp(y(6));

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(19,3);
  v2(1,1)=1;
  v2(1,2)=23;
  v2(1,3)=(-params(2))*(-params(2))*exp((-params(2))*y(3));
  v2(2,1)=1;
  v2(2,2)=78;
  v2(2,3)=(-((1+exp(y(9))*params(3)*exp((params(3)-1)*y(4))-params(4))*params(1)*(-params(2))*(-params(2))*exp((-params(2))*y(8))));
  v2(3,1)=1;
  v2(3,2)=38;
  v2(3,3)=(-(params(1)*(-params(2))*exp((-params(2))*y(8))*exp(y(9))*params(3)*(params(3)-1)*exp((params(3)-1)*y(4))));
  v2(4,1)=1;
  v2(4,2)=74;
  v2(4,3)=  v2(3,3);
  v2(5,1)=1;
  v2(5,2)=34;
  v2(5,3)=(-(params(1)*exp((-params(2))*y(8))*exp(y(9))*params(3)*(params(3)-1)*(params(3)-1)*exp((params(3)-1)*y(4))));
  v2(6,1)=1;
  v2(6,2)=88;
  v2(6,3)=(-(exp(y(9))*params(3)*exp((params(3)-1)*y(4))*params(1)*(-params(2))*exp((-params(2))*y(8))));
  v2(7,1)=1;
  v2(7,2)=79;
  v2(7,3)=  v2(6,3);
  v2(8,1)=1;
  v2(8,2)=84;
  v2(8,3)=(-(params(1)*exp((-params(2))*y(8))*exp(y(9))*params(3)*(params(3)-1)*exp((params(3)-1)*y(4))));
  v2(9,1)=1;
  v2(9,2)=39;
  v2(9,3)=  v2(8,3);
  v2(10,1)=1;
  v2(10,2)=89;
  v2(10,3)=(-(params(1)*exp((-params(2))*y(8))*exp(y(9))*params(3)*exp((params(3)-1)*y(4))));
  v2(11,1)=2;
  v2(11,2)=23;
  v2(11,3)=exp(y(3));
  v2(12,1)=2;
  v2(12,2)=1;
  v2(12,3)=(-((1-params(4))*exp(y(1))+params(3)*params(3)*exp(y(7)+params(3)*y(1))));
  v2(13,1)=2;
  v2(13,2)=34;
  v2(13,3)=exp(y(4));
  v2(14,1)=2;
  v2(14,2)=61;
  v2(14,3)=(-(params(3)*exp(y(7)+params(3)*y(1))));
  v2(15,1)=2;
  v2(15,2)=7;
  v2(15,3)=  v2(14,3);
  v2(16,1)=2;
  v2(16,2)=67;
  v2(16,3)=(-exp(y(7)+params(3)*y(1)));
  v2(17,1)=5;
  v2(17,2)=1;
  v2(17,3)=(1-params(4))*exp(y(1));
  v2(18,1)=5;
  v2(18,2)=34;
  v2(18,3)=(-exp(y(4)));
  v2(19,1)=5;
  v2(19,2)=56;
  v2(19,3)=exp(y(6));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),5,100);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],5,1000);
end
end
end
end
