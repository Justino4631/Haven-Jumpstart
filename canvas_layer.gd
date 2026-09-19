extends CanvasLayer

@onready var label: Label = $Label

var score: int = 0
var collected_items: Array[String] = []

func update_display() -> void:
	var text_content = "Score: " + str(score) + "\n"
	text_content += "Collected:\n"
	for item in collected_items:
		text_content += "- " + item + "\n"
	
	label.text = text_content

func add_collectible(collectible_node: Node) -> void:
	score += 1
	var item_name = collectible_node.get_parent().name
	collected_items.append(item_name)
	
	update_display()
