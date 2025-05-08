extends Control

@onready var host: Control = $Content/ScreenGridVertical/Users/ScreenGridHorizontal/Host
@onready var user_2: Control = $Content/ScreenGridVertical/Users/ScreenGridHorizontal/User2
@onready var btn_state_room: Button = $Content/ScreenGridVertical/btnStateRoom
@onready var bloq_btn: Control = $Content/ScreenGridVertical/btnStateRoom/bloq_btn

var is_ready = false

const DEFAULT_COLOR = Color.WHITE

func _ready() -> void:
	host.update_ready(is_ready)
	btn_state_room.connect("pressed",set_room_state.bind("confirm"))
	set_room_state("ready")
	set_color_font_default()

func set_host_attrs():
	host.start_setup(AppManager.account_controller.data_user)
	user_2.username.set_text("Inimigo")

func set_room_state(new_state):
	match new_state:
		"seeking":
			set_seeking()
		"ready":
			set_ready()
		"confirm":
			set_confirm()

func set_seeking():
	var new_text = "Esperando Jogador..."
	set_setup_btn_state(new_text,true)
	change_bloq(true)
	change_ready(false)

func set_ready():
	var new_text = "Confirmar"
	set_setup_btn_state(new_text,false)
	change_bloq(false)
	change_ready(true)

func set_confirm():
	var new_text = "Confirmado com Sucesso"
	var new_color = Color.GREEN
	set_color_font(new_color,"disabled")
	set_setup_btn_state(new_text,true)
	change_bloq(true)

func change_ready(bool):
	is_ready = bool
	host.update_ready(is_ready)

func change_bloq(bool):
	bloq_btn.visible = bool

func set_setup_btn_state(new_text,is_disabled):
	btn_state_room.text = new_text
	btn_state_room.disabled = is_disabled

func set_color_font(new_color,type):
	match type:
		"normal":
			btn_state_room.set("theme_override_colors/font_color",new_color)
		"disabled":
			btn_state_room.set("theme_override_colors/font_disabled_color",new_color)

func set_color_font_default():
	set_color_font(DEFAULT_COLOR,"disabled")
	set_color_font(DEFAULT_COLOR,"normal")
