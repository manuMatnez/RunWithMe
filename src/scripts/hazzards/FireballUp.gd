extends "Hazzards.gd"

#
# FireballUp
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var go_down
var go_up
var aux
var sprite
var initial_pos_y
var WAIT_TIME = 0
var boolwait

func _ready():
	if (WAIT_TIME > 0):
		boolwait = true
	else:
		boolwait = false
	initial_pos_y = self.get_pos().y
	aux = false
	go_down = 0
	go_up =- 15
	sprite = get_node("Sprite")
	set_fixed_process(true)
	

func _fixed_process(delta):
	if (WAIT_TIME > 0):
		WAIT_TIME -= 1*delta
	else:
		go_down += 0.1
		go_up += 0.1
		move_local_y(go_up + go_down)
	
		if (!aux && (go_up + go_down) > 0):
			sprite.set_global_rot(3.14)
			aux = true
	
		if (self.get_pos().y > initial_pos_y):
			go_down = 0
			go_up = -15
			aux = false
			sprite.set_global_rot(0)
	