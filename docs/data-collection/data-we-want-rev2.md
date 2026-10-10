What we want:

for every Ego LatLon:

1\. Time

2\. Traffic lights (TSP):

indices onf next m traffic lights

distances to next m traffic lights along ego path

phases of the signals for each of the m lights

3\. Segments (V2I):

Currnet segment index

current segment speed

dist along segment (relative to segment) HEURISTIC TIME!

4\. Historical data (V2V):

Mu and Sigma for Speeds of "historical traces" at ego latlon

5\. ADAS:

Lead vehicle dx, dy, and vx

other vehicles dx, dy, and vx

(remember that all data with dx\<=.5 is spurious)
