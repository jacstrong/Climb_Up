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

var score

func _ready():
	randomize()
	
	# Initialize class vars
	screensize = get_viewport_rect().size
	camera = $Player/Camera2D.get_viewport_transform()
	Platforms = $Platforms
	last_level = 200
	print(last_level)
	score = 0;
	
	# platforms
	large_plat = preload("res://scenes/Floating_Floor.tscn")
	plats.append(large_plat)
	small_plat = preload("res://scenes/Floor.tscn")
	plats.append(small_plat)
	
	# Make camera current
	$Player/Camera2D.make_current()
	
	for x in [400, 200 , 0, -200, -400]:
		levels.push_front(x)
		placePlats(x)
	pass

func _process(delta):
	if ($Player/Camera2D.get_viewport_transform() != camera):
		cameraMoved()
		$UI.rect_position.y = $Player/Camera2D.get_viewport_transform().get_origin().y * -1
	pass

func cameraMoved():
	camera = $Player/Camera2D.get_viewport_transform()
	if (camera.get_origin().y) > (last_level):
		placePlats((last_level + 200) * -1)
		levels.push_front((last_level + 200) * -1)
		print(levels)
		removePlats(levels.back())
		levels.pop_back()
		last_level = ((last_level + 200))
		score += 1

func placePlats(y):
	var num = floor(rand_range(2, 5))
	var placedAt = []
	for i in range(num):
		var plat = plats[randi() % plats.size()].instance()
		plat.position.y = y
		var pos
		if placedAt.size() > 0:
			var canPlace = false
			while canPlace == false:
				pos = rand_range(0, screensize.x)
				var found = true
				for i in placedAt:
					if pos < i + 200 and pos > i - 200:
						found = false
				if found:
					canPlace = true
				
			plat.position.x = pos
			placedAt.append(pos)
		else:
			pos = rand_range(0, screensize.x)
			plat.position.x = pos
			placedAt.append(pos)
			
		$Platforms.add_child(plat)
		platforms.push_front(plat)
		$UI/Label.text = "Score: " + String(score)

func removePlats(y):
	while platforms.back().position.y == y:
		platforms.back().queue_free()
		platforms.pop_back()

func removeAllPlats(y):
	while platforms.size() > 0:
		print(platforms.size())
		platforms.back().queue_free()
		platforms.pop_back()

func restart():
	for y in levels:
		removeAllPlats(y)
	levels = []
	for x in [400, 200 , 0, -200, -400]:
		levels.push_front(x)
		placePlats(x)
	last_level = 200
	score = 0
	

func _on_Button_pressed():
	restart()
	pass # replace with function body
