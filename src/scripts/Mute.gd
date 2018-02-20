extends Node2D

#
# Mute
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var muteBtn

var unmute
var unmutePressed

var mute
var mutePressed

func _ready():
	muteBtn = get_node("MuteBtn")
	
	mute = muteBtn.get_normal_texture()
	mutePressed = muteBtn.get_pressed_texture()
	
	unmute = preload("res://assets/mute/unmute.png")
	unmutePressed = preload("res://assets/mute/unmutePressed.png")
	
	muteBtn.connect("pressed",self,"_on_MuteButton_pressed")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")
	
	if(Global.mute):
		muteBtn.set_normal_texture(mute)
		muteBtn.set_pressed_texture(mutePressed)
	else:
		muteBtn.set_normal_texture(unmute)
		muteBtn.set_pressed_texture(unmutePressed)

#Fix all the button positions
func _fixControls():
	set_pos(Vector2(get_viewport_rect().size.x, 0))

func _on_MuteButton_pressed():
	# if button is mute, change to unmute
	if(muteBtn.get_normal_texture() == mute):
		GlobalSample.pressBtn("buttonPressed")
		muteBtn.set_normal_texture(unmute)
		muteBtn.set_pressed_texture(unmutePressed)
		
		if(Global.musicVolume == 0 && Global.soundVolume == 0):
			Global.musicVolume = 0.5
			Global.soundVolume = 0.5
		
		AudioServer.set_fx_global_volume_scale(Global.soundVolume)
		AudioServer.set_stream_global_volume_scale(Global.musicVolume)
		Global.mute = false
	else:
		muteBtn.set_normal_texture(mute)
		muteBtn.set_pressed_texture(mutePressed)
		AudioServer.set_fx_global_volume_scale(0)
		AudioServer.set_stream_global_volume_scale(0)
		Global.mute = true
	
	Global.save_gameVol("gameVol")
