extends RigidBody2D

export (int) var speed
var screensize

func _ready():
	screensize = get_viewport_rect().size
	pass

func _process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	#if Input.is_action_pressed("ui_up"):
		#velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed("ui_up"):
		velocity.y -= 100
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)
	pass

func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	pass
