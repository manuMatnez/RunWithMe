extends Node2D

#
# Stage13
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -1000
const CAMERA_LIMIT_TOP = -1000
const CAMERA_LIMIT_RIGHT = 7000
const CAMERA_LIMIT_BOTTOM = 1500

func _ready():
	set_name(GlobalMusic.stage13)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage3_song):
		GlobalMusic.set_stream(GlobalMusic.stage3_song)
		GlobalMusic.play()

