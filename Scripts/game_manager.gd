extends Node

@export var score_label: Label 
# Conecte este nó no Inspector apontando para a GameOverScreen que criamos
@export var game_over_screen: Control 

var score = 0
var is_game_over = false

func _ready() -> void:
	# Garante que a velocidade do jogo esteja normal ao reiniciar
	Engine.time_scale = 1.0 
	update_ui()
	if game_over_screen:
		game_over_screen.visible = false

func _process(_delta: float) -> void:
	# Se deu Game Over e o jogador apertou Espaço / Enter, reinicia o jogo
	if is_game_over and Input.is_action_just_pressed("jump"):
		get_tree().reload_current_scene()

func add_point() -> void:
	score += 1
	update_ui()

func update_ui() -> void:
	if score_label != null:
		score_label.text = "Moedas: " + str(score)
	else:
		print("Moedas: ", score)

# Função chamada quando o jogador morre
func trigger_game_over() -> void:
	if is_game_over:
		return
		
	is_game_over = true
	if game_over_screen:
		game_over_screen.visible = true
	
	# Opcional: Desacelera o tempo para dar um efeito visual bacana
	Engine.time_scale = 0.5
