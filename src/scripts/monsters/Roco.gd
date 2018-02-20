extends RigidBody2D

#
# Roco
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

#Roco Constants
var WALK_SPEED = 250.0
const FLOOR_NORMAL = Vector2(0,-1)

var shooting = false
var shoot_time = 1e20

var rocoShoot
var rocoShooter
var rocoShootMargin = Vector2(100,0)
var shoot = false

#Roco movement direction
var direction = -1

#Roco Current Animation
var anim
var anim_blend
var anim_speed

#Roco CollisionShape
var shape
var feet
#Roco Sprite
var sprite
var spriteScale
#Roco AnimationPlayer
var animation

var attack_area

#Flip status
var flip = false

#Roco RayCast 1
var detect_left
#Roco RayCast 2
var detect_right

# Textures
var normal_texture
var hit_texture

#Roco sounds
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
	
	attack_area = get_node("AttackArea")
	attack_area.connect("body_enter",self,"_roco_attack_start")
	attack_area.connect("body_exit",self,"_roco_attack_stop")
	
	rocoShoot = preload("res://scenes/monsters/rocoShoot/RocoShoot.tscn")
	rocoShooter = get_node("RocoShooter")
	
	normal_texture = sprite.get_texture()
	hit_texture = preload("res://assets/monsters/roco/RocoHit.png")
	
	animation = get_node("Animation")
	shape = get_node("Shape")
	feet = get_node("Feet")
	
	detect_left = get_node("Detect_left")
	detect_right = get_node("Detect_right")
	
	detect_left.add_exception(self)
	detect_right.add_exception(self)
	
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
		var linear_vel = state.get_linear_velocity()
		var step = state.get_step()
		
		new_anim = "idle"
		anim_speed = 1.0
		anim_blend = 0.2
		
		var wall_side = 0.0
		
		if (state.get_contact_count() > 0):
			for i in range(state.get_contact_count()):
				var c_player = state.get_contact_collider_object(i)
				var normal = state.get_contact_local_normal(i)
				if (c_player):
					if (c_player extends Global.player_script && hitTimer.get_time_left() < 1.5 && c_player.has_method("hit_by_enemy")):
						if (normal.dot(FLOOR_NORMAL) == -1):
							shape.queue_free()
							feet.queue_free()
							dead = true
							break
						else:
							if (!dead):
								c_player.call("hit_by_enemy")
								sample.play("enemyHit")
								sprite.set_texture(hit_texture)
								hitTimer.start()
								break
				if (normal.x > 0.9):
					wall_side = 1.0
				elif (normal.x < -0.9):
					wall_side = -1.0
		
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
		
		if (wall_side != 0 && wall_side != direction):
			direction = -direction
		if (direction < 0 && !detect_left.is_colliding() && detect_right.is_colliding()):
			direction = -direction
		elif (direction > 0 && !detect_right.is_colliding() && detect_left.is_colliding()):
			direction = -direction
			
		linear_vel.x = direction*WALK_SPEED
		
		if (direction > 0 && !flip):
			sprite.set_scale(spriteScale*Vector2(-1,1))
			attack_area.set_scale(Vector2(-1,1))
			flip = true
		elif (direction < 0 && flip):
			sprite.set_scale(spriteScale*Vector2(1,1))
			attack_area.set_scale(Vector2(1,1))
			attack_area
			flip = false
		
		state.set_linear_velocity(linear_vel)
	
	if(anim != new_anim):
		anim = new_anim
		animation.play(anim,anim_blend,anim_speed)
	
	shooting = shoot
		
func _on_Hit_Timer_timeout():
	sprite.set_texture(normal_texture)

func _roco_attack_start(body):
	if(body extends Global.player_script):
		shoot = true
		shootTimer.start()

func _roco_attack_stop(body):
	if(body extends Global.player_script):
		shoot = false
		shootTimer.stop()

func _on_Shot_Timer_timeout():
	shooting = false