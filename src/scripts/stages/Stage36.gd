extends Node2D

#
# Stage36
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const CAMERA_LIMIT_LEFT = -300
const CAMERA_LIMIT_TOP = -1200
const CAMERA_LIMIT_RIGHT = 8500
const CAMERA_LIMIT_BOTTOM = 2000

func _ready():
	set_name(GlobalMusic.stage36)
	
	get_node("Player").camera.set_limit(0,CAMERA_LIMIT_LEFT)
	get_node("Player").camera.set_limit(1,CAMERA_LIMIT_TOP)
	get_node("Player").camera.set_limit(2,CAMERA_LIMIT_RIGHT)
	get_node("Player").camera.set_limit(3,CAMERA_LIMIT_BOTTOM)
	
	get_node("Monsters/Bobo").WALK_SPEED = 0.0
	get_node("Monsters/Bobo2").WALK_SPEED = 0.0
	get_node("Monsters/Bobo3").WALK_SPEED = 0.0
	get_node("Monsters/Bobo4").WALK_SPEED = 0.0
	get_node("Monsters/Bobo5").WALK_SPEED = 0.0
	get_node("Monsters/Bobo6").WALK_SPEED = 0.0
	get_node("Monsters/Bobo7").WALK_SPEED = 0.0
	
	get_node("Hazzards/RotatingFire1").INCREMENT_ROTATION = -0.05
	get_node("Hazzards/RotatingFire2").INCREMENT_ROTATION = -0.05
	
	if (GlobalMusic.get_stream() != GlobalMusic.stage6_song):
		GlobalMusic.set_stream(GlobalMusic.stage6_song)
		GlobalMusic.play()

