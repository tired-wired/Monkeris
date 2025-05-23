/obj/item/implant/carrion_spider/infection
	name = "infection spider"
	icon_state = "spiderling_infection"
	spider_price = 50
	gene_price = 7
	var/active = FALSE

/obj/item/implant/carrion_spider/infection/activate()
	..()
	if(!wearer)
		to_chat(owner_mob, span_warning("[src] doesn't have a host"))
		return
	if(!istype(wearer)) //wearer type is automaticaly set to human
		to_chat(owner_mob, span_warning("[src] only works on humanoids"))
		return
	if(wearer.stat == DEAD)
		to_chat(owner_mob, span_warning("[wearer] is dead"))
		return
	if(is_neotheology_disciple(wearer))
		to_chat(owner_mob, span_warning("[wearer]'s cruciform prevents activation"))
		return
	var/obj/item/organ/external/affected = wearer.organs_by_name[BP_HEAD || BP_CHEST]
	if(BP_IS_ROBOTIC(affected))
		to_chat(owner_mob, span_warning("[src] cannot be activated in a prosthetic limb."))
		return

	if(is_carrion(wearer))
		to_chat(owner_mob, span_warning("Another core inside prevents activation"))
		return

	if(active)
		to_chat(owner_mob, span_warning("[src] is already active"))
		return

	active = TRUE
	to_chat(owner_mob, span_notice("\The [src] is active"))

	spawn(5 MINUTES)
		if(wearer && istype(wearer) && !(wearer.stat == DEAD) && !is_neotheology_disciple(wearer) && active && !is_carrion(wearer))
			to_chat(wearer, span_danger("The transformation is complete, you are not human anymore, you are something more"))
			to_chat(owner_mob, span_notice("\The [src] was succesfull"))
			wearer.make_carrion()
			die()
		else
			active = FALSE
			to_chat(owner_mob, span_warning("Conversion failed."))

/obj/item/implant/carrion_spider/infection/Process()
	..()
	if(wearer && active)
		if(prob(15)) //around 22 messages over 5 minutes on avarage
			var/pain_message = pick(list(
				"You feel a sharp pain in your upper body!",
				"You feel something squirm in your upper body!",
				"You feel immense agony pulsating through your body!",
				"You feel like something is moving inside your body!",
				"You feel intense pain!",
				"You feel like something is taking control of you!",
				"You feel weak, like something is growing inside of your body!"
			))
			wearer.adjustHalLoss(10) //Flat 10 agony damage
			to_chat(wearer, span_red("<font size=3><b>[pain_message]</b></font>"))
		if(prob(1)) //around 0.75 limbs per transformation
			if(prob(50))
				var/obj/item/organ/external/E = wearer.get_organ(pick(list(BP_L_ARM, BP_L_LEG, BP_R_ARM, BP_R_LEG)))
				if(E)
					E.droplimb(FALSE, DROPLIMB_BLUNT)
				else
					visible_message(span_danger("A meaty spike shoots out of [wearer]'s limb stump"))
