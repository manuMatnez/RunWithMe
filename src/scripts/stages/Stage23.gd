extends Node2D

#
# Stage23
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -1700
const CAMERA_LIMIT_TOP = -2600
const CAMERA_LIMIT_RIGHT = 6400
const CAMERA_LIMIT_BOTTOM = 3300

func _ready():
	set_name(GlobalMusic.stage23)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Player").WALK_DEACCEL = 800.0
	
	get_node("Doors/Door").POSITION_TELEPORT_X = 1000.0
	get_node("Doors/Door").POSITION_TELEPORT_Y = 27.0
	get_node("Doors/Door1").POSITION_TELEPORT_X = 700.0
	get_node("Doors/Door1").POSITION_TELEPORT_Y = 540.0
	get_node("Doors/Door2").POSITION_TELEPORT_X = 3200.0
	get_node("Doors/Door2").POSITION_TELEPORT_Y = 91.0
	get_node("Doors/Door3").POSITION_TELEPORT_X = 1400.0
	get_node("Doors/Door3").POSITION_TELEPORT_Y = 2140.0
	get_node("Doors/Door4").POSITION_TELEPORT_X = 700.0
	get_node("Doors/Door4").POSITION_TELEPORT_Y = 540.0
	get_node("Doors/Door5").POSITION_TELEPORT_X = 700.0
	get_node("Doors/Door5").POSITION_TELEPORT_Y = 540.0
	
	get_node("Coins/Coin").SUMATORI_MAX_POS = 550.0
	get_node("Coins/Coin1").SUMATORI_MAX_POS = 620.0
	get_node("Coins/Coin2").SUMATORI_MAX_POS = 620.0
	get_node("Coins/Coin3").SUMATORI_MAX_POS = 620.0
	get_node("Coins/Coin4").SUMATORI_MAX_POS = 550.0
	get_node("Coins/Coin5").SUMATORI_MAX_POS = 620.0
	
	get_node("MovePlatform/MovingPlatformY").SUMATORI_MAX_POS = 550.0
	get_node("MovePlatform/MovingPlatformY1").SUMATORI_MAX_POS = 550.0
	
	get_node("Hazzards/RotatingFire").INCREMENT_ROTATION = 0.03
	get_node("Hazzards/RotatingFire1").INITIAL_ROTATION = 180.0
	get_node("Hazzards/RotatingFire1").INCREMENT_ROTATION = 0.03
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage3_song):
		GlobalMusic.set_stream(GlobalMusic.stage3_song)
		GlobalMusic.play()

