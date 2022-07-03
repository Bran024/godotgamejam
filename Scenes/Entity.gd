extends KinematicBody2D

class_name Entity

# Movement speed in pixels per second.
export var speed := 100
var move_direction := Vector2.ZERO

export var max_health := 10
var health := max_health

onready var hit_area = $HitArea
onready var hurt_area = $HurtArea
onready var sprite := $Sprite
onready var animation_tree := $AnimationTree
enum movement_states { IDLE, UP, DOWN, RIGHT, LEFT }

var debug_info := preload('res://Scenes/DebugInfo.tscn').instance()

func _ready() -> void:
	init_debug()
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if move_direction.length() < 0.1:
		animate_entity_movement(movement_states.IDLE)
		debug_info.log_text('Move', 'idle')
	elif move_direction.dot(Vector2.LEFT) > .6:
		animate_entity_movement(movement_states.LEFT)
		debug_info.log_text('Move', 'left')
	elif move_direction.dot(Vector2.RIGHT) > .6:
		animate_entity_movement(movement_states.RIGHT)
		debug_info.log_text('Move', 'right')
	elif move_direction.dot(Vector2.UP) > .5:
		animate_entity_movement(movement_states.UP)
		debug_info.log_text('Move', 'up')
	elif move_direction.dot(Vector2.DOWN) > .5:
		animate_entity_movement(movement_states.DOWN)
		debug_info.log_text('Move', 'down')


func animate_entity_movement(state: int):
	if state == movement_states.LEFT: # moving left is just moving right, but flipped
		sprite.flip_h = true;
		state = movement_states.RIGHT
	else:
		sprite.flip_h = false

	animation_tree.set('parameters/movement/current', state)


func init_debug():
	assert(hit_area is Area2D, "A Child node of type and name 'HitArea' is required")
	assert(hurt_area is Area2D, "A Child node of type and name 'HurtArea' is required")
	assert(sprite is Sprite, "A Child node of type and name 'Sprite' is required")
	assert(animation_tree is AnimationTree, "A Child node of type and name 'AnimationTree' is required")

	debug_info.attach(self).offset(Vector2(0, -20)).log_text('Type', self.name)


