extends RigidBody2D

#
# Moving_Platform Circling
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var min_pos_x
var max_pos_x
var min_pos_y
var max_pos_y
var go_left
var go_down
var stop
var stopCount

func _fixed_process(delta):
	if (stop):
		stopCount += 10*delta
		if (stopCount > 9):
			stop = false
			stopCount = 0
	elif (go_left && go_down):
		move_local_x(-4)
		move_local_y(4)
	elif (!go_left && go_down):
		move_local_x(4)
		move_local_y(4)
	elif (!go_left && !go_down):
		move_local_x(4)
		move_local_y(-4)
	else:
		move_local_x(-4)
		move_local_y(-4)
	if (get_pos().x >= max_pos_x):
		go_left = true
		stop = true
		move_local_x(-4)
	elif (get_pos().x <= min_pos_x):
		go_left = false
		stop = true
		move_local_x(4)
	elif (get_pos().y <= max_pos_y):
		go_down = true
		stop=true
		move_local_y(4)
	elif (get_pos().y >= min_pos_y):
		go_down = false
		stop=true
		move_local_y(-4)
		

func _ready():
	set_fixed_process(true)
	min_pos_x = self.get_pos().x - 350.0
	max_pos_x = self.get_pos().x + 350.0
	max_pos_y = self.get_pos().y
	min_pos_y = self.get_pos().y + 700.0
	go_left = true  
	go_down = true
	stop = false
	stopCount = 0
	
