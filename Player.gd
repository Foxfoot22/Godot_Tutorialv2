extends Area2D
# warning-ignore:unused_signal
signal update_health()

export var speed = 400
var screen_size



var target = Vector2()


func _ready():	
	hide()
	screen_size = get_viewport_rect().size
	
func start(pos):
	target = pos
	show()
	$CollisionShape2D.disabled = false
	
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position
		
	
func _process(delta):
	var velocity = Vector2()
	
	if position.distance_to(target) > 10:
		velocity = target - position
	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		


func _on_Player_body_entered(_body):
	emit_signal("update_health")


# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)	
	
