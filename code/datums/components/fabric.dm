GLOBAL_LIST_EMPTY(fabric_list)

/datum/component/fabric
	var/image/fabric_image

/datum/component/fabric/Initialize(value, new_desc)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_MOB_LIFE, PROC_REF(onLife))

	GLOB.fabric_list |= src

	fabric_image = image('icons/effects/fabric_symbols.dmi', parent)
	fabric_image.override = TRUE

	onLife()

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FABRIC_NEW, fabric_image)

/datum/component/fabric/Destroy()
	GLOB.fabric_list -= src
	return ..()

/datum/component/fabric/proc/onLife()
	SIGNAL_HANDLER
	var/list/states = icon_states('icons/effects/fabric_symbols.dmi', 2)

	// Why this is happening?
	if (!states.len)
		return
	fabric_image.icon_state = pick(states)
	fabric_image.pixel_x = rand(-1,1)
	fabric_image.pixel_y = rand(-1,1)
	fabric_image.color = RANDOM_RGB
