class_name PlayerDrawing
extends Node2D


var current_line : DrawingLine2D

func start_line(position: Vector2) -> void:
	current_line = DrawingLine2D.new()
	add_child(current_line)
	new_point(position)


func new_point(position: Vector2) -> void:
	current_line.add_drawing_point(position)


func stop_line(position: Vector2):
	new_point(position)
	current_line.try_to_create_shape()
	current_line = null


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_line(event.position)
			else:
				stop_line(event.position)
	elif event is InputEventMouseMotion:
		if current_line:
			new_point(event.position)
