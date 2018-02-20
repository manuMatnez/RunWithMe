extends "Heart.gd"

#
# VerticalHeart
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var min_pos
var cur_pos
var go_up
var SUMATORI_MAX_POS = 400.0

func _ready():
	set_fixed_process(true)
	cur_pos = self.get_pos()
	min_pos = cur_pos.y
	go_up = true
	
func _fixed_process(delta):
	if (!taken):
		if (go_up):
			cur_pos.y += 4.0
		else:
			cur_pos.y -= 4.0
		if (cur_pos.y >= min_pos + SUMATORI_MAX_POS):
			go_up = false
		elif (cur_pos.y <= min_pos):
			go_up = true
		set_pos(cur_pos)