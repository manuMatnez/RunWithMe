extends Node2D

#
# Stage16
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -5500
const CAMERA_LIMIT_TOP = -5000
const CAMERA_LIMIT_RIGHT = 5500
const CAMERA_LIMIT_BOTTOM = 1000

func _ready():
	set_name(GlobalMusic.stage16)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage6_song):
		GlobalMusic.set_stream(GlobalMusic.stage6_song)
		GlobalMusic.play()

