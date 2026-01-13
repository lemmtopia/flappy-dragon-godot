extends CanvasLayer

@onready var gold_label: Label = $GoldLabel

func _ready() -> void:
	get_parent().connect("gold_changed", _on_main_gold_changed)
	gold_label.text = str(Globals.gold)

func _on_main_gold_changed():
	gold_label.text = str(Globals.gold)
