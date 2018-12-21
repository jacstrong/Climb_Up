extends Node2D

var camera
var screensize
var platforms = []
var Platforms

var large_plat
var small_plat

var plats = []

var last_level
var levels = []

func _ready():
	randomize()
	
	# Initialize class vars
	screensize = get_viewport_rect().size
	camera = $Player/Camera2D.get_viewport_transform()
	Platforms = $Platforms
	last_level = camera.get_origin().y + 200
	
	# platforms
	large_plat = preload("res://scenes/Floating_Floor.tscn")
	plats.append(large_plat)
	small_plat = preload("res://scenes/Floor.tscn")
	plats.append(small_plat)
	
	# Make camera current
	$Player/Camera2D.make_current()
	
	for x in [400, 200 , 0, -200]:
		levels.push_front(x)
		placePlats(x)
	pass

func _process(delta):
	if ($Player/Camera2D.get_viewport_transform() != camera):
		cameraMoved()
		#print($Player/Camera2D.get_viewport_transform())
	pass

func cameraMoved():
	camera = $Player/Camera2D.get_viewport_transform()
	if (camera.get_origin().y) > (last_level + 200):
		placePlats((last_level + 200) * -1)
		levels.push_front((last_level + 200) * -1)
		print(levels)
		removePlats(levels.back())
		levels.pop_back()
		last_level = camera.get_origin().y

func placePlats(y):
	var num = floor(rand_range(2, 5))
	for i in range(num):
		var plat = plats[randi() % plats.size()].instance()
		plat.position.y = y
		plat.position.x = rand_range(0, screensize.x)
		$Platforms.add_child(plat)
		platforms.push_front(plat)
		$Player/Camera2D/Control/NumPlats.text = String(platforms.size())

func removePlats(y):
	while platforms.back().position.y == y:
		platforms.back().queue_free()
		platforms.pop_back()
	