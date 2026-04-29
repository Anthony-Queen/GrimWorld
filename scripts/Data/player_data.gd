extends Resource

class_name PlayerData


# Player's stats
@export var max_health : float = 100
@export var health : float = 100
@export var max_mana : float = 100
@export var mana : float = 100
@export var max_exp : float = 100
@export var current_exp : float = 0

@export var damage : float = 5

# Player's levels
@export var resistance : float = 0
@export var attack : float = 0
@export var wisdom : float = 0
@export var luck : float = 0

var position : Vector3 
