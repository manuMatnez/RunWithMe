extends Node2D

#
# HowToPlay
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var title
var background
var image

var text

func _ready():
	
	title = get_node("Controls/Main")
	
	background = get_node("Controls/Background")
	image = background.get_node("Image")
	
	text = get_node("Controls/Text")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")

	## SETTING LANGUAGE ##
	get_node("Controls/Main/Title").set_text(tr("MENU_HOWPLAY"))
	get_node("Controls/Text/Heart/Hearts").set_text(tr("HOWPLAY_HEART"))
	get_node("Controls/Text/Coin/Coins").set_text(tr("HOWPLAY_COIN"))
	get_node("Controls/Text/Gobo/Monster").set_text(tr("HOWPLAY_GOBO"))
	get_node("Controls/Text/Killables/Enemies").set_text(tr("HOWPLAY_KILLABLES"))

#Fix all the button positions
func _fixControls():
	image.set_size(get_viewport_rect().size)

	title.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	background.set_pos(Vector2(0,0))
	text.set_pos(Vector2(get_viewport_rect().size.x/2,0))
