class_name State extends Node

## Store a reference to player that this state belones to
static var player : Player
static var state_machine : PlayerStateMachine
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

## What happen when we initialize this state/
func init() ->void:
	pass

## What happen when player enter the state
func Enter() ->void:
	pass


## What happen when player exits the state
func Exits()->void:
	pass



## What happen during the _process update to this state
func Process(_delta: float) -> State:
	return null

## What happen during the physics_process update to this state
func Physics(_delta: float) -> State:
	return null

## What happen with input events in this state
func HandleInput(_event: InputEvent) -> State:
	return null
