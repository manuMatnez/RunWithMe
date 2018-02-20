extends StreamPlayer

#
# GlobalMusic
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

## SONGS ##
var menu_song
var stage1_song
var stage2_song
var stage3_song
var stage4_song
var stage5_song
var stage6_song

## MENU SCENES ##
var menu = "Menu"
var credits = "Credits"

## STAGES SCENES ##
#World1
var stage11 = "11"
var stage12 = "12"
var stage13 = "13"
var stage14 = "14"
var stage15 = "15"
var stage16 = "16"
#World2
var stage21 = "21"
var stage22 = "22"
var stage23 = "23"
var stage24 = "24"
var stage25 = "25"
var stage26 = "26"
#World3
var stage31 = "31"
var stage32 = "32"
var stage33 = "33"
var stage34 = "34"
var stage35 = "35"
var stage36 = "36"

func _ready():
	menu_song = preload("res://assets/music/Menu.ogg")
	menu_song.set_name("menu_stream")
	
	stage1_song = preload("res://assets/music/Stage1.ogg")
	stage1_song.set_name("stage1_stream")
	
	stage2_song = preload("res://assets/music/Stage2.ogg")
	stage2_song.set_name("stage2_stream")
	
	
	stage3_song = preload("res://assets/music/Stage3.ogg")
	stage3_song.set_name("stage3_stream")
	
	stage4_song = preload("res://assets/music/Stage4.ogg")
	stage4_song.set_name("stage4_stream")
	
	
	stage5_song = preload("res://assets/music/Stage5.ogg")
	stage5_song.set_name("stage5_stream")
	
	stage6_song = preload("res://assets/music/Stage6.ogg")
	stage6_song.set_name("stage6_stream")
	
	set_loop(true)