extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D;
const SPEED = 400.0
const JUMP_VELOCITY = -1200.0
const JUMP_CUT_MULTIPLIER = 0.8

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		is_jumping = false

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	if Input.is_action_just_released("up") and velocity.y < 0 and is_jumping:
		velocity.y *= JUMP_CUT_MULTIPLIER
		is_jumping = false

	var direction = Input.get_axis("left", "right");
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = velocity.x < 0;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if self.position.y > 1000:
		global_position = Vector2(0, 0)
		velocity = Vector2.ZERO

	move_and_slide()
