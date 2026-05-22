extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_swing: AudioStreamPlayer2D = $"sword swing"


const SPEED = 300.0
var lastdirection : Vector2 =  Vector2.RIGHT
var isattacking: bool = false
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and not isattacking:
		
		attack()
	#skiping movement
	if isattacking:
		velocity = Vector2.ZERO
		return
	process_movement()
	process_animation()
	move_and_slide()
	
	
	
	
	
	
	
	
	
	
func process_movement() -> void:
	var direction := Input.get_vector("left","right","up","down")
	if direction!= Vector2.ZERO:
		velocity= direction*SPEED
		lastdirection= direction
	else:
		velocity = Vector2.ZERO
  
		
	
func process_animation() -> void:
	if isattacking :
		return
	if velocity != Vector2.ZERO:
		play_animation("run", lastdirection)
	else:
		play_animation("idle", lastdirection)
	

func play_animation(prefix : String , dir:Vector2)-> void:
	if dir.x  != 0 :
		animated_sprite_2d.flip_h = dir.x<0
		animated_sprite_2d.play(prefix + "-right")
	if dir.y< 0:
		animated_sprite_2d.play(prefix +"-up")
	if dir.y> 0 :
		animated_sprite_2d.play(prefix +"-down")
		
		
		
func attack() -> void:
	isattacking = true
	sword_swing.play()
	play_animation("attack", lastdirection)
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if isattacking:
		isattacking = false
