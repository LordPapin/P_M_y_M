extends Node

var npcs = {
	"npc1": {
		"current_state" : "no_interactuado",
		"states": {
			"no_interactuado" : {"location" : "bar"},
			"no_sobornado" : {"location" : "bar"},
			"robado" : {"location" : "bar"},
			"sobornado" : {"location" : "ninguna"}
				}
			},

"luther_minijuego_2": {
	"current_state": "no_interactuado",
	"states": {
		#"no_advertido": {},
		#"advertido": {},
		"caminando": {},
		"invisible": {},
		"respirando": {},
		"aliviado": {}
		}
		},
		
		"npc_barman": {
		"current_state" : "no_interactuado_sin_billetes",
		"states": {
			"no_interactuado_sin_billetes" : {"location" : "bar"},
			"interactuado_sin_billetes" : {"location" : "bar"},
			"con_billetes": {"location" : "bar"}
				}
			}
}
