extends Node2D

#
# Stage21
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -1200
const CAMERA_LIMIT_TOP = -1000
const CAMERA_LIMIT_RIGHT = 7400
const CAMERA_LIMIT_BOTTOM = 800

func _ready():
	set_name(GlobalMusic.stage21)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Player").WALK_DEACCEL = 800.0
	
	get_node("MovingPlatforms/MovingPlatformX").SUMATORI_MAX_POS = 500.0
	
	get_node("Hazzards/RotatingFire").INITIAL_ROTATION = 10.0
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage1_song):
		GlobalMusic.set_stream(GlobalMusic.stage1_song)
		GlobalMusic.play()

