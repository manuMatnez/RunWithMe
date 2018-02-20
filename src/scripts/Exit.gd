extends Node2D

#
# Exit
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var exitBtn

func _ready():
	exitBtn = get_node("ExitButton")
	exitBtn.connect("pressed",self,"_on_ExitBtn_pressed")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")
	
	## SETTING LANGUAGE ##
	exitBtn.get_node("Exit").set_text(tr("MENU_EXIT"))

#Fix all the button positions
func _fixControls():
	set_pos(Vector2(get_viewport_rect().size.x, 0))

func _on_ExitBtn_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().quit()

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST && OS.get_name() == "Android"):
		get_tree().quit()
