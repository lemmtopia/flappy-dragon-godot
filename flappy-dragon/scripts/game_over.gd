extends CanvasLayer

signal restart_game
signal quit

func _on_restart_button_pressed() -> void:
	restart_game.emit()

func _on_quit_button_pressed() -> void:
	quit.emit()
