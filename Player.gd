extends KinematicBody2D


const GRAVITY = 900
var walkspeed = 320
var refinedlocation
var hasdoublejump = 0
const JUMP_POWER = 690
var velocity = Vector2()
#Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	GlobalVars.playerlocation = get_global_position()
	refinedlocation = (GlobalVars.playerlocation).x/500
	walkspeed = 405 + pow(refinedlocation,1.1)
	GlobalVars.playerspeed = walkspeed
	velocity.x = walkspeed
	if !is_on_floor():
		velocity.y += pow((delta * GRAVITY),1.05)
	# LEFT AND RIGHT FOR DEBUGGING
	#if Input.is_action_pressed("ui_right"):
		#velocity.x = walkspeed
	#if Input.is_action_pressed("ui_left"):
		#velocity.x = -walkspeed
	if is_on_floor():
		if walkspeed != 0:
			$AnimatedSprite.play("run")
		hasdoublejump = 0
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -JUMP_POWER
			$AnimatedSprite.play("jump")
		elif hasdoublejump  == 0:
			$AnimatedSprite.play("double")
			velocity.y = -JUMP_POWER
			hasdoublejump = 1
			
		
	
	move_and_slide(velocity, Vector2(0,-1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
