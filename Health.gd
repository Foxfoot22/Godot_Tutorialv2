extends Node

signal max_changed(new_max)
signal changed(new_amount)
signal depleted

export(int) var max_amount = 100 setget set_max
onready var current = max_amount setget set_current

# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize() 

func set_max(new_max):
	max_amount = new_max
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)
	
func set_current(new_value):
	current = new_value
	current = clamp(current, 0, max_amount)
	emit_signal("changed", current)
	
	if current == 0:
		emit_signal("depleted")
		
func _initialize():
	emit_signal("max_changed", max_amount)
	emit_signal("changed", current)
	
	


func _on_Player_update_health(current_health):
	current_health = get("HealthBar/value")

	set("HealthBar/value", current_health)
