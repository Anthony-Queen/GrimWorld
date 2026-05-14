extends Resource

class_name CharacterData

# character's stats
@export var max_health : float = 100
@export var health : float = 100
@export var max_mana : float = 100
@export var mana : float = 100
@export var max_exp : float = 100
@export var current_exp : float = 0

@export var damage : float = 50

# character's levels
@export var resistance : float = 1
@export var attack : float = 1
@export var wisdom : float = 1
@export var luck : float = 1


# character's skills 
@export var attacks : Array[String] = ["nigga", "blu", "skipidip", "yes yes", "no no", "uhuhu"]
@export var spells : Array[String] = ["nigger", "blue", "skipidipop", "yess yess", "noo noo", "uhuhuuu"]
