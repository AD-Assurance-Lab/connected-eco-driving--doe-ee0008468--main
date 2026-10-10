**Driving Scenario Generation:**

**Simulation Setup is to be performed in the following steps:**

- Custom Driving Scenario Library Creation

- Simulation parameter sweep and input, output definitions

- Entire state space generation

- Simulation Execution

- Performance metric data storage

- Presenting optimal and suboptimal results and choosing best result

- Keep record of which use cases cause every configuration to fail, in those cases eliminate the use case and eliminate it from use case list on basis of poor score.

**Environment Parameter Sweeps common to ALL Drive Scenarios:**

1.  3 traffic levels: (Low, Medium, High)

2.  3 non ego vehicle distributions:

3.  2 different roadwidth/lanewidth: (6m, 10m)

4.  Across all elevations ranging between (6m,8m)

5.  Account for lighting conditions by removing camera dependency in some setups. For example: Low light overpasses/ highway tunnels in target market region.

**<u>Benchmark Driving Geometries:</u>**

Open Drive Scenarios: (3)

1.  8 course

2.  Complex 8 course

3.  Roundabout

**<u>Custom Designed Driving Scenarios:</u>**

Since use-cases and edge cases may appear across more than one road geometry scenario, they should be simulated across different road geometry classes:

The following section enumerates all **Road Geometry Classes** and their regions of interest/detection requirements:

**Road Geometry Classes and uses cases for each category:**

Use cases in each category explain what kind of environment parameters need to be swept and across what range of values:

1.  **Straight Road and Single Lane**

-Forward Vehicle Detection

-Rear Vehicle Detection

-Blind Spot Vehicle Detection

\- Front View Pedestrian Detection

-Sidewalk pedestrian detection

2.  **Multiple Lane Roads (2 lanes, 3 lanes, 4 lanes and more)**

- In non-ego vehicle being overtaken scenarios, should be able to make all neighboring vehicle detections

- In ego vehicle overtaking other vehicle scenario, should be able to make all neighboring vehicle detections

3.  **Curved Roads**

\- Front Vehicle Detection

\- Rear Vehicle Detection

\- Blind Corner elimination

4.  **Intersections**

- Ego Vehicle Stationary at traffic intersection, detection of all vehicles in coverage radius

- Ego Vehicle behind lead vehicles at intersection

5.  **Roundabouts**

\- Front Vehicle Detection

\- Rear Vehicle Detection

\- Blind Corner elimination

6.  **Exit Lane**

- Lead vehicle monitoring is key

- Neighboring lane vehicles merging into ego lane detection

- Rear Vehicles merging into ego lane

- Pedestrian detection before making turn at intersection

7.  **Road Elevation**

- (Roll,Pitch,Yaw) of sensor must be checked in range \[(minroadelevation), (maxroadelevation)\] at a step size of 1 degree change

8.  **Overpasses (Typical elevation is between 6m to 8m)**

- Lane following ability at different elevations

- Front and rear vehicle detections while entering and exiting overpass

9.  **Road Banking**

- Front vehicle detection

- Rear vehicle detection

- Blindspot non ego vehicle detection in lateral axes

10. **Interchanges:**

    1.  **Diamond Interchange** (Highways and expressways typically are comprised of two parallel roads, each going in the opposing direction. An economical interchange between a highway and a local road is a diamond interchange, which typically consists of a local road overpass and four ramps)

    2.  **Cloveleaf Interchange** (Interchange between two highways. Consists of four inner and four outer ramps).

\*An **environmentgenerator()** function should be overloaded across all the driving geometries simulating required testing conditions.
