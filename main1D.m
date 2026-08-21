y0 = [0;0;3.675e6];

tspan = [0 166];

[t,y] = ode45(@rocketDynamics, tspan,y0)

[maxHeight, index] = max(y(:,1));

apogeeTime = t(index);

disp(maxHeight)
disp(apogeeTime)

plot(t,y(:,1))
xlabel('Time (s)')
ylabel('Height (m)')
grid on

figure
plot(t,y(:,2))
xlabel('Time (s)')
ylabel('Velocity (m/s)')
grid on

figure
plot(t,y(:,3))
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on
