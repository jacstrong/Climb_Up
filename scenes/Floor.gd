extends StaticBody2D

export (float) var blinkTime = 0.2
export (int) var blinks = 3
var landedOn


func _ready():
	landedOn = false
	$AnimationFrameTimer.set("Wait Time", blinkTime)
	$AnimationTimer.set("Wait Time", blinkTime)
	pass


func _on_Area2D_body_entered(body):
	if landedOn == false:
		print("landed on")
		$AnimationFrameTimer.start()
	pass # replace with function body


func _on_AnimationTimer_timeout():
	blinks -= 1
	self.visible = true
	$AnimationFrameTimer.start()

func _on_AnimationFrameTimer_timeout():
	_fall_off()
	
func _fall_off():
	if blinks != 0:
		self.visible = false
		$AnimationTimer.start()
	else:
		self.position.x = -500
	

