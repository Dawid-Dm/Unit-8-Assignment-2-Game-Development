extends CharacterBody3D

signal coin_collected(new_coin_count)

const Speed = 15.0
@export var coin_count: int = 0

func _physics_process(float) -> void:
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	if direction:
		velocity.x = direction.x * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		
	move_and_slide()

	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider.name == "coin":
			coin_count += 1
			print("Coin collected! Total coins:", coin_count)
			
			# Emit the signal so the HUD can update
			emit_signal("coin_collected", coin_count)
			
			collider.queue_free()
		else:
			print("Collided with:", collider)
			get_tree().reload_current_scene()
