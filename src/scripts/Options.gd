extends Node

#
# Options
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

var title
var media

var musicVol
var soundVol

var background
var image

var sample

var lang

var esLang
var caLang
var enLang
var sysLang

func _ready():
	set_name(GlobalMusic.menu)
	
	title = get_node("Controls/Main")
	media = get_node("Controls/Media")
	background = get_node("Controls/Background")
	lang = get_node("Controls/Lang")
	image = background.get_node("Image")
	
	esLang = lang.get_node("Spanish")
	enLang = lang.get_node("English")
	caLang = lang.get_node("Catalan")
	sysLang = lang.get_node("System")
	
	esLang.connect("pressed",self,"_changeLang",["es"])
	enLang.connect("pressed",self,"_changeLang",["en"])
	caLang.connect("pressed",self,"_changeLang",["ca"])
	sysLang.connect("pressed",self,"_changeLang",["sys"])
	
	sample = get_node("Sample")
	
	_fixControls()
	
	#No need using keep widht and height
	#get_tree().connect("screen_resized",self,"_fixControls")
	
	musicVol = media.get_node("MusicVol")
	soundVol = media.get_node("SoundVol")
	
	musicVol.connect("value_changed",self,"_on_MusicVol_value_changed")
	soundVol.connect("value_changed",self,"_on_SoundVol_value_changed")
	
	musicVol.set_value(Global.musicVolume)
	soundVol.set_value(Global.soundVolume)
	
	if (GlobalMusic.get_stream() != GlobalMusic.menu_song):
		GlobalMusic.set_stream(GlobalMusic.menu_song)
		GlobalMusic.play()

	_settingLang()
	
func _settingLang():
	## SETTING LANGUAGE ##
	get_node("Controls/Main/Title").set_text(tr("MENU_OPTIONS"))
	get_node("Controls/Main/Volume").set_text(tr("OPTIONS_VOLUME"))
	get_node("Controls/Media/MusicVol/Music").set_text(tr("OPTIONS_MUSIC"))
	get_node("Controls/Media/SoundVol/Sound").set_text(tr("OPTIONS_SOUND"))


#Fix all the button positions
func _fixControls():
	image.set_size(get_viewport_rect().size)
	
	title.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	media.set_pos(Vector2(get_viewport_rect().size.x/2, 0))
	lang.set_pos(Vector2(0, 0))
	background.set_pos(Vector2(0,0))

func _on_MusicVol_value_changed(value):
	if (Global.musicVolume != musicVol.get_value()):
		Global.musicVolume = musicVol.get_value()
		_mute()

func _on_SoundVol_value_changed(value):
	if (Global.soundVolume != soundVol.get_value()):
		Global.soundVolume = soundVol.get_value()
		sample.play("jump")
		_mute()

func _mute():
	AudioServer.set_stream_global_volume_scale(Global.musicVolume)
	AudioServer.set_fx_global_volume_scale(Global.soundVolume)
	if(Global.musicVolume == 0 && Global.soundVolume == 0):
		Global.mute = true
	else:
		Global.mute = false
	Global.save_gameVol("gameVol")

func _changeLang(id):
	GlobalSample.pressBtn("buttonPressed")
	if (id == Global.es):
		TranslationServer.set_locale(Global.es)
		Global.current_lang = Global.es
	elif (id == Global.ca):
		TranslationServer.set_locale(Global.ca)
		Global.current_lang = Global.ca
	elif (id == Global.en):
		TranslationServer.set_locale(Global.en)
		Global.current_lang = Global.en
	elif (id == "sys"):
		var default_lang = OS.get_locale().substr(0,2)
		
		if(default_lang != Global.es && default_lang != Global.en && default_lang != Global.ca):
			default_lang = Global.en
		
		TranslationServer.set_locale(default_lang)
		
		Global.current_lang = null
		
	_settingLang()
	
	Global.save_game("gameData")