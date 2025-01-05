extends Node3D

@onready var universe: Node3D = $"."
@onready var timer_component: Timer = $TimerComponent

@onready var this_scene = load("res://scenes/universe/universe.tscn")
#@onready var main_menu_scene = load("res://menus/title/MainMenu.tscn")
@onready var main_menu_scene = load("res://ui/main menu/MainMenu.tscn")
@onready var level_one = load("res://scenes/overworld/main_level.tscn")
@onready var test_level = load("res://levels/test level.tscn")
@onready var game_over = load("res://ui/main menu/GameOver.tscn")
#@onready var credits = load("res://menus/title/Credits.tscn")
#@onready var opening_cutscene: = load("res://scenes/opening_cutscene.tscn")

@onready var current_level = -1
@onready var current_scene: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (get_tree().current_scene != null):
		current_scene = get_tree().current_scene
	#print(get_tree().current_scene)
	#pass

func switch_scene(sceneNo: int):
	match sceneNo:
		0:
			current_level = 0
			#get_tree().change_scene_to_packed(opening_cutscene)
		1:
			current_level = 1
			get_tree().change_scene_to_packed(main_menu_scene)
		2:
			current_level = 2
			get_tree().change_scene_to_packed(test_level)
		3:
			current_level = 3
			#get_tree().change_scene_to_packed(credits)
		4:
			current_level = 4
			#get_tree().change_scene_to_packed(game_over)

#func start_timer(seconds: float):
	#timer_component.start(seconds)
#
#func get_time_left():
	#if !timer_component.is_stopped():
		#return timer_component.time_left
	#else:
		#return 0.0
#
#
#func _on_timer_component_timeout() -> void:
	#pass
