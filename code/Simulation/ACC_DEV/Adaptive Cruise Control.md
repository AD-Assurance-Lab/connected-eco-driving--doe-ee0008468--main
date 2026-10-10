Adaptive Cruise Control (ACC) Simulation Overview

The CSU-VIT team will endeavor to produce multiple levels of adaptive cruise control “test-bench” simulations wherein various CAVS instrumentation setups and ACC control schemes can be tested.

The simulations will be MATLAB based as this allows for use of the GM Blazer dynamics model and the Automated Systems Driving Toolbox.

Ultimately the goal of the CSU-VIT ACC is to maintain a safe and consistent “following time”. That is to say that the goal following distance will be dependent on the speed of the vehicle which the ACC algorithm is targeting. This will mimic something like the “4 second rule” taught in driving classes. As a goal of the autonomous behavior in the CSU-VIT vehicle is to mimic defensive driving, safe behaviors such as the “4 second rule”, blind spot avoidance, and in lane maneuvering will be central to the algorithm.

Ultimately the goals of the ACC system will be:

1.  Maintain a prescribed following time

2.  Adjust following distances without significant overshoot

3.  Avoid longitudinal accelerations of greater than 1 G, lateral greater than .5 G

4.  Avoid remaining in the blind spot of vehicles in adjacent lanes

5.  Quickly pass trucks in adjacent lanes

The values for following time and max accelerations are not set in stone and ultimately should be consumer options and easily adjustable. Truck and blind spot avoidance will be Boolean optional.

Evaluations of control schema and sensor setup will be based on performance in a “random” scenario. This means that simulations will be designed to be run with a batch of semi-random scenarios for evaluation.

Goals for Simulation Development:

1.  Produce simple linear model for testing control schemes based on ground truth

2.  Integrate sensors simulation into linear model for testing instrumentation setup

3.  Expand model to account for 3DOF Dynamics

Goals for ACC Simulation Testing

1.  Test multiple control schema and determine path for future development.
