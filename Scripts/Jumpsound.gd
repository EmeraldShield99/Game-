extends Node2D

onready var sound = $AudioStreamPlayer

func _ready():
	if Input.is_action_just_pressed("Move_Jump"):
		$Sound.play()
	
	
	
	pass
