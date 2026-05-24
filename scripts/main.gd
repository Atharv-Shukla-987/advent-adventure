extends Node2D
var cureentlevelroot : Node = null
var level :int = 1
@onready var hud: CanvasLayer = $HUD

@onready var background_music: AudioStreamPlayer = $"background music"




func _ready() -> void :
	cureentlevelroot = get_node( "level_root")
	_load_level(level)
	background_music.play()
#levelmanagemment

func _load_level ( levelnumbr:int)-> void:
	if cureentlevelroot :
		cureentlevelroot.queue_free()
		#lvlchangerhrhngikl;
		var levelpath = "res://scene/levels/level_%s.tscn" % levelnumbr
		cureentlevelroot = load(levelpath).instantiate()
		add_child(cureentlevelroot)
		cureentlevelroot.name = "Level_root"
		_setuplvl(cureentlevelroot)


func _setuplvl(lvlrood:Node ) -> void :
	
	var player = lvlrood.get_node("player")
	player.died.connect(on_player_died)
	
	
	var exit = lvlrood.get_node_or_null("exit")
	if exit:
		exit.body_entered. connect(_on_exit_body_entered)
	




func _on_exit_body_entered(body:Node2D)-> void:
	if body.name == "player" :
		level += 1
		call_deferred("_load_level",level)



func on_player_died()-> void :
	await get_tree().create_timer(
	1.0).timeout
	await hud.fade(1.0)
	
	level = 1
	
	
	playerstats.reset()
	_load_level(level)
	await hud.fade(0)
	
