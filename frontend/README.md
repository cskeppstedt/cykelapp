UI/UX spec
==========

The UI should have two major components: *searchbox* and *map*. 

The *searchbox* should accept two endpoints *from* and *to* for your travel route. The list of destinations should include "current location", all stations in the database (and their bike availability), but you should also be able to type an adress. If you choose "current location" or type an adress, the system will lookup the nearest station via Google Maps.

The *map* should indicate all stations in the database with the marker being the station availability (3/20 = 3 bikes, 17 parking slots). When you have selected *from* and *to*, it should plot the route. Use dashed lines to show routes to/from the stations, and solid lines for the route between the stations.

Ideas
-----

Search results/suggestions show:
 
    * Current position
    * Matching stations in alphabetical order, that contains the search term
    * Previously selected stations (ranked by how many times you selcted them before)
    * Some indication that you can keep typing to search for an adress