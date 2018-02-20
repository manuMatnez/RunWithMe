extends "Hazzards.gd"

#
# RotatingFire
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var INITIAL_ROTATION = 0.0
var INCREMENT_ROTATION = 0.05

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	INITIAL_ROTATION += INCREMENT_ROTATION
	self.set_rot(INITIAL_ROTATION)