extends Camera2D

@onready var player1 =  get_node("../Player")
@onready var player2 =  get_node("../Player2")

func _ready():
	pass

const default_zoom = 3

func _process(delta):
	var player1Position = player1.get("position")
	var player2Position = player2.get("position")

	var offset = (player1Position + player2Position) / 2
	set("position", offset)

	var zoom_factor1 = 12 * abs(player1Position.x-player2Position.x)/(1152 -100)
	var zoom_factor2 = 12 * abs(player1Position.y-player2Position.y)/(648-100)
	var zoom_factor = max(max(zoom_factor1, zoom_factor2), default_zoom)

	self.zoom = Vector2(pow(default_zoom, 2) /zoom_factor, pow(default_zoom, 2) /zoom_factor)
