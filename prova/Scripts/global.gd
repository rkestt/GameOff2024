extends Node

var debug
var isPaused = false

func freezeOnSpot():
	print("SONO ENTRATO IN FreezeOnSpot!!!")
	isPaused = !isPaused
	for entity in get_tree().get_nodes_in_group("Entity"):
		# entity.set_process(!isPaused) #Disabilita process
		entity.set_physics_process(!isPaused) #Disablita phy process
		
		# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		##Se ha delle animazioni blocca anche quelle
		#if entity.has_node("AnimatedSprite2D"):
			#var sprite = entity.get_node("AnimatedSprite2D")
			#sprite.playing = !isPaused  # Pausa o riprende l'animazioneone
