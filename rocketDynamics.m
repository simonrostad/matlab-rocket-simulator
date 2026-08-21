function dydt = rocketDynamics(t,y)

Initial_Mass = 5.26e6;

theta = deg2rad(30);
x_Position = y(1);
Altitude = y(2);
p0 = 1.225; %kg/m^3
Cd = 0.75; 
p = p0 * exp(Altitude/-8500);

diameter = 9; %m
a = pi * diameter^2 / 4; %m^2

burnTime = 166; %s
propellantMass = 3.4e6; %kg
massFlowRate = propellantMass/burnTime; %kg/s

G = 6.67430e-11;
Me = 5.9722e24; %Mass of Earth
Re = 6.3781e6; %Radius of Earth
g = (G*Me)/(Re+Altitude)^2; %Calculate variable gravity

velocity_x = y(3);
velocity_y = y(4);
velocity = sqrt(velocity_x^2 + velocity_y^2);

if t < burnTime
    thrust = 73.5e6;
    thrust_x = thrust*sin(theta);
    thrust_y = thrust*cos(theta);
    dmdt = -massFlowRate;
    mass = Initial_Mass - massFlowRate * t;
else
    thrust_x = 0;
    thrust_y = 0;
    dmdt = 0;
    mass = Initial_Mass - massFlowRate * burnTime;
end

PathAngle = atan2(velocity_x, velocity_y);
drag = 0.5*p*velocity*Cd*a*abs(velocity);
drag_x = drag * sin(PathAngle);
drag_y = drag * cos(PathAngle);
acceleration_x = (thrust_x - drag_x)/mass;
acceleration_y = (thrust_y - mass*g - drag_y)/mass;

dydt = [
    velocity_x
    velocity_y
    acceleration_x
    acceleration_y
    ];

end
