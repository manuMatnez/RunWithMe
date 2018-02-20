extends Node2D

#
# Stage32
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -2700
const CAMERA_LIMIT_TOP = -1900
const CAMERA_LIMIT_RIGHT = 5800
const CAMERA_LIMIT_BOTTOM = 3400

func _ready():
	set_name(GlobalMusic.stage32)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Hazzards/FireballUp").WAIT_TIME = 7
	get_node("Hazzards/FireballUp2").WAIT_TIME = 7
	get_node("Hazzards/FireballUp4").WAIT_TIME = 7
	get_node("Hazzards/FireballUp6").WAIT_TIME = 7
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage2_song):
		GlobalMusic.set_stream(GlobalMusic.stage2_song)
		GlobalMusic.play()

