extends TextureButton

@onready var blueberry = $Blueberry
@onready var pill = $Pill



var globals_keys = [
	"inventory1item",
	"inventory2item",
	"inventory3item"
]

var items_that_exist = [
	"blueberry",
	"pill"
]

var items = [
	
]

var slot_index: int = 0 



func _ready():
	items = [
		blueberry,
		pill
	]


func _process(_delta):
	show_item()

func show_item():
	var item_name = Globals.get(globals_keys[slot_index])
	
	for j in range(items_that_exist.size()):
		items[j].visible = (item_name == items_that_exist[j])
