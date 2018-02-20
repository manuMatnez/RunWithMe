extends RigidBody2D

#
# MovingPlatformY
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var min_pos
var SUMATORI_MAX_POS = 400.0
var go_down
var stop
var stopCount

func _fixed_process(delta):
	if (stop):
		stopCount += 10*delta
		if (stopCount > 7):
			stop = false
			stopCount=0
	elif (go_down):
		move_local_y(3)
	else:
		move_local_y(-3)
	if (get_pos().y >= min_pos + SUMATORI_MAX_POS):
		go_down = false
		stop = true
		move_local_y(-3)
	elif (get_pos().y <= min_pos):
		go_down = true
		stop = true
		move_local_y(3)

func _ready():
	set_fixed_process(true)
	min_pos = self.get_pos().y
	go_down = true
	stop = false
	stopCount = 0
