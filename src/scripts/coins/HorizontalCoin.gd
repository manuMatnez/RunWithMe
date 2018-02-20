extends "Coin.gd"

#
# HorizontalCoin
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

# Member variables
var min_pos
var cur_pos
var cur_pos_mov
var max_pos
var SUMATORI_MAX_POS = 400.0
var go_right

func _ready():
	set_process(true)
	cur_pos = self.get_pos()
	cur_pos_mov = cur_pos
	min_pos = cur_pos.x
	go_right = true
	
func _process(delta):
	if (!taken):
		if (go_right):
			cur_pos_mov.x += 4
		else:
			cur_pos_mov.x -= 4
		if (cur_pos_mov.x >= cur_pos.x + SUMATORI_MAX_POS):
			go_right = false
		elif (cur_pos_mov.x <= min_pos):
			go_right = true
		set_pos(cur_pos_mov)