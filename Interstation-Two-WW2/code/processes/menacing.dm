var/process/menacing/menacing_process = null

/process/menacing/setup()
	name = "menacing"
	schedule_interval = 50 // every 5 seconds
	start_delay = 50
	fires_at_gamestates = list(GAME_STATE_PLAYING, GAME_STATE_FINISHED)
	menacing_process = src

/process/menacing/fire()
	SCHECK
	for(var/last_atom in menacing_atoms)
		var/atom/A = last_atom
		if(isnull(A.gcDestroyed))
			try
				var/list/turfs = list(get_turf(A))
				for (var/turf/T in range(1, turfs[1]))
					turfs += T
				for (var/turf/T in turfs)
					if (prob(33))
						if (ismovable(A))
							new /obj/effect/kana (T, A)
						else
							new /obj/effect/kana (T)
			catch(var/exception/e)
				catchException(e, A)
		else
			catchBadType(A)
			processing_objects -= A
		SCHECK

/process/menacing/statProcess()
	..()
	stat(null, "[menacing_atoms.len] atoms")

/process/menacing/htmlProcess()
	return ..()  + "[menacing_atoms.len] atoms"