extends Node2D

#
# Stage15
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -200
const CAMERA_LIMIT_TOP = -500
const CAMERA_LIMIT_RIGHT = 2700
const CAMERA_LIMIT_BOTTOM = 6800

func _ready():
	set_name(GlobalMusic.stage15)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("MovingPlatformX").SUMATORI_MAX_POS = 300.0
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage5_song):
		GlobalMusic.set_stream(GlobalMusic.stage5_song)
		GlobalMusic.play()

