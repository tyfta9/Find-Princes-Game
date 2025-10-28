extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound
@onready var death: AnimationPlayer = $Death
@onready var interface: Interface = %Interface as Interface
@onready var camera: Camera2D = %Camera
const END_MENU = preload("res://scenes/GUI/end_menu.tscn")

# defoult controls
@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300
var default_position: Vector2
var stop_movement: bool = false

# double jump
var double_jump_ability: bool = false
var double_jump: bool = false

# coyoty time jump
var coyote_jump: bool = false
const COYOTE_TIME: float = 0.03
var was_on_floor: bool = false

## debug
#var old_coyoty_jump: bool = false
#var old_was_on_floor: bool = false
#var somthing_changed: bool = false
#var changes: int = 0

# demage system
@export var max_hp: int = 1
const HURT_TIME: float = 1
var imortal: bool = false

# score system
var score: int = 0

func _ready():
	default_position = position
	if !interface.is_node_ready():
		await(interface.ready)
	interface.player_hp.set_max_hp(max_hp)
	interface.stopwatch.start()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		# if playr not jumping - start coyoty time
		if coyote_jump && was_on_floor && velocity.y >= 0:
			coyote_time() # the timer should not start if the player jumps.
		# if coyote time runs out - fall
		if !coyote_jump:
			velocity += get_gravity() * delta
			if velocity.y > JUMP_VELOCITY*-1:
				velocity.y = JUMP_VELOCITY*-1
			
		if was_on_floor:
			was_on_floor = false
	
	if is_on_floor() && velocity.y == 0:
		was_on_floor = true
		coyote_jump = true
		double_jump = true
		
	# Handle jump.	
	handle_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float
	if !stop_movement:
		direction = Input.get_axis("move_left", "move_right")
	
	set_animation(direction)
	
	# move
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
	
	move_and_slide()

func coyote_time():
	var timer = get_tree().create_timer(COYOTE_TIME)
	await(timer.timeout)
	coyote_jump = false

func handle_jump():
	if Input.is_action_just_pressed("jump") && !stop_movement:
		# coyoty jump is a normal jump but delayed
		if is_on_floor() || coyote_jump:
			jump()
			coyote_jump = false
			#print("coyote jump = ", coyote_jump)
		# simple double jump
		elif double_jump_ability && double_jump:
			jump()
			double_jump = false

func set_animation(direction:float):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if !(interface.player_hp.get_hp() < 1):
		if !is_on_floor() && !coyote_jump:
			animated_sprite.play("jump")
		elif direction == 0:
			animated_sprite.play("idle")
		else :
			animated_sprite.play("run")

func hurt():
	if !imortal:
		interface.player_hp.get_demage()
		var hp = interface.player_hp.get_hp()
		imortal = true
		if !(hp<1):
			death.play("get_hurt")
			await(get_tree().create_timer(HURT_TIME).timeout)
			print("You have left ", hp, " hp")
			position = default_position
			imortal = false
		else:
			print("You died!")
			death.play("death")
			stop_movement = true
			await animated_sprite.animation_finished
		if !hp:
			var end_menu = END_MENU.instantiate()
			add_child(end_menu)
			if !end_menu.is_node_ready():
				await end_menu.ready
			interface.stopwatch.stop()
			end_menu.start(hp, interface.score.get_score(), interface.stopwatch.get_time())

func jump():
	velocity.y = JUMP_VELOCITY
	jump_sound.play()

func set_double_jump(permision:bool):
	double_jump_ability = permision
		
func on_game_menu():
	print("Game ended for player")
	stop_movement = true
	camera.move_position_by(Vector2(12, -12)) # have to use a variable here !!!!!!!!!!!!??????????????????
	camera.zoom_in()
		
func on_game_after_menu():
	print("Game started for player")
	stop_movement = false
	camera.move_position_by(Vector2(-12, 12))
	camera.zoom_out()
	interface.stopwatch.start()
	
