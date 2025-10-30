class_name PlayerDrawing
extends Node2D

@export var min_distance_px := 5
@export var line_width_px := 2
@export var min_close_distance_px := 80
var current_line : DrawingLine2D


func start_line(position: Vector2) -> void:
	current_line = DrawingLine2D.new()
	current_line.width = line_width_px
	current_line.min_close_distance_px = min_close_distance_px
	current_line.min_distance_px = min_distance_px
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
