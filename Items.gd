extends Area2D

onready var sprites = [$Power_upTV, $Power_up2Tv, $Power_up3Tv, $Power_downTV, $Power_down2TV, $Power_down3TV, $Power_upBruja, $Power_up2Bruja, $Power_up3Bruja, $Power_downBruja, $Power_down2Bruja, $Power_down3Bruja, $Power_upPayaso, $Power_up2Payaso, $Power_up3Payaso, $Power_downPayaso, $Power_down2Payaso, $Power_down3Payaso, $Power_upAstronauta, $Power_up2Austronauta,  $Power_up3Astronauta, $Power_downAstronauta, $Power_down2Astronauta,  $Power_down3Astronauta]
func ver_item(index):
	print(index)
	sprites[index].visible = true

func _ready():
	var v=0
	for n in range(24):
		sprites[n].visible = false
		randomize()
		v=randi() % 25
	ver_item(v)
