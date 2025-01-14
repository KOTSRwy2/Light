class_name State_Idle extends State

@onready var walk : State = $"../walk"



## What happen when player enter the state
func Enter() ->void:
	player.UpdateAnimation("idle")
	pass


## What happen when player exits the state
func Exits()->void:
	pass



## What happen during the _process update to this state
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

## What happen during the physics_process update to this state
func Physics(_delta: float) -> State:
	return null

## What happen with input events in this state
func HandleInput(_event: InputEvent) -> State:
	#if _event.is_action_pressed("attack"):
		#return attack
	if _event.is_action_pressed("Interact"):
		PlayerManager.interact_pressed.emit()
	return null
