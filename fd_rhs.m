% fd_rhs.m 
function ydot=fd_rhs(time,y) 
global nt delr2 D

% add in the boundary conditions 
c(1) = 1; 
c(nt) = 0; 

% transfer the y to the c 
for i=1:nt-2 
c(i+1) = y(i); 
end 

% calculate the right-hand side 
for i=1:nt-2 
    % this equation was found using the finite difference method
dfd(i) = ((c(i+2) - c(i))/(2*(i+1))) + (c(i+2) - 2*c(i+1) + c(i))
end 
dfd = D*dfd/delr2; 

% put result in the ydot 
ydot = dfd';