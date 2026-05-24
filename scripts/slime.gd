extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var take_damage: AudioStreamPlayer2D = $"take damage"
@onready var healthbar: Node2D = $Healthbar
@onready var attacktimer: Timer = $attacktimer


var SPEED = 75
var health:int = 100
var atk : int = 20
var isalive : bool = true
const knockforce : int = 100
var targetinrange :bool = false


var target = null
func _physics_process(delta: float) -> void:
	if isalive and target:
		_attack(delta)
	


func _attack(delta:float)-> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	anim.play("attack")

func damagetake(damage:int, attarckerposition)-> void:
	health-= damage
	healthbar.updatehealth(health)
	take_damage.play()
	if health == 0 :
		_die()
	#knockback
	var knockback_direction = (position - attarckerposition).normalized()
	var targetposition  =  position + knockback_direction * knockforce 
	
	var tween = create_tween()
	tween.tween_property(self , "position", targetposition, 0.6)
	tween.set_trans(Tween.TRANS_CUBIC)
	
func _die() -> void :
	isalive = false
	anim.play("death")
	take_damage.pitch_scale = 0.5
	take_damage.play()
	
	#disable colliaon shape
	$CollisionShape2D.set_deferred("disabled",true)
	$sight/CollisionShape2D.set_deferred("disabled",true)
	$Healthbar.set_deferred("disabled",true)
func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "player" :
		target = body




func _on_sight_body_exited(body: Node2D) -> void:
	if body.name == "player" and isalive:
		target= null
		anim.play("idle")
		
		


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("z")
	if body.name == "player" and isalive:
		targetinrange = true
		body.takedamage(atk)
		attacktimer.start()
		
	
func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "player" and isalive:
		targetinrange = false
		attacktimer.stop()
		
	


func _on_attacktimer_timeout() -> void:
	if target and targetinrange :
		target.takedamage(atk)
