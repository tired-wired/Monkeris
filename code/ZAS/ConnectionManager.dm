/*

Overview:
	The connection_manager class stores connections in each cardinal direction on a turf.
	It isn't always present if a turf has no connections, check if(connections) before using.
	Contains procs for mass manipulation of connection data.

Class Vars:

	NSEWUD - Connections to this turf in each cardinal direction.

Class Procs:

	get(d)
		Returns the connection (if any) in this direction.
		Preferable to accessing the connection directly because it checks validity.

	place(datum/connection/c, d)
		Called by SSair.connect(). Sets the connection in the specified direction to c.

	update_all()
		Called after turf/update_air_properties(). Updates the validity of all connections on this turf.

	erase_all()
		Called when the turf is changed with ChangeTurf(). Erases all existing connections.

	check(datum/connection/c)
		Checks for connection validity. It's possible to have a reference to a connection that has been erased.


*/

/turf/var/tmp/datum/connection_manager/connections

/datum/connection_manager/
	var/datum/connection/N
	var/datum/connection/S
	var/datum/connection/E
	var/datum/connection/W

#ifdef ZLEVELS
	var/datum/connection/U
	var/datum/connection/D
#endif

/datum/connection_manager/proc/get(d)
	switch(d)
		if(NORTH)
			if(check(N)) return N
			else return null
		if(SOUTH)
			if(check(S)) return S
			else return null
		if(EAST)
			if(check(E)) return E
			else return null
		if(WEST)
			if(check(W)) return W
			else return null

		#ifdef ZLEVELS
		if(UP)
			if(check(U)) return U
			else return null
		if(DOWN)
			if(check(D)) return D
			else return null
		#endif

/datum/connection_manager/proc/place(datum/connection/c, d)
	switch(d)
		if(NORTH) N = c
		if(SOUTH) S = c
		if(EAST) E = c
		if(WEST) W = c

		#ifdef ZLEVELS
		if(UP) U = c
		if(DOWN) D = c
		#endif

/datum/connection_manager/proc/update_all()
	if(check(N)) N.update()
	if(check(S)) S.update()
	if(check(E)) E.update()
	if(check(W)) W.update()
	#ifdef ZLEVELS
	if(check(U)) U.update()
	if(check(D)) D.update()
	#endif

/datum/connection_manager/proc/erase_all()
	if(check(N)) N.erase()
	if(check(S)) S.erase()
	if(check(E)) E.erase()
	if(check(W)) W.erase()
	#ifdef ZLEVELS
	if(check(U)) U.erase()
	if(check(D)) D.erase()
	#endif

/datum/connection_manager/proc/check(datum/connection/c)
	return c && c.valid()
