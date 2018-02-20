extends Node2D

#
# BackButton
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var backBtn

func _ready():
	backBtn = get_node("BackBtn")
	backBtn.connect("pressed",self,"_on_BackBtn_pressed")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")

#Fix all the button positions
func _fixControls():
	set_pos(Vector2(0, 0))

func _on_BackBtn_pressed():
	GlobalSample.pressBtn("backPressed")
	get_tree().change_scene_to(Global.menu_scene)

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST && OS.get_name() == "Android"):
		get_tree().change_scene_to(Global.menu_scene)