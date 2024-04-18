class_name DynamicsResource extends Resource

## Frequency or speed of the animation. Does not affect the shape.
@export var f: float = 4
## Damping factor of the animation. Use 0 to never stop and >1 for no vibration.
@export var z: float = 0.2
## Initial response of the animation. Use >1 to overshoot and <0 for anticipation.
@export var r: float = 2
