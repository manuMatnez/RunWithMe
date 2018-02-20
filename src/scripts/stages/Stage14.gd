extends Node2D

#
# Stage14
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -900
const CAMERA_LIMIT_TOP = -1000
const CAMERA_LIMIT_RIGHT = 6800
const CAMERA_LIMIT_BOTTOM = 1100

func _ready():
	set_name(GlobalMusic.stage14)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Coins/Coin4").SUMATORI_MAX_POS = 300.0
	get_node("Coins/Coin9").SUMATORI_MAX_POS = 200.0
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage4_song):
		GlobalMusic.set_stream(GlobalMusic.stage4_song)
		GlobalMusic.play()

