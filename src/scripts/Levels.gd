extends Node2D

#
# Levels
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var levels = Global.levelTimes
#times for different scores
var timeScores = [["00:30:00","00:45:00"],["00:40:00","00:50:00"],["00:43:00","00:55:00"],["00:47:00","01:00:00"],["00:28:00","00:38:00"],
				["01:45:00","02:00:00"],["00:28:00","00:37:00"],["00:36:00","00:50:00"],["01:10:00","01:25:00"],["00:34:00","00:46:00"],
				["00:34:00","00:47:00"],["00:35:00","00:48:00"],["00:42:00","00:55:00"],["00:42:00","00:55:00"],["01:00:00","01:10:00"],
				["00:30:00","00:45:00"],["00:55:00","01:10:00"],["01:15:00","01:30:00"]]
var bronze
var silver
var gold
var pressed
var default
var padlock_Locked
var padlock_Unlocked

var levlPos = 0
var avrgScore = 0
var maxWorld = 1

var background
var image

var worlds
var world1
var world2
var world3

func _ready():
	set_name(GlobalMusic.menu)
	
	background = get_node("Controls/Background")
	
	image = background.get_node("Image")
	
	worlds = get_node("Controls/Worlds")
	
	world1 = get_node("Controls/WorldLevels1")
	world2 = get_node("Controls/WorldLevels2")
	world3 = get_node("Controls/WorldLevels3")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")
	
	get_node("Controls/WorldLevels1/W1Level1").connect("pressed",self,"_on_Level_pressed",[11,0])
	get_node("Controls/WorldLevels1/W1Level2").connect("pressed",self,"_on_Level_pressed",[12,1])
	get_node("Controls/WorldLevels1/W1Level3").connect("pressed",self,"_on_Level_pressed",[13,2])
	get_node("Controls/WorldLevels1/W1Level4").connect("pressed",self,"_on_Level_pressed",[14,3])
	get_node("Controls/WorldLevels1/W1Level5").connect("pressed",self,"_on_Level_pressed",[15,4])
	get_node("Controls/WorldLevels1/W1Level6").connect("pressed",self,"_on_Level_pressed",[16,5])
	get_node("Controls/WorldLevels2/W2Level1").connect("pressed",self,"_on_Level_pressed",[21,6])
	get_node("Controls/WorldLevels2/W2Level2").connect("pressed",self,"_on_Level_pressed",[22,7])
	get_node("Controls/WorldLevels2/W2Level3").connect("pressed",self,"_on_Level_pressed",[23,8])
	get_node("Controls/WorldLevels2/W2Level4").connect("pressed",self,"_on_Level_pressed",[24,9])
	get_node("Controls/WorldLevels2/W2Level5").connect("pressed",self,"_on_Level_pressed",[25,10])
	get_node("Controls/WorldLevels2/W2Level6").connect("pressed",self,"_on_Level_pressed",[26,11])
	get_node("Controls/WorldLevels3/W3Level1").connect("pressed",self,"_on_Level_pressed",[31,12])
	get_node("Controls/WorldLevels3/W3Level2").connect("pressed",self,"_on_Level_pressed",[32,13])
	get_node("Controls/WorldLevels3/W3Level3").connect("pressed",self,"_on_Level_pressed",[33,14])
	get_node("Controls/WorldLevels3/W3Level4").connect("pressed",self,"_on_Level_pressed",[34,15])
	get_node("Controls/WorldLevels3/W3Level5").connect("pressed",self,"_on_Level_pressed",[35,16])
	get_node("Controls/WorldLevels3/W3Level6").connect("pressed",self,"_on_Level_pressed",[36,17])
	
	get_node("Controls/Worlds/World1").connect("pressed",self,"_on_World_pressed",[1])
	get_node("Controls/Worlds/World2").connect("pressed",self,"_on_World_pressed",[2])
	get_node("Controls/Worlds/World3").connect("pressed",self,"_on_World_pressed",[3])

	if (GlobalMusic.get_stream() != GlobalMusic.menu_song):
		GlobalMusic.set_stream(GlobalMusic.menu_song)
		GlobalMusic.play()
	
	padlock_Locked = preload("res://assets/levels/padlockLocked.png")
	padlock_Unlocked = preload("res://assets/levels/padlock_unlocked.png")
	pressed = preload("res://assets/levels/pressed.png")
	bronze = preload("res://assets/levels/bronze.png")
	silver = preload("res://assets/levels/silver.png")
	gold = preload("res://assets/levels/gold.png")
	default = preload("res://assets/levels/default.png")
	
	#print(levels)
	
	# loop for worlds
	for i in range(1,4):
		avrgScore = 0
		
		# loop for levels
		for z in range(1,7):
			#set saved time to label level
			get_node("Controls/WorldLevels"+str(i)+"/W"+str(i)+"Level"+str(z)+"/Score").set_text(str(levels[levlPos]))
			#print("world: ", i , " level: " , z ," score: " , z , " levels: " , levlPos)
			var img = get_node("Controls/WorldLevels"+str(i)+"/W"+str(i)+"Level"+str(z))
			var padlock = get_node("Controls/WorldLevels"+str(i)+"/W"+str(i)+"Level"+str(z)+"/Padlock")
			
			#change level button texture and padlock depend it's time score
			if(levels[levlPos] != "00:00:00"):
				img.set_normal_texture(bronze)
				img.set_pressed_texture(pressed)
				padlock.set_texture(padlock_Unlocked)
				avrgScore += 1
				if(Global.compare_Strings_Time(levels[levlPos], timeScores[levlPos][1])):
					img.set_normal_texture(silver)
					#print("silver")
					avrgScore += 10
					if(Global.compare_Strings_Time(levels[levlPos], timeScores[levlPos][0])):
						img.set_normal_texture(gold)
						#print("gold")
						avrgScore += 50
						
				#change world button texture depend it's time score 
				if((levlPos+1) % 6 == 0):
					#print("levlPos: " + str(levlPos) + " avrgScore: " + str(avrgScore))
					if(maxWorld < 3):
						maxWorld += 1
					#print("maxWorld: "+str(maxWorld))
					#print("avrg: "+str(avrgScore))
					if(avrgScore > 365):
						get_node("Controls/Worlds/World"+str(i)).set_normal_texture(gold)
					elif(avrgScore > 65):
						get_node("Controls/Worlds/World"+str(i)).set_normal_texture(silver)
					else:
						get_node("Controls/Worlds/World"+str(i)).set_normal_texture(bronze)

			# change padlock texture to unlocked in current level
			elif(levels[levlPos-1] != "00:00:00"):
				padlock.set_texture(padlock_Unlocked)
				img.set_pressed_texture(pressed)

			levlPos += 1

		#change world padlock texture to unlocked
		get_node("Controls/Worlds/World"+str(maxWorld)+"/Padlock").set_texture(padlock_Unlocked)
		get_node("Controls/Worlds/World"+str(maxWorld)).set_pressed_texture(pressed)
	
	# show actual world
	if (maxWorld != 1):
		image.set_texture(load("res://assets/levels/world"+str(maxWorld)+".png"))
	get_node("Controls/WorldLevels" + str(maxWorld)).show()
	
	## SETTING LANGUAGE ##
	get_node("Controls/Worlds/World1/WorldLbl").set_text(tr("MENU_LEVELS_WORLD")+" 1")
	get_node("Controls/Worlds/World2/WorldLbl").set_text(tr("MENU_LEVELS_WORLD")+" 2")
	get_node("Controls/Worlds/World3/WorldLbl").set_text(tr("MENU_LEVELS_WORLD")+" 3")

#Fix all the button positions
func _fixControls():
	image.set_size(get_viewport_rect().size)
	
	background.set_pos(Vector2(0,0))
	
	worlds.set_pos(Vector2(get_viewport_rect().size.x/2,0))
	
	world1.set_pos(Vector2(get_viewport_rect().size.x/2,0))
	world2.set_pos(Vector2(get_viewport_rect().size.x/2,0))
	world3.set_pos(Vector2(get_viewport_rect().size.x/2,0))

# change and play level scene
func _on_Level_pressed(stage, pos):
	
	GlobalSample.pressBtn("buttonPressed")
	
	if(pos > 0):
		if(str(levels[pos-1]) != "00:00:00"):
			get_tree().change_scene_to(load("res://scenes/stages/Stage"+str(stage)+".tscn"))
			#print("res://scenes/stages/Stage"+str(stage)+".tscn")
	else:
		get_tree().change_scene_to(load("res://scenes/stages/Stage"+str(stage)+".tscn"))
		#print("res://scenes/stages/Stage"+str(stage)+".tscn")

# change actual world scene
func _on_World_pressed(value):
	
	GlobalSample.pressBtn("buttonPressed")
	
	if(maxWorld >= value):
		#get_node("Controls/Worlds/World"+str(value)).get_normal_texture()
		for u in range(1,4):
			get_node("Controls/WorldLevels"+str(u)).hide()
			
		image.set_texture(load("res://assets/levels/world"+str(value)+".png"))
		get_node("Controls/WorldLevels"+str(value)).show()
		#print("Controls/WorldLevels"+str(value)+".show()")
