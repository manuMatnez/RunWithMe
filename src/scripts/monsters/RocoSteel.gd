extends RigidBody2D

#
# RocoSteel
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

#RocoSteel Constants
const FLOOR_NORMAL = Vector2(0,-1)

var shooting = false
var shoot_time = 1e20

var rocoShoot
var rocoShooter
var rocoShootMargin = Vector2(100,0)
var shoot = false

#RocoSteel Current Animation
var anim
var anim_blend
var anim_speed

#RocoSteel CollisionShape
var shape
#RocoSteel Sprite
var sprite
var spriteScale
#RocoSteel AnimationPlayer
var animation

var attack_area_left
var attack_area_right

#RocoSteel dir
var direction = -1

#Flip status
var flip = false

# Textures
var normal_texture
var hit_texture

#RocoSteel sounds
var sample

#Player damage timeOut
var hitTimer

#Shoot timeOut
var shootTimer

var dead = false

func _ready():
	set_bounce(0.0)#Player Jump Restitution
	set_weight(3000.0)#Player Weight
	set_mode(2)#Character Mode without rotation
	set_gravity_scale(10.0)#Gravity in Pixels
	set_max_contacts_reported(4)#Max contacts
	
	sprite = get_node("Sprite")
	spriteScale = sprite.get_scale()
	
	attack_area_left = get_node("AttackAreaLeft")
	attack_area_left.connect("body_enter",self,"_roco_attack_left_start")
	attack_area_left.connect("body_exit",self,"_roco_attack_stop")
	
	attack_area_right = get_node("AttackAreaRight")
	attack_area_right.connect("body_enter",self,"_roco_attack_right_start")
	attack_area_right.connect("body_exit",self,"_roco_attack_stop")
	
	rocoShoot = preload("res://scenes/monsters/rocoShoot/RocoShoot.tscn")
	rocoShooter = get_node("RocoShooter")
	
	normal_texture = sprite.get_texture()
	hit_texture = preload("res://assets/monsters/roco/RocoSteelHit.png")
	
	animation = get_node("Animation")
	shape = get_node("Shape")
	
	sample = get_node("Sample")
	
	hitTimer = get_node("HitTimer")
	hitTimer.connect("timeout", self, "_on_Hit_Timer_timeout")
	
	shootTimer = get_node("ShootTimer")
	shootTimer.connect("timeout", self, "_on_Shot_Timer_timeout")

func _integrate_forces(state):
	var new_anim
	if(dead):
		new_anim = "dead"
		anim_speed = 1.5
		anim_blend = 0.2
	else:
		var step = state.get_step()
		state.set_linear_velocity(Vector2(0,0))
		
		new_anim = "idle"
		anim_speed = 1.0
		anim_blend = 0.2
		
		if (state.get_contact_count() > 0):
			for i in range(state.get_contact_count()):
				var c_player = state.get_contact_collider_object(i)
				var normal = state.get_contact_local_normal(i)
				if (c_player):
					if (c_player extends Global.player_script && hitTimer.get_time_left() < 1.5 && c_player.has_method("hit_by_enemy")):
						if (normal.dot(FLOOR_NORMAL) == -1):
							shape.queue_free()
							dead = true
							break
						else:
							if (!dead):
								c_player.call("hit_by_enemy")
								sample.play("enemyHit")
								sprite.set_texture(hit_texture)
								hitTimer.start()
								break
		
		if (shoot && !shooting):
			shoot_time = 0
			var shoot = rocoShoot.instance()
			var pos = get_pos() + direction*(rocoShootMargin) + rocoShooter.get_pos()*Vector2(direction, 1.0)
			
			shoot.set_pos(pos)
			get_parent().add_child(shoot)
			
			shoot.set_linear_velocity(Vector2(800.0*direction, -80))
			
			var shoot_scale = shoot.get_node("Sprite").get_scale()
			if (shoot.get_linear_velocity().x > 0):
				shoot.get_node("Sprite").set_scale(Vector2(-shoot_scale.x, shoot_scale.y))
			else:
				shoot.get_node("Sprite").set_scale(Vector2(shoot_scale.x, shoot_scale.y))
			
			sample.play("rocoShoot")
			PS2D.body_add_collision_exception(shoot.get_rid(), get_rid()) # Make bullet and this not collide
		else:
			shoot_time += step
		
		if (direction > 0 && !flip):
			sprite.set_scale(spriteScale*Vector2(-1,1))
			flip = true
		elif (direction < 0 && flip):
			sprite.set_scale(spriteScale*Vector2(1,1))
			flip = false
	
	if(anim != new_anim):
		anim = new_anim
		animation.play(anim,anim_blend,anim_speed)
	
	shooting = shoot

func _on_Hit_Timer_timeout():
	sprite.set_texture(normal_texture)

func _roco_attack_left_start(body):
	if(body extends Global.player_script):
		direction = -1
		shoot = true
		shootTimer.start()

func _roco_attack_right_start(body):
	if(body extends Global.player_script):
		direction = 1
		shoot = true
		shootTimer.start()

func _roco_attack_stop(body):
	if(body extends Global.player_script):
		shoot = false
		shootTimer.stop()

func _on_Shot_Timer_timeout():
	shooting = false