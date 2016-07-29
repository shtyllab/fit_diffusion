function [F,C] = myfun(x,xdata)

% x is a vector with model coefficients
% x data is a vector of data points to evaluate the model at

% x(1) is hindered diffusion coefficient
% x(2) is threshold concentration

% Number of radial distance and time points 
numx = 501;
numt = 42000;

% distance between grid points (0.01cm and 1 second)
dx = 1/(numx - 1);
dt = 0.01;

% hindered diffusion coefficient
D = x(1);

% Initial concentration 
C0 = 4000;
rw = .2; % well radius
rr = rw*sqrt(2); % outer radius

% threshold concentration
TC = x(2);


% concentrations
C = zeros(numx,numt);


% setting boundary conditions
% if i is between the well radius and the absorption ring radius
for i = (rw/dx):(rr/dx)
    % set C equal to the initial concentration
    C(i,1) = C0;
end


% for each time point
for j = 1:(numt - 1)
    % for each radial distance point
    for i = 2:(numx-1)
        % Calculate the next point
         C(i,j+1) = (1-((2*D*dt)/(dx^2)))*C(i,j) + ((D*dt)/dx^2)*(((1/(2*i))+1)*C(i+1,j) - ((1/(2*i))-1)*C(i-1,j)); 
    end
end

A = zeros(1,numt);
for m = 1:numt
    for n = 1:numx-1
        if C(numx-n,m) >= TC
            A(1,m) = numx-n;
            break
        end
    end
end        

A = A*dx;

F = A(xdata);

end
