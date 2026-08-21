# MATLAB Rocket Simulator

A MATLAB flight dynamics simulator built on `ode45`, modeling a two-stage
launch vehicle loosely based on SpaceX's Super Heavy / Starship system.

## Overview

This project simulates the ascent trajectory of a two-stage rocket,
including stage separation, mass handoff, variable gravity, atmospheric
drag, and motor burnout — with an event-driven apogee detection system
rather than a fixed simulation time window.

## Current Features

- **Two-stage simulation** — Super Heavy booster burn, separation, and
  Starship upper-stage burn modeled as sequential `ode45` integrations
- **Variable mass** — mass decreases during burn based on propellant
  mass flow rate, with correct total-stack mass carried through booster
  flight and reset at separation
- **Variable gravity** — gravitational acceleration calculated from
  Newton's law of gravitation as a function of altitude, rather than
  assumed constant
- **Atmospheric drag** — exponential atmospheric density model combined
  with a drag coefficient and vehicle cross-sectional area
- **Event-driven apogee detection** — uses MATLAB's `ode45` event
  functions to detect the exact moment vertical velocity crosses zero,
  rather than guessing a simulation end time
- **Orbital velocity cutoff** — stage 2 thrust terminates once the
  vehicle reaches a target orbital velocity, rather than burning 100%
  of available propellant regardless of speed
- **In progress: planar 3DOF dynamics** (`rocketDynamics3D.m`) — extends
  the vertical-only model to include horizontal position/velocity and a
  pitch angle, splitting thrust and drag into x/y components

## Known Simplifications

This model trades some realism for simplicity and is a work in progress:

- Constant drag coefficient (`Cd = 0.75`) — real vehicles have a
  Mach-dependent drag curve
- Constant specific impulse per stage — real engines gain efficiency
  with altitude (sea-level vs. vacuum performance)
- No gravity turn yet in the main 1D model — the vehicle rises purely
  vertically (the in-progress 3DOF branch addresses this)
- Orbital cutoff is currently based on total speed only, not on
  achieving a specific orbital *direction* — a full orbital insertion
  requires horizontal, not vertical, velocity

## Files

| File | Description |
|---|---|
| `main.m` | Entry point — runs both stages, computes apogee, generates plots |
| `rocketDynamics.m` | Stage 1 (Super Heavy) equations of motion, 1D vertical |
| `rocketDynamics2.m` | Stage 2 (Starship) equations of motion, 1D vertical |
| `rocketDynamics3D.m` | Planar 3DOF dynamics (in progress) |
| `apogeeEvent.m` | Event function used by `ode45` to detect apogee |

## How to Run

Open `main.m` in MATLAB and run. The script will:
1. Simulate Stage 1 (booster burn)
2. Hand off state to Stage 2 at separation
3. Simulate Stage 2 through burnout and coast to apogee
4. Print max height and time to apogee
5. Plot height, velocity, and mass over the full flight

## Sample Output

*(Add a screenshot of your height/velocity plots here — drag an image
into the GitHub web editor and it'll insert the markdown automatically)*

## Roadmap

- [ ] Finish planar 3DOF model with a realistic pitch-over/gravity turn
- [ ] Extend orbital cutoff to check horizontal velocity component
- [ ] Add altitude-dependent Isp (sea-level → vacuum transition)
- [ ] Add altitude-dependent drag coefficient
