extends Node2D

#
# Stage22
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#


const CAMERA_LIMIT_LEFT = -1000
const CAMERA_LIMIT_TOP = -1000
const CAMERA_LIMIT_RIGHT = 11000
const CAMERA_LIMIT_BOTTOM = 800

func _ready():
	set_name(GlobalMusic.stage22)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Player").WALK_DEACCEL = 800.0
	
	get_node("Monsters/Bobo1").WALK_SPEED = 150.0
	get_node("Monsters/Bobo3").WALK_SPEED = 150.0
	
	get_node("Coins/Coin9").SUMATORI_MAX_POS = 600.0
	
	get_node("Hazzards/FireballUp1").WAIT_TIME = 1
	get_node("Hazzards/FireballUp3").WAIT_TIME = 1
	
	get_node("Hazzards/RotatingFire").INCREMENT_ROTATION = 0.03
	get_node("Hazzards/RotatingFire1").INITIAL_ROTATION = 180.0
	get_node("Hazzards/RotatingFire1").INCREMENT_ROTATION = 0.03
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage2_song):
		GlobalMusic.set_stream(GlobalMusic.stage2_song)
		GlobalMusic.play()

