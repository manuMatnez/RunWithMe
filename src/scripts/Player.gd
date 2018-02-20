extends RigidBody2D

#
# Player
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

#Solved Bugs:
	#Climbing down 05/05/17
	#Player stuck after accurate jump 05/05/17
	#Player can't jump after previous accurate jump 18/05/17
	#Player jump deaccel bugfix 12/05/17

#Player Constants
var WALK_ACCEL = 1200.0
var WALK_DEACCEL = 1600.0
var WALK_MAX_VELOCITY = 500.0
var AIR_ACCEL = 1200.0
var AIR_DEACCEL = 800.0
var JUMP_VELOCITY = 700.0
var STOP_JUMP_FORCE = 1200.0
var MAX_FLOOR_AIRBORNE_TIME = 0.15
const FLOOR_NORMAL = Vector2(0,-1)

#Time on Air
var airborne_time = 1e20

#Floor velocity
var floor_h_velocity = 0.0

var jumping = false
var stopping_jump = false

#Prevent multiple sounds on grounded and jump
var prev_grounded = false
var prev_jump = false

#Current animation
var anim
var anim_blend
var anim_speed

# Textures
var normal_texture
var normal_head_texture
var head_sprite
var hit_texture
var hit_head_texture

#Player CollisionShape
var shape
#Player CollisionPolygon
var shape_polygon
var feet
#Player Sprite
var sprite
var spriteScale
#Player AnimationPlayer
var animation

#Flip status
var flip = false

## SCREEN CONTROLS ##
#Left Buttons (Left and Right)
var leftCtrl
#Right Button (Jump)
var rightCtrl
#Life and Coins
var status
var settingsBtn
#Mute button
var mute

## POPUPS ##
var prev_popup = false
#Pause
var pause_popup
var menu_pause #Button
var back_pause #Button
var retry_pause #Button
#Dead
var dead_popup
var menu_dead #Button
var retry_dead #Button
#Won
var won_popup
var continue_won #Button
var retry_won #Button
var menu_won #Button
#Completed
var completed_popup
var credits_completed #Button
var retry_completed #Button

# Camera Node and limits
var camera

#Coins Label (Money)
var coins
#Coins Quantity
var money = 0
#Max Coins Quantity
var max_money = 10
#has Player won?
var won = false

#Lifes Label (Hearts)
var lifes
#Lifes Quantity
var hearts = 3

#Player is dead?
var dead = false

#Player sounds
var sample

#Game Media Volume
var musicVol
var soundVol

#Timer
var timer
var timeLabel
var timeElapsed = 0

#Player damaged timeOut
var hitByEnemyTimer

# Current Level
var levelPos
var last

#Oncreate
func _ready():
	set_bounce(0.0)#Player Jump Restitution
	set_weight(80.0)#Player Weight
	set_use_custom_integrator(true)#Use Custom Physics
	set_mode(2)#Character Mode without rotation
	set_gravity_scale(10.0)#Gravity in Pixels
	set_max_contacts_reported(3)#Max contacts
	
	shape = get_node("Shape")
	shape_polygon = get_node("ShapePolygon")
	
	feet = get_node("Feet")#Because of jump animation and climb down bugs (must be (0,100))
	feet.set_cast_to(Vector2(0,100)) #Overriding the Scene Cast_To
	feet.add_exception(self)

	sprite = get_node("Sprite")
	spriteScale = sprite.get_scale()
	head_sprite = get_node("Controls/Status/Head")
	
	camera = get_node("Camera")
	
	normal_texture = sprite.get_texture()
	hit_texture = preload("res://assets/player/PlayerHit.png")
	
	normal_head_texture = head_sprite.get_texture()
	hit_head_texture = preload("res://assets/player/PlayerHeadHit.png")
	
	animation = get_node("Animation")

	leftCtrl = get_node("Controls/LeftCtrl")
	
	rightCtrl = get_node("Controls/RightCtrl")
	
	status = get_node("Controls/Status")
	
	mute = get_node("Controls/Mute")
	
	pause_popup = get_node("Controls/Pause")
	
	dead_popup = get_node("Controls/Dead")
	
	won_popup = get_node("Controls/Won")
	
	completed_popup = get_node("Controls/Completed")
	
	timer = get_node("Controls/Timer")
	
	timeLabel = timer.get_node("Time")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")
	
	musicVol = pause_popup.get_node("MusicVol")
	musicVol.connect("value_changed",self,"_on_MusicVol_value_changed")
	
	soundVol = pause_popup.get_node("SoundVol")
	soundVol.connect("value_changed",self,"_on_SoundVol_value_changed")
	
	coins = status.get_node("Coins/Money")
	coins.set_text(str(money))
	
	lifes = status.get_node("Lifes/Hearts")
	lifes.set_text(str(hearts))
	
	sample = get_node("Sample")
	
	hitByEnemyTimer = get_node("HitByEnemyTimer")
	hitByEnemyTimer.connect("timeout", self, "_on_Hit_by_enemy_Timer_timeout")
	
	settingsBtn = status.get_node("Settings")
	settingsBtn.connect("pressed",self,"_on_Settings_button_pressed")
	
	menu_pause = pause_popup.get_node("Menu")
	menu_pause.connect("pressed",self,"_on_Menu_button_pressed")
	
	back_pause = pause_popup.get_node("Back")
	back_pause.connect("pressed",self,"_on_Back_button_pressed")
	
	retry_pause = pause_popup.get_node("Retry")
	retry_pause.connect("pressed",self,"_on_Retry_button_pressed")
	
	menu_dead = dead_popup.get_node("Menu")
	menu_dead.connect("pressed",self,"_on_Menu_button_pressed")
	
	retry_dead = dead_popup.get_node("Retry")
	retry_dead.connect("pressed",self,"_on_Retry_button_pressed")
	
	continue_won = won_popup.get_node("Continue")
	continue_won.connect("pressed",self,"_on_Continue_button_pressed")
	
	retry_won = won_popup.get_node("Retry")
	retry_won.connect("pressed",self,"_on_Retry_button_pressed")
	
	menu_won = won_popup.get_node("Menu")
	menu_won.connect("pressed",self,"_on_Menu_button_pressed")
	
	credits_completed = completed_popup.get_node("Credits")
	credits_completed.connect("pressed",self,"_on_Continue_button_pressed")
	
	retry_completed = completed_popup.get_node("Retry")
	retry_completed.connect("pressed",self,"_on_Retry_button_pressed")

	## SETTING LANGUAGE ##
	pause_popup.get_node("PauseLabel").set_text(tr("PLAYER_PAUSE"))
	menu_pause.get_node("MenuLabel").set_text(tr("PLAYER_MENU"))
	back_pause.get_node("BackGame").set_text(tr("PLAYER_PAUSE_RESUME"))
	retry_pause.get_node("RetryGame").set_text(tr("PLAYER_DEAD_PAUSE_WON_RETRY"))
	
	musicVol.get_node("MusicLabel").set_text(tr("OPTIONS_MUSIC"))
	soundVol.get_node("SoundLabel").set_text(tr("OPTIONS_SOUND"))
	
	dead_popup.get_node("YouDied").set_text(tr("PLAYER_DEAD"))
	menu_dead.get_node("MenuLabel").set_text(tr("PLAYER_MENU"))
	retry_dead.get_node("RetryGame").set_text(tr("PLAYER_DEAD_PAUSE_WON_RETRY"))
	
	won_popup.get_node("YouWon").set_text(tr("PLAYER_WON"))
	continue_won.get_node("ContinueGame").set_text(tr("PLAYER_WON_CONTINUE"))
	retry_won.get_node("RetryGame").set_text(tr("PLAYER_DEAD_PAUSE_WON_RETRY"))
	menu_won.get_node("MenuLabel").set_text(tr("PLAYER_MENU"))
	
	completed_popup.get_node("YouCompleted").set_text(tr("CONGRATULATIONS"))
	credits_completed.get_node("CreditsGame").set_text(tr("MENU_ABOUT_CREDITS"))
	retry_completed.get_node("RetryGame").set_text(tr("PLAYER_DEAD_PAUSE_WON_RETRY"))

#Fix all the button positions
func _fixControls():
	leftCtrl.set_pos(Vector2(0, get_viewport_rect().size.y))
	rightCtrl.set_pos(get_viewport_rect().size)
	
	status.set_pos(Vector2(0,0))
	
	pause_popup.set_pos(Vector2(get_viewport_rect().size.x/2 - pause_popup.get_size().x/2, get_viewport_rect().size.y/2 - pause_popup.get_size().y/2))
	dead_popup.set_pos(Vector2(get_viewport_rect().size.x/2 - dead_popup.get_size().x/2, get_viewport_rect().size.y/2 - dead_popup.get_size().y/2))
	won_popup.set_pos(Vector2(get_viewport_rect().size.x/2 - won_popup.get_size().x/2, get_viewport_rect().size.y/2 - won_popup.get_size().y/2))
	completed_popup.set_pos(Vector2(get_viewport_rect().size.x/2 - completed_popup.get_size().x/2, get_viewport_rect().size.y/2 - completed_popup.get_size().y/2))
	
	timer.set_pos(Vector2(get_viewport_rect().size.x/2, -get_viewport_rect().size.y))

func _integrate_forces(state):
	lifes.set_text(str(hearts))
	coins.set_text(str(money))
	
	if ((hearts == 0 || money == max_money) && !dead && !won):
		if (hearts == 0):
			dead = true #Player is dead
		elif (money == max_money):
			won = true
		shape.free() #Removes CollisionShape from Player
		shape_polygon.free() #Removes CollisionPolygon from Player
		set_gravity_scale(0) #Removes the gravity
		set_linear_velocity(Vector2()) #Prevents Falling
	
	if (!dead && !won):
		_timeCount()
		_player_movement(state)
	elif (won && !dead):
		_player_won(state)
	elif (!won && dead):
		_player_dead(state)

func _player_movement(state):
	var linear_vel = state.get_linear_velocity()
	var step = state.get_step()
	
	var new_anim = anim
	
	#Controls
	var move_left = Input.is_action_pressed("leftBtn")
	var move_right = Input.is_action_pressed("rightBtn")
	var jump = Input.is_action_pressed("jumpBtn")
	
	#Deapply prev floor velocity
	linear_vel.x -= floor_h_velocity
	floor_h_velocity = 0.0
	
	#Find the floor (a contact with upwards facing collision normal)
	var found_floor = false
	var floor_index = -1
	
	if (state.get_contact_count() > 0):
		for x in range(state.get_contact_count()):
			var normal = state.get_contact_local_normal(x)
			if (normal.dot(FLOOR_NORMAL) == 1):
				found_floor = true
				floor_index = 0
				break
	
	if (found_floor && !prev_grounded):
		prev_grounded = true
		sample.play("walkingPlayer1")
	
	if (found_floor):
		airborne_time = 0.0
	else:
		airborne_time += step #Time it spent in the air
	
	var on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	
	if (move_left && !move_right && !flip):
		sprite.set_scale(spriteScale*Vector2(-1,1))
		flip = true
	if (move_right && !move_left && flip):
		sprite.set_scale(spriteScale*Vector2(1,1))
		flip = false

	#Process jump
	if (jumping && !feet.is_colliding()):#part1 prevents a Bug (Player sometimes cant jump)
		if (linear_vel.y > 0):
			#Set off the jumping flag if going down
			jumping = false
		elif (!jump):
			stopping_jump = true
		if (stopping_jump):
			linear_vel.y += STOP_JUMP_FORCE*step
	elif (jumping && feet.is_colliding() && linear_vel.y == 0):#part2 prevents a Bug (Player sometimes cant jump)
		jumping = false
	
	if (on_floor):
		#Process logic when character is on floor
		if (move_left && !move_right):
			if (linear_vel.x > -WALK_MAX_VELOCITY):
				linear_vel.x -= WALK_ACCEL*step
		elif (move_right && !move_left):
			if (linear_vel.x < WALK_MAX_VELOCITY):
				linear_vel.x += WALK_ACCEL*step
		else:
			var abs_linear_vel_x = abs(linear_vel.x)
			abs_linear_vel_x -= WALK_DEACCEL*step
			if (abs_linear_vel_x < 0):
				abs_linear_vel_x = 0
			linear_vel.x = sign(linear_vel.x)*abs_linear_vel_x
		
		#Check jump
		if (!jumping && jump):
			linear_vel.y = -JUMP_VELOCITY
			jumping = true
			stopping_jump = false
			if (!prev_jump):
				prev_jump = true
				sample.play("jump")
			
		if (jumping && !feet.is_colliding()):#!feet.is_colliding() prevents a Bug (Player sometimes can walk on the floor with jump anim)
			new_anim = "jump"
		elif (abs(linear_vel.x) < 0.1):
			new_anim = "idle"
			anim_speed = 1.0
			anim_blend = 0.2
		else:
			new_anim = "walk"
			anim_speed = 1.5
			anim_blend = 0.2
	else:
		prev_grounded = false
		prev_jump = false
		#Process logic when the character is in the air
		if (move_left && !move_right):
			if (linear_vel.x > -WALK_MAX_VELOCITY):
				linear_vel.x -= AIR_ACCEL*step
		elif (move_right && !move_left):
			if (linear_vel.x < WALK_MAX_VELOCITY):
				linear_vel.x += AIR_ACCEL*step
		else:
			var abs_linear_vel_x = abs(linear_vel.x)
			abs_linear_vel_x -= AIR_DEACCEL*step
			if (abs_linear_vel_x < 0):
				abs_linear_vel_x = 0
			linear_vel.x = sign(linear_vel.x)*abs_linear_vel_x
		
		if (linear_vel.y < 0):
			new_anim = "jump"
			anim_speed = 1.0
			anim_blend = 0.2
		else:
			if(!feet.is_colliding()):#Prevents the use of fall animation climbing down
				new_anim = "fall"
				anim_speed = 1.0
				anim_blend = 0.2
	
	#Change animation
	if (new_anim != anim):
		anim = new_anim
		animation.play(anim,anim_blend,anim_speed)
	
	#Apply floor velocity
	if (found_floor):
		floor_h_velocity = state.get_contact_collider_velocity_at_pos(floor_index).x
		linear_vel.x += floor_h_velocity
	
	#Finally, apply gravity and set back the linear velocity
	linear_vel += state.get_total_gravity()*step
	state.set_linear_velocity(linear_vel)

func _player_dead(state):
	if (anim != "dead"):
		anim = "dead" #Stop camera current
		anim_speed = 1.0
		anim_blend = 0.2
		GlobalMusic.set_paused(true) #Pause Music
		animation.play(anim,anim_blend,anim_speed)
	state.set_linear_velocity(Vector2(0, -100)) #Player gonna ceilling
	if (anim == "dead" && !animation.is_playing()):
		get_tree().set_pause(true)
		prev_popup = true
		dead_popup.popup()

func _player_won(state):
	if (anim != "won"):
		anim = "won" #Stop camera current
		anim_speed = 1.0
		anim_blend = 0.2
		GlobalMusic.set_paused(true) #Pause Music
		animation.play(anim,anim_blend,anim_speed)
		levelPos = get_tree().get_current_scene().get_name()
		last = int(levelPos.substr(1,1))
		
		var timePosArray
		if(int(levelPos) < 21):
			timePosArray = last-1
		elif(int(levelPos) < 31):
			timePosArray = 5+last
		else:
			timePosArray = 11+last
		
		if (Global.compare_Strings_Time(timeLabel.get_text(),Global.levelTimes[timePosArray]) || Global.levelTimes[timePosArray] == "00:00:00"):
			Global.levelTimes[timePosArray] = timeLabel.get_text()
			#print(Global.levelTimes)
			Global.save_game("gameData")
		
	if (anim == "won" && !animation.is_playing()):
		get_tree().set_pause(true)
		prev_popup = true
		if (levelPos == "36"):
			completed_popup.popup()
		else:
			won_popup.popup()

func hit_by_enemy():
	hitByEnemyTimer.start()
	sample.play("playerDamaged")
	sprite.set_texture(hit_texture)
	head_sprite.set_texture(hit_head_texture)
	if (hearts != 0):
		hearts -= 1

func _on_Hit_by_enemy_Timer_timeout():
	sprite.set_texture(normal_texture)
	head_sprite.set_texture(normal_head_texture)

func _timeCount():
	timeElapsed += 1
	var minutes = timeElapsed / 3600
	var seconds = (timeElapsed / 60) % 60
	var miliseconds = int (timeElapsed / 0.6) % 100
	var counter = "%02d:%02d:%02d" % [minutes, seconds, miliseconds]
	timeLabel.set_text(str(counter))

func settings():
	musicVol.set_value(Global.musicVolume)
	soundVol.set_value(Global.soundVolume)
	prev_popup = true
	pause_popup.popup()
	get_tree().set_pause(true)

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST && OS.get_name() == "Android" && !prev_popup):
		settings()

func _on_Settings_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	settings()

func _on_Menu_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(Global.menu_scene)
	get_tree().set_pause(false)
	GlobalMusic.set_paused(false)

func _on_Back_button_pressed():
	GlobalSample.pressBtn("backPressed")
	get_tree().set_pause(false)
	prev_popup = false
	pause_popup.hide()

func _on_MusicVol_value_changed(value):
	if (Global.musicVolume != musicVol.get_value()):
		Global.musicVolume = musicVol.get_value()
		_mute()

func _on_SoundVol_value_changed(value):
	if (Global.soundVolume != soundVol.get_value()):
		Global.soundVolume = soundVol.get_value()
		sample.play("jump")
		_mute()

func _mute():
	AudioServer.set_stream_global_volume_scale(musicVol.get_value())
	AudioServer.set_fx_global_volume_scale(soundVol.get_value())
	
	if(Global.musicVolume == 0 && Global.soundVolume == 0):
		Global.mute = true
		mute.get_node("MuteBtn").set_normal_texture(mute.mute)
	else:
		Global.mute = false
		mute.get_node("MuteBtn").set_normal_texture(mute.unmute)
	Global.save_gameVol("gameVol")

func _on_Retry_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	get_tree().change_scene_to(load(get_tree().get_current_scene().get_filename()))
	get_tree().set_pause(false)
	GlobalMusic.set_paused(false)
	GlobalMusic.play(0)

func _on_Continue_button_pressed():
	GlobalSample.pressBtn("buttonPressed")
	if(int(levelPos) == 36):
		get_tree().change_scene_to(Global.credits_scene)
	elif(last == 6):
		get_tree().change_scene_to(load("res://scenes/stages/Stage"+str(int(levelPos)+5)+".tscn"))
	else:
		get_tree().change_scene_to(load("res://scenes/stages/Stage"+str(int(levelPos)+1)+".tscn"))
	get_tree().set_pause(false)
	GlobalMusic.set_paused(false)
	GlobalMusic.play(0)
