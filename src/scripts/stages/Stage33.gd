extends Node2D

#
# Stage33
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -2200
const CAMERA_LIMIT_TOP = -4600
const CAMERA_LIMIT_RIGHT = 10000
const CAMERA_LIMIT_BOTTOM = 800

func _ready():
	set_name(GlobalMusic.stage33)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("MovingPlatforms/MovingPlatformX").SUMATORI_MAX_POS = 400.0
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage3_song):
		GlobalMusic.set_stream(GlobalMusic.stage3_song)
		GlobalMusic.play()

