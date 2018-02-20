extends Area2D

#
# Door
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#
var POSITION_TELEPORT_X = 0.0
var POSITION_TELEPORT_Y = 0.0

func _ready():
	self.connect("body_enter",self,"_on_Door_body_enter")

func _on_Door_body_enter(body):
	if (body extends Global.player_script):
		body.set_pos(Vector2(POSITION_TELEPORT_X, POSITION_TELEPORT_Y))
		body.set_linear_velocity(Vector2(0,0))