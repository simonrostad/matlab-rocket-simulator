function dydt = rocketDynamics(t,y)

g = 9.81; %m/s^2
p = 1.225; %kg/m^3
Cd = 0.75; 

diameter = 9; %m
a = pi * diameter^2 / 4; %m^2

burnTime = 166; %s
propellantMass = 3.4e6; %kg
massFlowRate = propellantMass/burnTime; %kg/s

velocity = y(2); %m/s
mass = y(3); %kg
if t < burnTime
    thrust = 73.5e6;
    dmdt = -massFlowRate;
else
    thrust = 0;
    dmdt = 0;
end

drag = 0.5*p*velocity*Cd*a*abs(velocity);
acceleration = (thrust - mass*g - drag)/mass;

dydt = [
    velocity;
    acceleration
    dmdt
    ];

end
