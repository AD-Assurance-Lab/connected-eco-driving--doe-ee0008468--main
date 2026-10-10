Development of Custom Constructors for Sensors in MATLAB FOV Simulation

CSU Vehicle Innovation Team

Aaron Rabinowitz

Introduction:

FOV simulation based optimization will consider the following four types of sensors:

1.  Object Detecting Radar: Radar based sensor which outputs detections via CAN

2.  Smart Camera: Visual sensor which functions to output, among other things, lane and object detections

3.  Directional LiDAR: LiDAR sensor which can detect objects and lanes and is in a fixed location/orientation.

4.  Scanning LiDAR: LiDAR sensor which can detect objects and lanes and rotates at a constant high velocity, which allows it to have an effective 360 degree FOV.

Finally, there will also be a custom constructor for the fused system.

Requirements:

1.  Functionality: All constructors must have the following capabilities:

    1.  All classes must have an implicit main which takes, as inputs, all information required to initialize the class for use in simulation.

    2.  Generation of all sensors and other objects must occur in a single initialization function which is called in the class’s implicit main.

    3.  Data must be generated during simulation and stored under the property “data”

    4.  Data must be a structure with the field “names” which consists of the variables as strings of the format \<sensor name\>\_\<variable name\> and the field data which consists of 1 by n doubles with a unified time vector.

    5.  All functions which are required to run during a single simulation step must be called with a single step function.

    6.  The constructors must contain methods capable of graphing their FOVs and detections.

2.  Initially constructors will be made for:

    1.  Bosch MRR Front

    2.  Bosch MRR Rear

    3.  Bosch MRR Corner

    4.  Mobileye6

    5.  Velodyne VLP-16

    6.  Combined Object Tracker

    7.  Generic GPS Sensor

    8.  Generic IMU Sensor

    9.  Generic V2X Sensor
