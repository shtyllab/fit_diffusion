
xdata = [1 2.5 4 5.5 7 8.5 10 11.5];
xdata = xdata*3600;

ydata = [0.30 0.45 0.63 0.70 0.77 0.82 0.87 0.91];

% initial parameters 
parameters = [.1e-05 5.7];

% lower bound for parameters
lb = [0 0];

% upper bound for parameters
ub = [0 5.7];

% options for optimization
options = optimset('TolX',1e-20,'TolFun',1e-20,'DiffMinChange',1e-02);

output = lsqcurvefit(@myfun,parameters,xdata,ydata,lb,ub,options);


figure(1)
hold on;
plot(xdata,myfun(output,xdata));
scatter(xdata,ydata);
hold off;






