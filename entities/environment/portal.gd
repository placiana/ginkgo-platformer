extends Area2D

signal player_entered

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") or body.name.to_lower().contains("player") or body.name.to_lower().contains("ginkgo") or body.name.to_lower().contains("raul") or body.name.to_lower().contains("steve"):
		player_entered.emit()
