extends AnimatedSprite2D

var bullet_impact_effect = preload("res://player/bullet_impact_effect.tscn")

var speed : int = 600
var direction : int
var damage_amount : int = 1

func _physics_process(delta):
	move_local_x(direction * speed * delta)

func _on_timer_timeout():
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("EnemyBullet area entered")
	bullet_impact(area)

func _on_hitbox_body_entered(body: Node2D) -> void:
	print("EnemyBullet body entered")
	bullet_impact(body)

func get_damage_amount() -> int:
	return damage_amount

func bullet_impact(target: Node2D):
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	
	if target.has_method("take_damage"):
		target.take_damage(damage_amount)
	
	queue_free()
