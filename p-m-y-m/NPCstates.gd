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
			},
			
			"npc_pescador": {
		"current_state" : "sobrio_sin_info_no_conversado",
		"states": {
			"sobrio_sin_info_no_conversado" : {},
			"sobrio_sin_info_conversado" : {},
			"sobrio_con_info_no_conversado": {},
			"sobrio_con_info_conversado": {},
			"borracho_sin_info" : {},
			"borracho_con_info_sin_ayuda_no_conversado" : {},
			"borracho_con_info_sin_ayuda_conversado": {},
			"borracho_con_info_con_ayuda": {},
			"ya_conversado": {}
				}
			},
			"npc_cajera": {
		"current_state" : "no_interactuado",
		"states": {
			"no_interactuado" : {"location" : "bar"},
			"interactuado" : {"location" : "bar"}
				}
			}
}
