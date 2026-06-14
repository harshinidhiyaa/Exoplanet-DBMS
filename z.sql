CREATE TABLE "exoplanet_info" (
    "Id_n" integer,
    "Name" text,
    "Mass" decimal,
    "Radius" decimal,
    "Orbital_period_days" double precision,
    "Year" integer,
    PRIMARY KEY ("Id_n")
);

\copy "exoplanet_info" ("Id_n", "Name", "Mass", "Radius", "Orbital_period_days", "Year") FROM '/Users/newmac/Downloads/DBMS Project_exoplanets/exoplanet_info.csv' WITH DELIMITER ',' CSV HEADER;
---------
CREATE TABLE "massradius" (
    "Id_n" integer,
    "Name" text,
    "Mass" decimal,
    "Mass_error_min" decimal,
    "Mass_error_max" decimal,
    "Mass_sini" decimal,
    "Mass_sini_error_min" decimal,
    "Mass_sini_error_max" decimal,
    "Radius" decimal,
    "Radius_error_min" decimal,
    "Radius_error_max" decimal,
    "Density" double precision,
    "Average_Mass" double precision,
    "Average_Radius" double precision,
    PRIMARY KEY ("Name"),
    FOREIGN KEY ("Id_n")
    REFERENCES Exoplanet_info("Id_n")
);
\copy "massradius" ("Id_n","Name", "Mass", "Mass_error_min", "Mass_error_max", "Mass_sini", "Mass_sini_error_min", "Mass_sini_error_max", "Radius", "Radius_error_min", "Radius_error_max", "Density", "Average_Mass", "Average_Radius")FROM '/Users/newmac/Downloads/DBMS Project_exoplanets/massradius.csv' WITH DELIMITER ',' CSV HEADER;
-----------
CREATE TABLE "planet_status" (
    "Id_n" integer,
    "Name" text,
    "Pstatus" text,
    "Semi_major_axis" decimal,
    "Semi_major_axis_emin" decimal,
    "Semi_major_axis_emax" decimal,
    "Eccentricity" decimal,
    "Inclination" decimal,
    "Angular_dist" decimal,
    "Updated" date,
    PRIMARY KEY ("Name"),
    FOREIGN KEY ("Id_n")
    REFERENCES Exoplanet_info("Id_n")
);
\copy "planet_status" ("Id_n","Name", "Pstatus", "Semi_major_axis", "Semi_major_axis_emin", "Semi_major_axis_emax", "Eccentricity", "Inclination", "Angular_dist", "Updated")FROM '/Users/newmac/Downloads/DBMS Project_exoplanets/planet_status.csv' WITH DELIMITER ',' CSV HEADER;
--------
CREATE TABLE "planet_specifics" (
    "Id_n" integer,
    "Aop" decimal,
    "Eop" decimal,
    "Temperature" text,
    "Publication" text,
    "Detection_type" text,
    "Mass_detection_type" text,
    "Radius_detection_type" text,
    "Alt_names" text,
    "Molecules" text,
    "Periapsis_Dist" double precision,
    "Apoapsis_Dist" double precision,
    PRIMARY KEY ("Id_n")
);
\copy "planet_specifics" ("Id_n", "Aop", "Eop", "Temperature", "Publication", "Detection_type", "Mass_detection_type", "Radius_detection_type", "Alt_names", "Molecules",  "Periapsis_Dist","Apoapsis_Dist")FROM '/Users/newmac/Downloads/DBMS Project_exoplanets/planet_specifics.csv' WITH DELIMITER ',' CSV HEADER;
----
CREATE TABLE "stars" (
    "Id_n" integer,
    "Star_name" text,
    "Ra" double precision,
    "Dec" double precision,
    "Star_type" text,
    "Star_age" decimal,
    "Star_alt_names" text,
    "Star_magnitude" double precision,
    PRIMARY KEY ("Id_n")
);
\copy "stars" ("Id_n", "Star_name", "Ra", "Dec", "Star_type", "Star_age", "Star_alt_names", "Star_magnitude") FROM '/Users/newmac/Downloads/DBMS Project_exoplanets/stars.csv' WITH DELIMITER ',' CSV HEADER;
---
CREATE TABLE "star_properties" (
    "Id_n" integer,
    "Star_dist" double precision,
    "Star_dist_error_min" double precision,
    "Star_dist_error_max" double precision,
    "Star_metallicity" double precision,
    "Star_mass" double precision,
    "Star_mass_err_min" double precision,
    "Star_mass_err_max" double precision,
    "Star_radius" double precision,
    "Star_rad_err_min" double precision,
    "Star_rad_err_max" double precision,
    PRIMARY KEY ("Id_n")
);
\copy "star_properties" ("Id_n", "Star_dist", "Star_dist_error_min", "Star_dist_error_max", "Star_metallicity", "Star_mass", "Star_mass_err_min", "Star_mass_err_max", "Star_radius", "Star_rad_err_min", "Star_rad_err_max")FROM '/Users/newmac/Downloads/DBMS Project_exoplanets/star_properties.csv' WITH DELIMITER ',' CSV HEADER;

