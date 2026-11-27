
extends CharacterBody2D

@export var move_speed: float = 200.0
@export var acceleration: float = 1200.0
@export var friction: float = 1400.0
@export var jump_velocity: float = -500.0
@export var gravity: float = 1200.0
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1
@export var jump_cut_multiplier: float = 0.5
@export var fall_limit: float = 600.0
@export var zip_speed: float = 700.0
@export var hats: Array[Texture2D]

@onready var tongue_ray: RayCast2D = $TongueRay
@onready var tongue: Line2D = $Tongue

var facing: int = 1
var spawn_position: Vector2

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0



func _ready() -> void:
	spawn_position = global_position

	if GameData.hat == 0:
		$Hat.visible = false

	elif GameData.hat <= hats.size():
		$Hat.visible = true
		$Hat.texture = hats[GameData.hat - 1]

	else:
		$Hat.visible = false



func _physics_process(delta: float) -> void:

	# Respawn if the player falls too far
	if global_position.y > fall_limit:
		respawn()
		return

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Coyote time
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

	# Player movement
	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		facing = int(direction)
		velocity.x = move_toward(
			velocity.x,
			direction * move_speed,
			acceleration * delta
		)
	else:
		velocity.x = move_toward(
			velocity.x,
			0,
			friction * delta
		)

	# Tongue ability
	if Input.is_action_just_pressed("tongue"):
		use_tongue()

	# Jump buffering
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta

	# Jump
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_velocity
		coyote_timer = 0
		jump_buffer_timer = 0

	# Short jump when releasing the button early
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_cut_multiplier

	# Move the player
	move_and_slide()

	# Bouncy platforms
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider = collision.get_collider()

		if collider.is_in_group("bouncy") and collision.get_normal().y < -0.7:
			velocity.y = collider.bounce()


func use_tongue() -> void:

	tongue_ray.target_position = Vector2(100 * facing, -60)
	tongue_ray.force_raycast_update()

	if tongue_ray.is_colliding():
		var target = tongue_ray.get_collider()

		if target.is_in_group("tongue_target"):
			target.come_alive()

		if target.is_in_group("sticky"):
			var hit_point = tongue_ray.get_collision_point()
			var dir = (hit_point - global_position).normalized()
			velocity = dir * zip_speed

	# Draw the tongue
	tongue.clear_points()
	tongue.add_point(Vector2.ZERO)
	tongue.add_point(Vector2(100 * facing, -60))

	await get_tree().create_timer(0.15).timeout

	tongue.clear_points()


func respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO

	coyote_timer = 0.0
	jump_buffer_timer = 0.0
