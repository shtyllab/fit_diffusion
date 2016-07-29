
% fd.m 
% Solves a transient diffusion problem using the 
% finite difference method. 
global nt delr2 D % set variables to global so they can be called anywhere

% set up the parameters 
D = 1                             % diffusion coefficient
nt = 17                           % number of grid points/sections
delr = 1/(nt-1)                   % distance between each grid point (1/16)
delr2 = delr*delr                 % radius squared (1/256)
x(1) = 0.;                        % initial condition 

for i=2:nt-1      % for (the middle grid points)
c0(i-1) = 0.;     % initialize c0, set equal to zero
x(i) = x(i-1)+delr;  % initialize x, set equal to the last x plus the grid size. (0,1/16,2/16,etc)
end 
x(nt) = x(nt-1)+delr    

tbreak = [0 .001 .01 .1 1]; % initialize tbreak vector with various times
for k=1:4                 % for some variable k from 1 to 4
tspan = [tbreak(k) tbreak(k+1)]; % create a vector [0 .001]
[t cc] = ode45('fd_rhs',tspan,c0); % solve the rhs ode between tspan for initial condition c0, save in t and cc
nn=size(t); % create a vector the same size as t
c(k,:) = cc(nn(1),:); 
c0(:) = c(k,:); 
end 

% add in the first and last point 
for k=1:4 
d(k,1) = 1; 
for i=2:nt-1 
d(k,i)=c(k,i-1); 
end 
d(k,nt) = 0; 
end 


% plot the result
plot(x,d(4,:),'g-*',x,d(3,:),'m-*',x,d(2,:),'b-*',x,d(1,:),'r-*') 
xlabel('r') 
ylabel('c') 
legend(strcat('t = ',num2str(tbreak(1))),strcat('t = ',num2str(tbreak(2))),strcat('t = ',num2str(tbreak(3))),strcat('t =',num2str(tbreak(4)))) 
title('Diffusion Problem Solved using Finite Difference Method') 