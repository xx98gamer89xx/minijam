extends Area2D

func _process(delta):
	var velocity = transform.x * 200
	position += velocity


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.health -= 10
