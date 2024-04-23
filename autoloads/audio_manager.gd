extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

var level_select_music = preload("res://assets/music/level-select.wav")
var level_music = preload("res://assets/music/level.wav")

var level_selected = preload("res://assets/sfx/level-selected.wav")
var level_selection = preload("res://assets/sfx/level-selection.wav")
var level_locked = preload("res://assets/sfx/locked.wav")
var lever = preload("res://assets/sfx/lever.wav")
var exit_door = preload("res://assets/sfx/exit-door.wav")
var jump = preload("res://assets/sfx/jump.wav")
var trampoline = preload("res://assets/sfx/trampoline.wav")
var win = preload("res://assets/sfx/win.wav")
var box = preload("res://assets/sfx/box.wav")


func play_music(music: AudioStream):
	music_player.stream = music
	music_player.play()

func play_sound(sound: AudioStream, randomness: float = 0):
	var player = AudioStreamPlayer.new()
	player.pitch_scale = randf_range(1 - randomness, 1 + randomness)
	player.stream = sound
	player.bus = "SFX"
	player.connect("finished", player.queue_free)
	add_child(player)
	player.play()
