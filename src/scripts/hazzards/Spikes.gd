extends Area2D

#
# Spikes
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

func _ready():
	self.connect("body_enter",self,"_on_Spikes_body_enter")

func _on_Spikes_body_enter(body):
	if (body extends Global.player_script):
		body.hearts = 0
