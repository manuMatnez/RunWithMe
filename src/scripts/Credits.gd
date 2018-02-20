extends Node2D

#
# Credits
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var video

func _ready():
	set_name(GlobalMusic.credits)
	set_process(true)
	
	video = get_node("Controls/Video")
	
	GlobalMusic.set_stream(GlobalMusic.menu_song)
	GlobalMusic.play()

	video.play()
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")

func _process(delta):
	if (!video.is_playing()):
		get_tree().change_scene_to(Global.menu_scene)
		
func _fixControls():
	video.set_size(get_viewport_rect().size)
	video.set_pos(Vector2(0,0))