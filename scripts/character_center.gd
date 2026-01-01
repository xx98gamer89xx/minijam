extends RigidBody2D
var piolets = []
var arm_length = 200
func _ready():
	linear_velocity = Vector2(0, 0)
	for node in get_parent().get_children():
		if node.is_in_group("piolet"):
			piolets.append(node)
			
func _physics_process(delta):
	for piolet in piolets:
		correct_position(piolet.anchored_position)
			
func correct_position(piolet):
	var W = piolet - position
	var distance = W.length()
	if abs(distance - arm_length) > 5:
		var correction = distance - arm_length
		linear_velocity += correction * W.normalized()
	else:
		var A = position
		var C = position + linear_velocity
		var P = punto_proyeccion(A, C, W)
		var V1 = [Vector2(P - A), Vector2(C - P)]
		linear_velocity = V1[1]

func punto_proyeccion(A, C, W):
	var W2 = W.length_squared()
	if W2 == 0:
		return A
	var t = (C - A).dot(W) / W2
	var P = A + W * t
	return P
