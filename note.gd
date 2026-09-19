extends Area2D

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var FREQUENCY: float = 440.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		collision.set_deferred("disabled", true)
		sprite.hide()

		var label_node = get_tree().get_first_node_in_group("ui_label") as Label
		if label_node:
			var parent_name = get_parent().name
			label_node.text += "\n" + parent_name
			
		audio_player.play()
		var playback = audio_player.get_stream_playback()
		
		if playback:
			var sample_rate: float = audio_player.stream.mix_rate
			var duration: float = 2.0
			var total_frames: int = int(sample_rate * duration)
			var phase: float = 0.0
			
			for frame in range(total_frames):
				var sample: float = sin(phase * TAU) * 0.5
				playback.push_frame(Vector2(sample, sample))
				phase = fmod(phase + FREQUENCY / sample_rate, 1.0)

		await get_tree().create_timer(2.0).timeout
		queue_free()
