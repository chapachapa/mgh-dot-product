extends Node3D


const x_pos_max = 5

var previous_slider_value = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# check slider
	var slider_percentage = ($CanvasLayer/HSlider.value - 0.5) * 2
	if previous_slider_value != slider_percentage:
		
		previous_slider_value = slider_percentage
		$Plane.position.x = slider_percentage * x_pos_max;
		# update rotation of arrow
		# $ArrowFromSphere.look_at($Plane.position)
		# $ArrowFromSphere.rotation += Vector3(rad_to_deg(90), 0, 0)
		var vecToPlane = $sphere.position - $LightVector.position
		# print_debug(Vector3(0,1,0).angle_to(vecToPlane))
		if $sphere.position.x > $Plane.position.x:
			$LightVector.rotation = Vector3(0, 0, 0)
			$LightVector.rotate_z(-1 * Vector3(0,1,0).angle_to(vecToPlane))
		else:
			$LightVector.rotation = Vector3(0, 0, 0)
			$LightVector.rotate_z(Vector3(0,1,0).angle_to(vecToPlane))
			
		$LightVector.position = $Plane.position;
		
		print_debug(vecToPlane.normalized().dot(Vector3(0,1,0)));
		$CanvasLayer/DotValue.text = str(snapped(vecToPlane.normalized().dot(Vector3(0,1,0)), 0.01))

	pass
