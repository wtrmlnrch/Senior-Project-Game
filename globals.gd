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

var inventory1item = ""
var inventory2item = ""
var inventory3item = ""

var inventory_full = false

# stuff for npcs
var is_talking_to_npc = false
var npc_interacting_with = ""

# ui stuff for tasks
var day = 1
var night = 0
var is_night = false
# doctor, robert, baker, garroth, sibling, holly, leader, butcher
var npcs_talked_to_today = [false, false, false, false, false, false, false, false]
var holly_is_dead = false


var day_task_complete = [false, false, false]
var all_tasks_day = false
var all_tasks_night = false
var night_task_complete = [false, false, false]
