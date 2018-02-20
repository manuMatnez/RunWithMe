extends Node2D

#
# About
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var title
var info
var credits

var creditBtn

var background
var image

func _ready():
	set_name(GlobalMusic.menu)
	
	title = get_node("Controls/Main")
	info = get_node("Controls/Body")
	
	credits = get_node("Controls/Credits")
	creditBtn = credits.get_node("CreditsBtn")
	creditBtn.connect("button_up",self,"_show_credits_up")
	
	background = get_node("Controls/Background")
	image = background.get_node("Image")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls") 
	
	if (GlobalMusic.get_stream() != GlobalMusic.menu_song):
		GlobalMusic.set_stream(GlobalMusic.menu_song)
		GlobalMusic.play()
		
	## SETTING LANGUAGE ##
	get_node("Controls/Main/Title").set_text(tr("MENU_ABOUT"))
	get_node("Controls/Body/Version").set_text("RunWithMe v" + Global.GAME_VER + " - Godot Engine 2.1.3")
	get_node("Controls/Body/Authors").set_text(tr("ABOUT_AUTHORS") + " Sergi Marti, Manuel Martinez & Gerard Llado")
	get_node("Controls/Body/Release").set_text(tr("ABOUT_RELEASE") + " 16/06/2017")
	credits.get_node("CreditsBtn/CreditsLabel").set_text(tr("MENU_ABOUT_CREDITS"))

#Fix all the button positions
func _fixControls():
	image.set_size(get_viewport_rect().size)

	title.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	info.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	credits.set_pos(Vector2(0,0))
	background.set_pos(Vector2(0,0))

func _show_credits_up():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(Global.credits_scene)