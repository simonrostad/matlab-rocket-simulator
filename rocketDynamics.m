function dydt = rocketDynamics(t,y)

g = 9.81;

mass = 1; %kg

if t < 8
    thrust = 15;
else
    thrust = 0;
end

velocity = y(2);

acceleration = (thrust - mass*g)/mass;

dydt = [
    velocity;
    acceleration
    ];

end