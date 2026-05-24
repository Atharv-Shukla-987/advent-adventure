extends Node2D
@onready var health_bar: Sprite2D = $health


@onready var defwidth = health_bar.region_rect.size.x
@onready var defheight = health_bar.region_rect.size.y


func updatehealth(newhealth:int) -> void:
	var newwidth= (newhealth/100.0) * defwidth
	health_bar.region_rect = Rect2(0,0,newwidth,defheight)                     
