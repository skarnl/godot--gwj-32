extends Node2D

var LiveUp = preload('../../entities/1up.tscn')
var Spike = preload('../../entities/spike.tscn')
onready var item_layer = $ItemLayer

var screen_size = Vector2.ZERO
onready var items = $Items

func _ready():
	# setup kill zone
	
	spawn_items()
	

func spawn_items() -> void:
	items.hide()
	
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
			
		print(type)
			
		var pos = items.map_to_world(cell) + items.cell_size/2
		match type:
			'spike':
				var s = Spike.instance()
				s.position = pos
				s.connect('hit_player', self, 'on_player_hit')
			#  s.tile_size = items.cell_size
				item_layer.add_child(s)
			
			'heal':
				var s = LiveUp.instance()
				s.position = pos
				s.connect('hit_1up', self, 'on_player_pickup_1up')
			#  s.tile_size = items.cell_size
				item_layer.add_child(s)
			
			'player_spawn':
				$Player.position = pos
			#  $Player.tile_size = items.cell_siz;

func on_player_hit() -> void:
	print('palyer hit - die die die')
	

func on_player_pickup_1up() -> void:
	print('player pick 1up - increase lives')
	
