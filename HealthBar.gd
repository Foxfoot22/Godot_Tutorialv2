extends ProgressBar

var current_health = self.get_value()
var new_health
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Health_max_changed(new_max):
	self.set_max(new_max)


func _on_Player_update_health():
	
	new_health = current_health - 1.0
	self.set_value(new_health)
