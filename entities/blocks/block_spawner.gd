extends Node3D

@onready var block1 = preload("res://entities/blocks/block_1/block_1.tscn")
@onready var block2 = preload("res://entities/blocks/block_2/block_2.tscn")
@onready var armisael = preload("res://entities/blocks/armisael/armisael.tscn")
@onready var arthur = preload("res://entities/blocks/arthur/arthur.tscn")
@onready var player: CharacterBody3D = $"../Player"
@onready var blocks_0 = [block1, block2]
@onready var blocks_1 = [block1, block2, armisael]
@onready var blocks_2 = [armisael, arthur]
@onready var blocks_3 = [block1, block2, armisael]
@onready var blocks_4 = []
@onready var test_level: Node3D = $".."
@onready var spawn_timer: Timer = $SpawnTimer


@export var enableBlocks : bool = true

var current_pool = blocks_0
var current_level = 0

const XMIN = -50.0
const ZMIN = -50.0
const XMAX = 50.0
const ZMAX = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enableBlocks = true
	current_pool = blocks_0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lvl = test_level.get_current_level()
	if lvl != current_level:
		current_level = lvl
		if current_level == 0:
			current_pool = blocks_0
		elif current_level == 1:
			current_pool = blocks_1
		elif current_level == 2:
			spawn_timer.start(2.5)
			current_pool = blocks_2
		elif current_level == 3:
			spawn_timer.start(2.0)
			current_pool = blocks_3
		else:
			enableBlocks = false
			current_pool = blocks_4


func _on_timer_timeout() -> void:
	if enableBlocks:
		var rng = RandomNumberGenerator.new()
		var blockInstance = rng.randi_range(0, current_pool.size() - 1)
		var block = current_pool[blockInstance].instantiate()
		var playerPos = player.global_position
		
		var randX = rng.randi_range(XMIN + playerPos.x, XMAX + playerPos.x)
		var randZ = rng.randi_range(ZMIN + playerPos.z, ZMAX + playerPos.z)
		block.translate(Vector3(randX, rng.randi_range(-16.0, 16.0), randZ))
		get_parent().get_node("BlockSpawnerLocation").add_child(block)

	
