extends Node


@onready var player: CharacterBody3D = $Player
@onready var game_over = load("res://ui/main menu/GameOver.tscn")
@onready var timer : Timer
@onready var thud = preload("res://audio/thud.ogg")

var audioPlayer: AudioStreamPlayer3D = AudioStreamPlayer3D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(audioPlayer)
	audioPlayer.volume_db = 12.0
	audioPlayer.set_stream(thud)
	get_node("RigidBody3D").set_contact_monitor(true)
	get_node("RigidBody3D").set_max_contacts_reported(100)
	await get_tree().create_timer(5).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_rigid_body_3d_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body.name.match("Player"):
		print("wadfyhuji")
		#Universe.switch_scene(4)
		body.death()
	elif body.name.match("Floor"):
		audioPlayer.play()
		await get_tree().create_timer(2.5).timeout 
		queue_free() 
