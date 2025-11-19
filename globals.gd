extends Node

# hunger I guess
var hunger: float = 100.0
var max_hunger: int = 100
var hunger_loss: float = 1.0
# health 
var health: float = 100.0
var max_health: int = 100
# inventory moment
var inventory1active = false
var inventory2active = false
var inventory3active = false
var inventory4active = false
var inventory5active = false

var inventory1item = ""
var inventory2item = ""
var inventory3item = ""
var inventory4item = ""
var inventory5item = ""

var inventory_full = false

# stuff for npcs
var is_talking_to_npc = false
var npc_interacting_with = ""
