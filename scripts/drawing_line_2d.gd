class_name DrawingLine2D
extends Line2D

var min_close_distance_px := 80
var min_distance_px := 10
var min_points_for_shape := 20


func add_drawing_point(point: Vector2) -> void:
	if points.size() < 1:
		add_point(point)
	if points[points.size()-1].distance_to(point) > min_distance_px:
		add_point(point)

	
func try_to_create_shape():
	var closest_point_indexes := create_distance_matrix()
	if closest_point_indexes.x < 0:
		queue_free()
		return
	
	var tail_point := points[closest_point_indexes.x]
	var head_point := points[closest_point_indexes.y]

	var distance := tail_point.distance_to(head_point)
	if distance < min_close_distance_px:
		points = points.slice(closest_point_indexes.x, closest_point_indexes.y)
		closed = true
	else:
		queue_free()


func create_distance_matrix() -> Vector2i:
	var closest_points: Vector2i = Vector2i(-1,-1)
	var closest_distance: float = INF
	var size: int = points.size()
	
	for i in range(0, size):
		for j in range(i+min_points_for_shape, size):
			var a := points[i]
			var b := points[j]
			
			var factor : float = (j-i)/float(size) #always between 0-1
			var distance_with_factor := calculate_factor_distance(a, b, factor)
			if distance_with_factor < closest_distance:
				closest_distance = distance_with_factor
				closest_points = Vector2i(i, j)
	
	return closest_points


func calculate_factor_distance(a: Vector2, b: Vector2, factor: float) -> float:
	var distance := a.distance_to(b)
	var distance_with_factor := distance - distance*factor*factor
	return distance_with_factor
