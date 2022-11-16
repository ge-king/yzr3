extends TileMap

var newtilex
var tilecounter = 0
var newtile = 1
var newtilexjump = 0
var tiledestroy
var newtiley = 14
var newtilecheck = 0
var blockerpresent = 1
var rng = RandomNumberGenerator.new()
func _init():
	rng.randomize()
	set_occluder_light_mask(1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(newtile)
	tiledestroy = floor(GlobalVars.playerlocation.x/130)-15
	newtilex = floor(GlobalVars.playerlocation.x/130) + 13
	if get_cell(newtilex,newtiley) == INVALID_CELL:
		set_cell(newtilex,newtiley,newtile)
		if blockerpresent == 1:
			set_cell(newtilex + rng.randi_range(2,5),newtiley - 1, 2)
			blockerpresent = 0
		tilecounter += 1
		if tilecounter > rng.randi_range(5,15) and newtile==0:
			newtile = 100
			tilecounter = 0
		elif tilecounter > rng.randi_range(5,15) and newtile==1:
			newtile = 100
			tilecounter = 0
		elif tilecounter > rng.randi_range(1,5) and newtile==100:
			newtile = rng.randi_range(0,1)
			blockerpresent = rng.randi_range(0,4)
			tilecounter = 0
			for i in range(11,18):
				if newtiley == i:
					newtiley += rng.randi_range(12-i,16-i)
	if get_cell(newtilex,newtiley) == 0:
		for n in range(newtiley+1,30):
			set_cell(newtilex,n,0)
		for n in range(newtiley,28,3):
			update_bitmask_area(Vector2(newtilex, n))
	if get_cell(newtilex,newtiley) == 1:
		for n in range(newtiley+1,30):
			set_cell(newtilex,n,1)
		for n in range(newtiley,28,3):
			update_bitmask_area(Vector2(newtilex, n))
	if get_cell(tiledestroy,18) != INVALID_CELL:
		for n in range (11,30):
			set_cell(tiledestroy,n,-1)
	
