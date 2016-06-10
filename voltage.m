%This program is used to observe the change in the potential of the system
%over time. The phase plan is also plotted aling with it to understand the
%point in the phase plane being considered.

function voltage()
    global a b tau I;
    % values of the parameters a, b, tau can be modified here
    a = 0.7; b = 0.8; tau = 13;
    
    % looping through different values of I to observe its effect as the
    % bifurcation parameter
    for I=[-1:0.01:1.5]
        hold off;
        % initial position - can be any value in the phase plane
        x0 = 2; y0 = 0;
        iv = [x0;y0];
        tspan = [0 80];
        % solving the system of diffrential equations using the ode45
        % solver
        [tspan, u] = ode45(@solve, tspan, iv);
        % plotting the nullines
        Y = [-3:0.1:3]; % Y represents voltage v
        X0 = (Y + a) / b;  
        Y0 = Y - Y.^3/3 + I;  
        subplot(2,1,1);
        % u contains the solution to the system of equations
        plot(tspan,u(:,2)); %hold on;
        title(['Voltage v/s Time']);
        xlabel('time t'); 
        ylabel('membrane potential v(t)');
        axis([0 80 -1.6 2.5]);  
        subplot(2,1,2); 
        plot(Y,X0,Y,Y0); hold on;
        plot(u(:,1), u(:,2));
        title('Phase plane');
        xlabel('membrane potential v(t)'); 
        ylabel('recovery variable w(t)');
        drawnow;
     end
end

% function called to solve the system of differential equations
function udot = solve(t,u)
    global a b tau I;
    x = u(1);
    y = u(2);
    xdot =  x - x.^3/3 - y + I; 
    ydot = (x + a - b*y)/tau;
    udot = [xdot; ydot]; % create a matrix of the differential equations
end