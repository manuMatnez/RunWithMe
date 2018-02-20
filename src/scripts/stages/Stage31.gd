extends Node2D

#
# Stage31
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -200
const CAMERA_LIMIT_TOP = -1000
const CAMERA_LIMIT_RIGHT = 8400
const CAMERA_LIMIT_BOTTOM = 1100

func _ready():
	set_name(GlobalMusic.stage31)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Hazzards/RotatingFire1").INITIAL_ROTATION = 180
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage1_song):
		GlobalMusic.set_stream(GlobalMusic.stage1_song)
		GlobalMusic.play()

