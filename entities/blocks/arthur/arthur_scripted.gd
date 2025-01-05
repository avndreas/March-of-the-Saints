extends Node


@onready var player: Node3D = get_parent().get_parent().get_parent().get_parent().find_child("Player")
@onready var game_over = load("res://ui/main menu/GameOver.tscn")
@onready var timer : Timer

@onready var pathFollow: Node3D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#get_node("Area3D").set_contact_monitor(true)
	#get_node("Area3D").set_max_contacts_reported(100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.get_level() == 3:
		if pathFollow is PathFollow3D:
			pathFollow.progress += delta * 200.0
	
	


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name.match("Player"):
		body.death()
