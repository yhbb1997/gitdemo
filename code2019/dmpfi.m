function [V,pi] = dmpfi(UMAT,V0,beta,eps,k)
   %DVFI Discrete value function iteration.
   %   [V,pi] = dvfi(UMAT,V0,beta,eps) solves a discrete dynamic programming
   %   problem. Here UMAT is a matrix instantaneous payoffs, where the current
   %   state varies across lines, and the choice of the controls varies across
   %   columns. The vector V0 must contain an initial guess for the value
   %   function. The parameter beta is the discount factor an must lie in
   %   the interval (0,1). The parameter eps is threshold below which
   %   the maximial absolute difference between successive iterates must fall
   %   for iteration to be stopped.
   %   The outputs are the value function V and the policy function (in
   %   terms of indices to the optimal policy) pi.
   %
   %   This file is part of: Macro I Problem Set 2.
   % Revision History:
   %
   not_converged=1;
   while not_converged
       VMAT=repmat(V0',size(UMAT,1),1);
       [V,pi]=max(UMAT+beta*VMAT,[],2);%V返回的是每一行的最大值，pi返回的是第几列的指标.最终返回的值应该是收敛状态的值,两个返回值均为列向量
        ind=sub2ind(size(UMAT),[1:size(UMAT,1)]',[pi]);%转化下标方便操作
        U=UMAT(ind);%取出最优policy对应的U；
       for i=1:k-1
           V=U+beta*V;
       end
       criterion=max(abs(V-V0))
       V0=V;
       if (criterion<eps)
           not_converged=0;
       end
   end
end
