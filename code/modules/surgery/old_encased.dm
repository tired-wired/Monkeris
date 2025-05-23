//Procedures in this file: Generic ribcage opening steps, Removing alien embryo, Fixing internal organs.
//////////////////////////////////////////////////////////////////
//				GENERIC	RIBCAGE SURGERY							//
//////////////////////////////////////////////////////////////////
/datum/old_surgery_step/open_encased
	priority = 2
	can_infect = 1
	blood_level = 1
/datum/old_surgery_step/open_encased/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return 0

	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	return affected && !BP_IS_ROBOTIC(affected) && affected.encased && affected.open >= 2


/datum/old_surgery_step/open_encased/saw
	required_tool_quality = QUALITY_SAWING

	duration = 60

/datum/old_surgery_step/open_encased/saw/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	return ..() && affected && affected.open == 2

/datum/old_surgery_step/open_encased/saw/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	user.visible_message("[user] begins to cut through [target]'s [affected.encased] with \the [tool].", \
	"You begin to cut through [target]'s [affected.encased] with \the [tool].")
	target.custom_pain("Something hurts horribly in your [affected.name]!",1)
	..()

/datum/old_surgery_step/open_encased/saw/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	user.visible_message(span_blue("[user] has cut [target]'s [affected.encased] open with \the [tool]."),		\
	span_blue("You have cut [target]'s [affected.encased] open with \the [tool]."))
	affected.open = 2.5

/datum/old_surgery_step/open_encased/saw/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	user.visible_message(span_red("[user]'s hand slips, cracking [target]'s [affected.encased] with \the [tool]!") , \
	span_red("Your hand slips, cracking [target]'s [affected.encased] with \the [tool]!") )

	affected.createwound(CUT, 20)
	affected.fracture()


/datum/old_surgery_step/open_encased/retract
	required_tool_quality = QUALITY_RETRACTING

	duration = 40

/datum/old_surgery_step/open_encased/retract/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	return ..() && affected && affected.open == 2.5

/datum/old_surgery_step/open_encased/retract/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = "[user] starts to force open the [affected.encased] in [target]'s [affected.name] with \the [tool]."
	var/self_msg = "You start to force open the [affected.encased] in [target]'s [affected.name] with \the [tool]."
	user.visible_message(msg, self_msg)
	target.custom_pain("Something hurts horribly in your [affected.name]!",1)
	..()

/datum/old_surgery_step/open_encased/retract/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = span_blue("[user] forces open [target]'s [affected.encased] with \the [tool].")
	var/self_msg = span_blue("You force open [target]'s [affected.encased] with \the [tool].")
	user.visible_message(msg, self_msg)

	affected.open = 3

/datum/old_surgery_step/open_encased/retract/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = span_red("[user]'s hand slips, cracking [target]'s [affected.encased]!")
	var/self_msg = span_red("Your hand slips, cracking [target]'s  [affected.encased]!")
	user.visible_message(msg, self_msg)

	affected.createwound(BRUISE, 20)
	affected.fracture()

/datum/old_surgery_step/open_encased/close
	requedQuality = QUALITY_RETRACTING

	duration = 30

/datum/old_surgery_step/open_encased/close/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	return ..() && affected && affected.open == 3

/datum/old_surgery_step/open_encased/close/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = "[user] starts bending [target]'s [affected.encased] back into place with \the [tool]."
	var/self_msg = "You start bending [target]'s [affected.encased] back into place with \the [tool]."
	user.visible_message(msg, self_msg)
	target.custom_pain("Something hurts horribly in your [affected.name]!",1)
	..()

/datum/old_surgery_step/open_encased/close/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = span_blue("[user] bends [target]'s [affected.encased] back into place with \the [tool].")
	var/self_msg = span_blue("You bend [target]'s [affected.encased] back into place with \the [tool].")
	user.visible_message(msg, self_msg)

	affected.open = 2.5

/datum/old_surgery_step/open_encased/close/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = span_red("[user]'s hand slips, bending [target]'s [affected.encased] the wrong way!")
	var/self_msg = span_red("Your hand slips, bending [target]'s [affected.encased] the wrong way!")
	user.visible_message(msg, self_msg)

	affected.createwound(BRUISE, 20)
	affected.fracture()

	if(affected.internal_organs && affected.internal_organs.len)
		if(prob(40))
			var/obj/item/organ/O = pick(affected.internal_organs) //TODO weight by organ size
			user.visible_message(span_danger("A wayward piece of [target]'s [affected.encased] pierces \his [O.name]!"))
			O.bruise()

/datum/old_surgery_step/open_encased/mend
	required_tool_quality = QUALITY_BONE_SETTING

	duration = 30

/datum/old_surgery_step/open_encased/mend/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	return ..() && affected && affected.open == 2.5

/datum/old_surgery_step/open_encased/mend/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = "[user] starts mending back [target]'s bones on [affected.encased] with \the [tool]."
	var/self_msg = "You start mending back [target]'s bones on [affected.encased] with \the [tool]."
	user.visible_message(msg, self_msg)
	target.custom_pain("Something hurts horribly in your [affected.name]!",1)
	..()

/datum/old_surgery_step/open_encased/mend/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	var/msg = span_blue("[user] finish mending back [target]'s bones on [affected.encased] with \the [tool].")
	var/self_msg = span_blue("You finish mending back [target]'s bones on [affected.encased] with \the [tool].")
	user.visible_message(msg, self_msg)

	affected.open = 2
