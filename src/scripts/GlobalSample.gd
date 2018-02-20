extends SamplePlayer

#
# GlobalSample
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var sample_lib
var button
var back

func _ready():
	sample_lib = SampleLibrary.new()
	button = preload("res://assets/sounds/buttonPressed.smp")
	back = preload("res://assets/sounds/backPressed.smp")
	
	set_sample_library(sample_lib)
	
	get_sample_library().add_sample("buttonPressed",button)
	get_sample_library().add_sample("backPressed",back)

func pressBtn(sound):
	play(sound)
