% this program is used to plot the nullclines and observe the phase
% portrait of the system

function nullclines()
    global a b tau I;
    % values of the parameters a, b, tau can be modified here
    a = 0.7; b = 0.8; tau = 13;
    
    % looping through different values of I to observe its effect as the
    % bifurcation parameter
    for I=[-1:0.01:1.5]
            hold off;
            % initial position - can be any value in the phase plane
            x0 = 0.2; y0 = 0;
            iv = [x0;y0]; 
            tspan = [0 80];
            % solving the system of diffrential equations using the ode45
            % solver
            [tspan, u] = ode45(@solve, tspan, iv);
            % plotting the nullines 
            Y = [-3:0.1:3]; % Y represents voltage v
            X0 = (Y + 0.7) / 0.8;  
            Y0 = Y - Y.^3/3 + I;  
            plot(Y,X0,Y,Y0); hold on;
            % u contains the solution to the system of equations
            plot(u(:,1), u(:,2));
            axis([-2 2 -1 2.5]);
            xlabel('Mmebrane Potential v(t)');
            ylabel('Recovery Variable w(t)');
            title('Nullclines');
            legend('recovery variable w(t)','membrane potential v(t)');
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