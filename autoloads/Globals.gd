extends Node

var player: Player

var dynamics_solver_scene = preload("res://utils/dynamics/dynamics_solver.tscn")
var dynamics_solver_vector_scene = preload("res://utils/dynamics/dynamics_solver_vector.tscn")

func wait(duration: float):
	await get_tree().create_timer(duration, false, false, true).timeout

func create_dynamics(dynamics: DynamicsResource) -> DynamicsSolver:
	if not dynamics: return null
	var solver = dynamics_solver_scene.instantiate() as DynamicsSolver
	solver.f = dynamics.f
	solver.z = dynamics.z
	solver.r = dynamics.r
	get_tree().root.call_deferred("add_child", solver)
	return solver

func create_dynamics_vector(dynamics: DynamicsResource) -> DynamicsSolverVector:
	if not dynamics: return null
	var solver = dynamics_solver_vector_scene.instantiate() as DynamicsSolverVector
	solver.f = dynamics.f
	solver.z = dynamics.z
	solver.r = dynamics.r
	get_tree().root.call_deferred("add_child", solver)
	return solver
