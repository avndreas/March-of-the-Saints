extends Node3D

@onready var block1 = preload("res://entities/blocks/block_1/block_1.tscn")
@onready var block2 = preload("res://entities/blocks/block_2/block_2.tscn")
@onready var armisael = preload("res://entities/blocks/armisael/armisael.tscn")
@onready var arthur = preload("res://entities/blocks/arthur/arthur.tscn")
@onready var player: CharacterBody3D = $"../Player"
@onready var blocks = [block1, block2, armisael, arthur]
#@onready var blocks = [arthur]

@export var enableBlocks : bool = true

const XMIN = -50.0
const ZMIN = -50.0
const XMAX = 50.0
const ZMAX = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	var blockInstance = rng.randi_range(0, blocks.size() - 1)
	var block = blocks[blockInstance].instantiate()
	var playerPos = player.global_position
	
	var randX = rng.randi_range(XMIN + playerPos.x, XMAX + playerPos.x)
	var randZ = rng.randi_range(ZMIN + playerPos.z, ZMAX + playerPos.z)
	block.translate(Vector3(randX, rng.randi_range(-16.0, 16.0), randZ))
	if enableBlocks:
		get_parent().get_node("BlockSpawnerLocation").add_child(block)
	
