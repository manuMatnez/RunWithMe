extends Area2D

#
# Hazzards
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

func _ready():
	self.connect("body_enter",self,"_on_Hazzard_body_enter")
	
func _on_Hazzard_body_enter(body):
	if (body extends Global.player_script && body.has_method("hit_by_enemy")):
		body.call("hit_by_enemy")
