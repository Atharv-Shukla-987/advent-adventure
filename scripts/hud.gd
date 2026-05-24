extends CanvasLayer
const HEARTSIZE : int= 20

const fullheart = preload("res://resource/ui/Heart2.png")
const emptyheart = preload("res://resource/ui/0002.png")
const halfheart = preload("res://resource/ui/001.png")

@onready var fadeoverlay: ColorRect = $FADEOVERLAY
@onready var heartscotiner: BoxContainer = $hearts
#func _ready() -> void:
	#updatehealth(50)

###func updatehealth(newhealth:int)->void:
	#var hearts = heartscotiner.get_children()
	#var maxhearts=len(hearts)
	#var full  = int( newhealth / HEARTSIZE)
	#var half = 1 if (newhealth % HEARTSIZE) >0 else 0
	
	#var empty = maxhearts- (full + half)
	
	#for i in full :
		#hearts[i].texture = fullheart
	#for i in half :
		#hearts[full].texture = halfheart
	#for i in empty:
		#hearts[len(hearts) -1-i].texture = emptyheart


func fade(toalpha: float) -> void:
	var tween = create_tween()
	tween.tween_property(fadeoverlay, "modulate:a",toalpha , 1.5 )	
	await tween.finished
