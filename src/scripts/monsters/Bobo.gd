extends RigidBody2D

#
# Bobo
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

#Bobo Constants
var WALK_SPEED = 200.0
const FLOOR_NORMAL = Vector2(0,-1)

#Bobo movement direction
var direction = -1

#Bobo Current Animation
var anim
var anim_blend
var anim_speed

#Bobo CollisionShape
var shape
var feet
#Bobo Sprite
var sprite
var spriteScale
#Bobo AnimationPlayer
var animation
#Flip status
var flip = false

#Bobo RayCast 1
var detect_left
#Bobo RayCast 2
var detect_right

# Textures
var normal_texture
var hit_texture

#Bobo sounds
var sample

#Player damage timeOut
var hitTimer

var dead = false

func _ready():
	set_bounce(0.0)#Player Jump Restitution
	set_weight(500.0)#Player Weight
	set_mode(2)#Character Mode without rotation
	set_gravity_scale(10.0)#Gravity in Pixels
	set_max_contacts_reported(4)#Max contacts
	
	sprite = get_node("Sprite")
	spriteScale = sprite.get_scale()
	
	normal_texture = sprite.get_texture()
	hit_texture = preload("res://assets/monsters/bobo/BoboHit.png")
	
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

func _integrate_forces(state):
	var new_anim
	if(dead):
		new_anim = "dead"
		anim_speed = 1.5
		anim_blend = 0.2
	else:
		var linear_vel = state.get_linear_velocity()
		
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
		
		if (wall_side != 0 && wall_side != direction):
			direction = -direction
		if (direction < 0 && !detect_left.is_colliding() && detect_right.is_colliding()):
			direction = -direction
		elif (direction > 0 && !detect_right.is_colliding() && detect_left.is_colliding()):
			direction = -direction
			
		linear_vel.x = direction*WALK_SPEED
		
		if (direction > 0 && !flip):
			sprite.set_scale(spriteScale*Vector2(-1,1))
			flip = true
		elif (direction < 0 && flip):
			sprite.set_scale(spriteScale*Vector2(1,1))
			flip = false
		
		state.set_linear_velocity(linear_vel)
	
	if(anim != new_anim):
		anim = new_anim
		animation.play(anim,anim_blend,anim_speed)
		
func _on_Hit_Timer_timeout():
	sprite.set_texture(normal_texture)