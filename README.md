# Exoplanet Data Management & Comparison System

A web-based database application designed to manage, update, compare, and sort exoplanet data retrieved from the NASA Exoplanet Archive. Built using a **Flask** backend and an **SQL** database, this system provides a structured way to handle extensive astronomical datasets and display them according to user preferences.

---

## Project Overview
The core objective of this project is to streamline the handling of planetary data, transforming raw, redundant datasets into an easily accessible and manageable format. Users can query the system to view specific planetary characteristics, update values across interconnected tables simultaneously, and manage entries through standard CRUD (Create, Read, Update, Delete) operations.

* **Data Source:** NASA Exoplanet Archive
* **Raw Dataset Size:** 35,115 records
* **Cleaned Dataset Size:** 5,514 records (Filtered to reduce redundancy and eliminate prohibitive NULL values in vital columns like Mass and Radius).

---

## Database Schema & Architecture

Every table in the cleaned database contains exactly **5,514 tuples**, mapped using synchronized Primary and Foreign Keys (`Id_n`).

### Schema Overview

| Entity Name | Attributes | Keys / Constraints |
| :--- | :--- | :--- |
| **exoplanet_info** | `Id_n`, `Name`, `Mass`, `Radius`, `Orbital_period_days`, `Year` | `Id_n` (PRIMARY KEY) |
| **massradius** | `Id_n`, `Name`, `Mass`, `Mass_error_min`, `Mass_error_max`, `Mass_sini`, `Mass_sini_error_min`, `Mass_sini_error_max`, `Radius`, `Radius_error_min`, `Radius_error_max`, `Density` (calculated), `Average_Mass` (calculated), `Average_Radius` (calculated) | `Id_n` (FOREIGN KEY), `Name` (PRIMARY KEY) |
| **planet_status** | `Id_n`, `Name`, `Pstatus`, `Semi_major_axis`, `Semi_major_axis_emin`, `Semi_major_axis_emax`, `Eccentricity`, `Inclination`, `Angular_dist`, `Updated` | `Id_n` (PRIMARY KEY) |
| **planet_specifics** | `Id_n`, `Aop`, `Eop`, `Temperature`, `Publication`, `Detection_type`, `Mass_detection_type`, `Radius_detection_type`, `Alt_names`, `Molecules`, `Periapsis_Dist` (calculated), `Apoapsis_Dist` (calculated) | `Id_n` (PRIMARY KEY) |
| **stars** | `Id_n`, `Star_name`, `Ra`, `Dec`, `Star_type`, `Star_age`, `Star_alt_names`, `Star_magnitude` | `Id_n` (PRIMARY KEY) |
| **star_properties** | `Id_n`, `Star_dist`, `Star_dist_error_min`, `Star_dist_error_max`, `Star_metallicity`, `Star_mass`, `Star_mass_err_min`, `Star_mass_err_max`, `Star_radius`, `Star_rad_err_min`, `Star_rad_err_max` | `Id_n` (PRIMARY KEY) |

---

## System Architecture & User View

### User Interface Flow
1. **Data Visualization:** The user views baseline exoplanet data tuples to understand what information the webpage hosts.
2. **Data Modification (Update/Delete):** Interactive options next to the data tables allow users to delete or update specific entries. Updating core metrics automatically triggers updates across relational tables using the `Id_n` key.
3. **Data Insertion:** A dedicated form accepts new exoplanet profiles (requiring `Name`, `Mass`, `Radius`, `Eccentricity`, and `Star Name`).

### Performance Metrics
* **Database Load Time:** 10–15 seconds (due to dataset volume).
* **Query Execution Time:** 5–8 seconds per query.

---
