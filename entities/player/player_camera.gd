class_name PlayerCamera

extends Camera3D

const RAY_LENGTH: int = 1000 #arbritrary ray length


func ray_query() -> Dictionary:
	var pos: Vector2 = get_viewport().get_mouse_position()
	var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	
	query.from = project_ray_origin(pos)
	query.to = query.from + project_ray_normal(pos) * RAY_LENGTH
	
	#print(space.intersect_ray(query))
	return space.intersect_ray(query)


func mouse_position_3D(default: Vector3) -> Vector3:
	var result: Dictionary = ray_query()
	
	if not result:
		return default
	
	return result["position"]


func mouse_object() -> Object:
	var result: Dictionary = ray_query()
	
	return result["collider"] if result else null
