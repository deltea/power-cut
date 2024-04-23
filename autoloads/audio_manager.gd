extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

var level_select_music = preload("res://assets/music/level-select.wav")
var level_music = preload("res://assets/music/level.wav")

func play_music(music: AudioStream):
	music_player.stream = music
	music_player.play()

func play_sound(sound: AudioStream):
	var player = AudioStreamPlayer.new()
	player.stream = sound
	player.bus = "SFX"
	player.play()
	player.connect("finished", player.queue_free)
	add_child(player)
