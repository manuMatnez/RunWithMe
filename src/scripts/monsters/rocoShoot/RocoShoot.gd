extends RigidBody2D

#
# RocoShoot
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

#RocoShoot AnimationPlayer
var animation

var shape

#RocoShoot sample
var sample

#RocoShoot status
var disabled = false
#Player damage timeOut
var disableTimer

func disable():
	if (disabled):
		return
	animation.play("shoot")
	disabled = true

func _ready():
	animation = get_node("Animation")
	shape = get_node("Shape")
	sample = get_node("Sample")
	disableTimer = get_node("DisableTimer")
	disableTimer.connect("timeout", self, "disable")
	disableTimer.start()

func _integrate_forces(state):
	for p in range(state.get_contact_count()):
		var p_player = state.get_contact_collider_object(p)
		shape.free()
		if (p_player):
			if (p_player extends Global.player_script && p_player.has_method("hit_by_enemy") && !disabled):
				p_player.call("hit_by_enemy")
				sample.play("rocoShootPlayer")
				disable()
				break
			else:
				queue_free()