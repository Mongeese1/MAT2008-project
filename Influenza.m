function Influenza 
%input given data
time = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]
Ni = [1 3 25 72 222 282 256 233 189 123 70 25 11 4]
%set total population and initial conditions
pop = 763
i0=1
s0 = pop-i0
r0 = 0

%plot given data
plot(time,Ni,'bo')
ylabel('Number of bedridden students')
xlabel('Time in days')
hold on%to add diff eq solutions

%set ode paramaters and calculat r0 as rz
a=0.0026;
r=.5;
rz = pop*a/r
 

 f = @(t,x) [-a*x(1)*x(2);a*x(1)*x(2)-r*x(2);r*x(2)];%set up system of equations
 [t,xa]=ode45(f,[1 14], [s0 i0 r0]);%solve system using initial conditions and ode 45
 inter = interp1(time,Ni,t);%interpolate original data to fit length of ode solution array, in order to perform gof measurments

 plot(t,xa(:,1))%plot susceptible indiviudlas
 plot(t,xa(:,2),'k')%plot infected individuals
 plot(t,xa(:,3),'g')%plot recovered people
 plot(t,inter,'y')%plot interpolated data

 
n = numel(xa(:,2));%get len of array
MSE = 1/n * sum((inter - xa(:,2)).^2)%calc MSE using formula
cost_f = 'NRMSE';%declare cost function for gof calculation, in this case NRMSE
fit = goodnessOfFit(inter,xa(:,2),cost_f)%calculate NRMSE
 
 legend('Data','Susceptible pop','Infected','Recovered')%add legend to data
 hold off
