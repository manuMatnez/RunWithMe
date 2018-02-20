extends Node2D

#
# Stage34
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -200
const CAMERA_LIMIT_TOP = -1000
const CAMERA_LIMIT_RIGHT = 5300
const CAMERA_LIMIT_BOTTOM = 2000

func _ready():
	set_name(GlobalMusic.stage34)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Platforms/MovingPlatformX").SUMATORI_MAX_POS = 400.0
	get_node("Platforms/MovingPlatformX1").SUMATORI_MAX_POS = 100.0
	get_node("Platforms/MovingPlatformX2").SUMATORI_MAX_POS = 400.0
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage4_song):
		GlobalMusic.set_stream(GlobalMusic.stage4_song)
		GlobalMusic.play()

