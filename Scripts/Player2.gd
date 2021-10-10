extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 1
const MAX_SPEED = 50
const FRICTION = 15
const AIR_RESISTANCE = 1
const GRAVITY = 6
const JUMP_FORCE = 245


var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var x_input = Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left")
	
	if x_input != 0:
		animationPlayer.play("Run")
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Stand")
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("Move_Jump"):
			motion.y = -JUMP_FORCE
	else:
		animationPlayer.play("Jump")
		
		if Input.is_action_just_released("Move_Jump") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)




func _on_Level2Portal_body_entered(body):
	get_tree().change_scene("res://Scenes/World2.tscn")


func _on_FallZone2_body_entered(body):
	get_tree().change_scene("res://Scenes/World2.tscn")


func _on_Fallzone3_body_entered(body):
	get_tree().change_scene("res://Scenes/World2.tscn")


func _on_Fallzone4_body_entered(body):
	get_tree().change_scene("res://Scenes/World2.tscn")
