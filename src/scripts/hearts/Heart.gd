extends Area2D

#
# Heart
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var taken = false
var animation

func _on_Heart_body_enter(body):
	if (!taken && body extends Global.player_script && body.hearts < 3):
		taken = true
		animation.play("taken")
		body.hearts += 1

func _ready():
	animation = get_node("Animation")
	
	if (!self.is_connected("body_enter",self,"_on_Heart_body_enter")):
		self.connect("body_enter",self,"_on_Heart_body_enter")