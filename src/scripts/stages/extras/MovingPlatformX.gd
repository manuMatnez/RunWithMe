extends RigidBody2D

#
# MovingPlatformX
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var min_pos
var go_right
var SUMATORI_MAX_POS = 200.0

func _fixed_process(delta):
	if (go_right):
		move_local_x(2)
	else:
		move_local_x(-2)
	if (get_pos().x >= min_pos + SUMATORI_MAX_POS):
		go_right = false
	elif (get_pos().x <= min_pos):
		go_right = true

func _ready():
	set_fixed_process(true)
	min_pos = self.get_pos().x
	go_right = true
