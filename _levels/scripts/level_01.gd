extends Node

export var mob : PackedScene
var score

onready var player : Player = $Player
onready var start_position : Position2D = $PlayerStartPosition
onready var mob_timer : Timer = $MobTimer
onready var score_timer : Timer = $ScoreTimer
onready var start_timer : Timer = $StartTimer
onready var mob_spawn_location : PathFollow2D = $MobPath/MobSpawnLocation
onready var on_game_over_sound_fx : AudioStreamPlayer = $DeathSound
onready var game_music : AudioStreamPlayer = $Music
onready var HUD : HUD = $HUD

func _ready():
# warning-ignore:return_value_discarded
	HUD.connect("start_game", self, "_on_start_game_gameStarted")
# warning-ignore:return_value_discarded
	player.connect("hit", self, "gameOver")
# warning-ignore:return_value_discarded
	mob_timer.connect("timeout", self, "_on_mob_timer_timeout")
# warning-ignore:return_value_discarded
	score_timer.connect("timeout", self, "_on_score_timer_timeout")
# warning-ignore:return_value_discarded
	start_timer.connect("timeout", self, "_on_start_timer_timeout")
	randomize()
	
func _on_start_game_gameStarted():
	newGame()
	
	
func gameOver():
	game_music.stop()
	on_game_over_sound_fx.play()
	score_timer.stop()
	mob_timer.stop()
	get_tree().call_group("mobs", "queue_free")
	HUD.showGameOver()


func newGame():
	if(!game_music.playing):
		game_music.play()
	score = 0
	player.start(start_position.position)
	start_timer.start()
	HUD.updateScore(score)
	HUD.showMessage("Get Ready!")
	

func _on_mob_timer_timeout():
	mob_spawn_location.offset = randi()
	var enemy : Mob = mob.instance()
	add_child(enemy)
	
	var direction = mob_spawn_location.rotation + PI / 2
	enemy.position = mob_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
	

func _on_score_timer_timeout():
	score += 1
	HUD.updateScore(score)

func _on_start_timer_timeout():
	mob_timer.start()
	score_timer.start()
