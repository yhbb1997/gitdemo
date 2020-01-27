%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'lecture_sdngm';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('lecture_sdngm.log');
M_.exo_names = 'eps';
M_.exo_names_tex = 'eps';
M_.exo_names_long = 'eps';
M_.endo_names = 'logc';
M_.endo_names_tex = 'logc';
M_.endo_names_long = 'logc';
M_.endo_names = char(M_.endo_names, 'logK');
M_.endo_names_tex = char(M_.endo_names_tex, 'logK');
M_.endo_names_long = char(M_.endo_names_long, 'logK');
M_.endo_names = char(M_.endo_names, 'logY');
M_.endo_names_tex = char(M_.endo_names_tex, 'logY');
M_.endo_names_long = char(M_.endo_names_long, 'logY');
M_.endo_names = char(M_.endo_names, 'logI');
M_.endo_names_tex = char(M_.endo_names_tex, 'logI');
M_.endo_names_long = char(M_.endo_names_long, 'logI');
M_.endo_names = char(M_.endo_names, 'logz');
M_.endo_names_tex = char(M_.endo_names_tex, 'logz');
M_.endo_names_long = char(M_.endo_names_long, 'logz');
M_.endo_partitions = struct();
M_.param_names = 'beta';
M_.param_names_tex = 'beta';
M_.param_names_long = 'beta';
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names_long = char(M_.param_names_long, 'alpha');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'rhoz');
M_.param_names_tex = char(M_.param_names_tex, 'rhoz');
M_.param_names_long = char(M_.param_names_long, 'rhoz');
M_.param_names = char(M_.param_names, 'sigmaz');
M_.param_names_tex = char(M_.param_names_tex, 'sigmaz');
M_.param_names_long = char(M_.param_names_long, 'sigmaz');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 5;
M_.param_nbr = 6;
M_.orig_endo_nbr = 5;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 0;
erase_compiled_function('lecture_sdngm_static');
erase_compiled_function('lecture_sdngm_dynamic');
M_.orig_eq_nbr = 5;
M_.eq_nbr = 5;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 3 8;
 1 4 0;
 0 5 0;
 0 6 0;
 2 7 9;]';
M_.nstatic = 2;
M_.nfwrd   = 1;
M_.npred   = 1;
M_.nboth   = 1;
M_.nsfwrd   = 2;
M_.nspred   = 2;
M_.ndynamic   = 3;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(5, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(6, 1);
M_.NNZDerivatives = [17; 19; -1];
set_param_value('beta',p.beta);
set_param_value('sigma',p.sigma);
set_param_value('alpha',p.alpha);
set_param_value('delta',p.delta);
set_param_value('rhoz',p.rhoz);
set_param_value('sigmaz',p.sigmaz);
[starK,starc,starY,starI,starz]=sdngm_star(p);
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = log(starc);
oo_.steady_state( 2 ) = log(starK);
oo_.steady_state( 3 ) = log(starY);
oo_.steady_state( 4 ) = log(starI);
oo_.steady_state( 5 ) = log(starz);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
oo_.dr.eigval = check(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(6)^2;
options_.hp_filter = 1600;
options_.order = 2;
options_.periods = 1200;
var_list_ = char();
info = stoch_simul(var_list_);
save('lecture_sdngm_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('lecture_sdngm_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('lecture_sdngm_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('lecture_sdngm_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('lecture_sdngm_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('lecture_sdngm_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('lecture_sdngm_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
