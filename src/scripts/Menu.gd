extends Node

#
# Menu
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var title
var buttons

var play
var options
var about
var howplay

var background
var image

func _ready():
	set_name(GlobalMusic.menu)
	
	buttons = get_node("Controls/Buttons")
	title = get_node("Controls/Main")
	
	if (OS.get_name() != "iOS"): #Apple doesn't like a close button
		var exitBtn = preload("res://scenes/Exit.tscn").instance()
		get_node("Controls").add_child(exitBtn)
	
	howplay = get_node("Controls/HowPlay")
	howplay.get_node("HowPlayButton").connect("pressed",self,"_on_HowPlayButton_button_pressed")
	
	background = get_node("Controls/Background")
	image = background.get_node("Image")
	
	play = buttons.get_node("Play")
	play.connect("pressed",self,"_on_Play_button_pressed")
	
	options = buttons.get_node("Options")
	options.connect("pressed",self,"_on_Options_button_pressed")
	
	about = buttons.get_node("About")
	about.connect("pressed",self,"_on_About_button_pressed")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")
	
	if (GlobalMusic.get_stream() != GlobalMusic.menu_song):
		GlobalMusic.set_stream(GlobalMusic.menu_song)
		GlobalMusic.play()
	
	## SETTING LANGUAGE ##
	get_node("Controls/Buttons/Play/PlayLbl").set_text(tr("MENU_PLAY"))
	get_node("Controls/Buttons/Options/OptionsLbl").set_text(tr("MENU_OPTIONS"))
	get_node("Controls/Buttons/About/AboutLbl").set_text(tr("MENU_ABOUT"))
	get_node("Controls/HowPlay/HowPlayButton/HowPlayLabel").set_text(tr("MENU_HOWPLAY"))

#Fix all the button positions
func _fixControls():
	image.set_size(get_viewport_rect().size)
	
	title.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	buttons.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	howplay.set_pos(Vector2(0, 0))
	background.set_pos(Vector2(0,0))

func _on_Play_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(Global.levels_scene)

func _on_Options_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(Global.options_scene)

func _on_About_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(Global.about_scene)

func _on_HowPlayButton_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(Global.howtoplay_scene)
