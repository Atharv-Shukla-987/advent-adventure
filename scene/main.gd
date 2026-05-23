extends Node2D
var cureentlevelroot : Node = null
var level :int = 1

func _ready() -> void :
	cureentlevelroot = get_node( "level_root")
	_load_level(level)
		
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
	var exit = lvlrood.get_node_or_null("exit")
	if exit:
		exit.body_entered. connect(_on_exit_body_entered)





func _on_exit_body_entered(body:Node2D)-> void:
	if body.name == "player" :
		level += 1
		call_deferred("_load_level",level)
