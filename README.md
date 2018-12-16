# Objective
Develop a web application that allows you to visualize routes from a csv file and apply
filters on the information loaded. For them it will be necessary to create a module of
file upload and a route display module.

## Necessary knowledge
- HTML
- Rails

Requirements
Load data
1. User enters route loading form
2. Form requests a 'Identification name of data load', 'Date of routes' and
file to load.
3. Only files with a .csv extension are allowed
4. Once the 'Load' button is pressed, the system must validate the format of the files
start loading.
5. Load progress messages should be displayed in the view. Ex: "Generating routes",
"Finalized Load"
6. User displays load summary, with detail of failures in case of occurrence. User
You should have the possibility to upload more files or go to map view.
See routes
1. User displays in a table all the routes loaded for a specific date.
Default: today.
2. User has the possibility to filter by import name and start date and time
route
3. Extra: User displays on a map all routes loaded for a specific date.
Default: today.

## Relevant entities
Route
- Description: A route is a collection of stops
- Attributes:
- id_route: unique and growing identifier.
- load_name: Unique identifier indicated by the user when loading the route by
archive.
- route: Route number specified by the user in the upload file.
- date: Date the route is planned.
- start_time: Time of the first stop of the route.
- end_time: Time of the last stop of the route.

Stops
- Description: location where the vehicle running the route must stop to pick up
or deliver a load. For this case we ignore the type of stop (pick up / deliver)
- Attributes:
- id_parada: unique and growing identifier
- route id: reference to the route to which the stop belongs
- arrived_time: Arrival time to the point.
- Charge: how much will be delivered or collected at that stop.
- latitude
- length

## Implementation details
To load files and load progress display, you must separate the work from the
web server (Input data entry) and background works (Read process of
files and transformation to the data model). For this you can use delayed jobs or
any other implementation of work queues.
Extra:
To visualize routes on the map, you must use the google API:
PRIVATED

## Stages
Stage 1:
- Draw solution. Show data model to use
- Create Rails project
- Create BD and the defined tables
Stage 2: depends on stage 1
- Load csv file
- Load file with delayed jobs and showing load status.
Stage 3: depends on stage 1
- Show table with all the existing routes in BD
- Extra: Show map with all existing routes in BD
Stage 4: depends on stage 3
- Add filter by load name
- Add filter by date and time of route start



## File format (stops)

- ruta hora_parada carga   latitude    longitude
- 1        10:00          10     -34.177361 -70.830348
- 1        10:15          15     -33.386672 -70.794256
- 1        11:00          20     -33.716194 -70.726923
- 1        11:30          13     -33.417744 -70.649532
- 2        8:00            12     -33.047369 -71.605453
- 2        8:25            54     -33.4084     -70.78226
- 2        8:50            35     -33.417347 -70.607967
- 2        10:00          28     -33.429832 -70.657829
- 2        10:30          16     -33.497821 -70.606803
- 3        12:00          41     -33.499986 -70.613921
- 3        12:30          27     -33.49978    -70.61596
- 3        13:30          16     -33.383989 -70.592601



## Links of interest
https://developers.google.com/maps/documentation/javascript/examples/polyline-simple
https://www.sitepoint.com/delayed-jobs-best-practices/

https://developers.google.com/maps/documentation/javascript/

## Estimated develop times

Requirements: 1h
File upload and processing: 3h
Table and filters: 2h
Extra (Map): 2h