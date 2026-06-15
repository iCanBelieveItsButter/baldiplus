extends Node3D

@onready var stream_welcome = preload("res://plusAssets/AudioClip/BAL_HideSeek.wav")
@onready var stream_count : String = "res://plusAssets/AudioClip/BAL_Count"

@onready var sprite : AnimatedSprite3D = $sprite
@onready var sprite_count : Sprite3D = $count
@onready var aud : AudioStreamPlayer3D = $aud

@onready var countTimer = $Timer


var countProgress : int

func _ready():
	start()

func start():
	set_process(false)
	countProgress = 10
	sprite.offset.x = -36.0

	sprite.visible = true
	sprite_count.visible = false
	sprite.play("wave")
	await get_tree().create_timer(0.5).timeout
	aud.play()
	await aud.finished

	## wait until the player gets far enough away
	countTimer.wait_time =0.0001
	set_process(true)

func chasePlayer():
	sprite.visible = true
	sprite_count.visible = false

	sprite.offset.x = 16.0

func _process(delta):
	if countTimer.time_left == 0 && countProgress > 0:
		sprite_count.frame = 1
		countTimer.start()

func _on_timer_timeout():
	countTimer.wait_time =1.8
	print("Baldi is counting! Time left: " + str(countProgress))
	
	if !sprite_count.visible:
		sprite.visible = false
		sprite_count.visible = true

	if countProgress > 0: 
		aud.stream = load(stream_count + str(countProgress) + ".wav")
		aud.play()
	await aud.finished
	sprite_count.frame = 2 if randi() % 10 == 1 else 0
	countProgress -= 1

	if countProgress == 0:
		await get_tree().create_timer(1.5).timeout
		sprite_count.frame = 1
		aud.stream = load("res://plusAssets/AudioClip/BAL_ReadyOrNot.wav")
		aud.play()
		await aud.finished
		chasePlayer()
