extends Button

func _ready() -> void:
	SignalBus.start_wave.connect(start_wave)
	SignalBus.end_wave.connect(end_wave)
	
func end_wave():
	disabled = false
	
func start_wave():
	disabled = true
