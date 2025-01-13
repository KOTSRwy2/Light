class_name PlayerLight extends PointLight2D

@onready var animation_player : AnimationPlayer = $"../AnimationPlayer"


func _ready():
	animation_player.play( "flash" )
	pass
