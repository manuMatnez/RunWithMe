extends RigidBody2D

#
# Moving_Platform Diagonal
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var min_pos
var max_pos
var go_right
var stop
var stopCount

func _fixed_process(delta):
	if (stop):
		stopCount += 10*delta
		if (stopCount > 9):
			stop = false
			stopCount = 0
	elif (go_right):
		move_local_x(-3)
		move_local_y(4)
	else:
		move_local_x(3)
		move_local_y(-4)
	if (get_pos().x >= max_pos):
		go_right = true
		stop = true
		move_local_x(-3)
		
	elif (get_pos().x <= min_pos):
		go_right = false
		stop = true
		move_local_x(3)

func _ready():
	set_fixed_process(true)
	min_pos = self.get_pos().x - 400.0
	max_pos = self.get_pos().x
	go_right = true
	stop = false
	stopCount = 0
	
