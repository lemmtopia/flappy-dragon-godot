extends CanvasLayer

@onready var gold_label: Label = $GoldLabel

@export var is_in_main_scene : bool = false

func _ready() -> void:
	if is_in_main_scene:
		get_parent().connect("gold_changed", _on_main_gold_changed)
	gold_label.text = str(Globals.gold)

func _on_main_gold_changed():
	gold_label.text = str(Globals.gold)
