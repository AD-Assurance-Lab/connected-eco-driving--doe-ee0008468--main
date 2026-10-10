# Connected eco-driving: DOE award DE-EE0008468 (2019-2021)

**The code, documents and publications of "Mobility and Energy Improvements for Fort Collins
and Denver", a two-year, $1.1M U.S. Department of Energy Vehicle Technologies Office project
led by Colorado State University (CSU), with the National Renewable Energy Laboratory, the
cities of Fort Collins and Denver, the Clean Cities coalitions, and Western Michigan
University. Finished; released in 2026.**

The project asked how much the energy use of a vehicle, and the flow of traffic, improve when
the vehicle can see more than its own sensors: other connected vehicles (V2V), the
infrastructure (V2I: traffic-signal phase and timing, segment travel times) and its ADAS
radar and camera. CSU drove an instrumented Chevrolet Malibu through Fort Collins on five
days in 2019 while volunteers drove their own cars with GPS and OBD loggers nearby; WMU built
velocity prediction, energy management, emissions and eco-driving models on the data.

## Data

On Hugging Face: [`AD-Assurance-Lab/connected-eco-driving-doe-ee0008468`](https://huggingface.co/datasets/AD-Assurance-Lab/connected-eco-driving-doe-ee0008468).

| Folder | What it holds |
|---|---|
| `speed-prediction/` | Parquet, one row per sample of each trip (by distance): ego position, speed, engine speed and accelerator pedal, the next five traffic signals (index, distance, phase), segment speed, V2V speed statistics; in August also the lead vehicle from the aftermarket ADAS sensors. Ready for sequence models. |
| `raw/<date>/` | 2019-05-15, 2019-07-03, 2019-08-01, 2019-10-21/22: ADAS logs (Mobileye and radar, `.blf` and decoded), ego logger CSVs, V2V logger CSVs, segment speeds, signal timing, u-blox GNSS |
| `processed/<date>/` | The MATLAB structures the team synchronized and interpolated from the raw data |
| `results/`, `video/` | Neural-network prediction results; a ZED stereo recording of the 2019-05-15 drive (`.svo`) |

Volunteer drivers appear only as D01 to D07, in file names and inside the data. Every GPS
fix in their traces lies inside the study area around central Fort Collins; no trace starts or
ends at a home.

## Code (`code/`)

MATLAB from CSU and WMU, as left at the end of the project, one folder per collection day:
import and synchronization (`Data_Concat*`, `Assign*`), time and distance interpolation,
traffic-signal and segment assignment, the velocity-prediction networks (`Data_10_21_New/`,
`NN/`) and a sensor field-of-view simulation (`Simulation/`). Paths point at the original
drive layout; adjust them to the Hugging Face folders. Autosaves, figures and vendor files
were left out. The Malibu was a GM-supplied EcoCAR vehicle. Of its own signals the release keeps only what a
standard OBD-II reader also gives (vehicle speed, engine speed, accelerator pedal) and the
position fix; the October scripts that read its CAN bus are not released, so
`Data_Concat_10_21.m` calls a missing `Data_Import_Function`.

## Documents (`docs/`)

- `data-collection/`: how the data were defined and gathered, including the participant
  directions for collection round 2.
- `quarterly-reports/`: WMU's quarterly reports to CSU, 2019-2021, and the one-page summary.
  Images were not carried over.

## Publications

| Year | Paper |
|---|---|
| 2020 | Rabinowitz, Gaikwad, White, Bradley, Asher. Synchronous and open, real world, vehicle, ADAS, and infrastructure data streams for automotive machine learning algorithms research. SAE 2020-01-0736. **The dataset paper.** |
| 2020 | Gaikwad et al. Vehicle velocity prediction using artificial neural network and effect of real world signals on prediction window. SAE 2020-01-0729. |
| 2020 | Patil, Motallebiaraghi, Meyer, Asher. Comparison of optimal energy management strategies using dynamic programming, model predictive control, and constant velocity prediction. SAE 2020-01-5071. |
| 2021 | Motallebiaraghi et al. High-fidelity modeling of light-duty vehicle emission and fuel economy using deep neural networks. SAE 2021-01-0181. |
| 2021 | Rabinowitz, Araghi, Gaikwad, Asher, Bradley. Development and evaluation of velocity predictive optimal energy management strategies in intelligent and connected hybrid electric vehicles. Energies 14(18):5713. |
| 2021 | Mahmoud et al. Autonomous eco-driving with traffic light and lead vehicle constraints: an application of best constrained interpolation. IFAC-PapersOnLine (E-COSM 2021). |
| 2022 | Motallebiaraghi et al. Mobility energy productivity evaluation of prediction-based vehicle powertrain control combined with optimal traffic management. SAE 2022-01-0141. |
| 2023 | Rabinowitz et al. An ultra-light heuristic algorithm for autonomous optimal eco-driving. SAE 2023-01-0679. |
| 2024 | Rabinowitz et al. Real-time implementation comparison of urban eco-driving controls. IEEE Transactions on Control Systems Technology. |

Crossref lists DE-EE0008468 as the funder of the Energies and TCST papers; the others come
from the project's team and reports.

## Not released

Kept on the lab's archive drive: the Malibu's CAN logs and every vehicle signal beyond the OBD-II set, including its radar tracks, Argonne's test data, TomTom map data (licensed), Mobileye and
Bosch vendor documents, the driver list, NREL's presentations, and the team's meeting decks.

## License

Code: Apache-2.0. Documents and data: CC BY 4.0. See `NOTICE`.
