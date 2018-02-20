extends Node2D

#
# Stage25
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -300
const CAMERA_LIMIT_TOP = -500
const CAMERA_LIMIT_RIGHT = 3700
const CAMERA_LIMIT_BOTTOM = 8600

func _ready():
	set_name(GlobalMusic.stage25)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Player").WALK_DEACCEL = 800.0
	
	get_node("Hazzards/RotatingFire2").INITIAL_ROTATION = 180
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage5_song):
		GlobalMusic.set_stream(GlobalMusic.stage5_song)
		GlobalMusic.play()

