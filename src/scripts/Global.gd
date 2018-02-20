extends Node2D

#
# Global
# Team: Manuel Martinez Martin, Sergi Marti Sugrañes, Gerard Llado Masip
# Copyright 2017, SMGames - Escola del Treball
#

const GAME_VER = "1.5e"

## PLAYER SCRIPT ##
var player_script = preload("res://scripts/Player.gd")

## MENU SCENES ##
var menu_scene = preload("res://scenes/Menu.tscn")
var about_scene = preload("res://scenes/About.tscn")
var options_scene = preload("res://scenes/Options.tscn")
var credits_scene = preload("res://scenes/Credits.tscn")
var howtoplay_scene = preload("res://scenes/HowToPlay.tscn")
var levels_scene = preload("res://scenes/Levels.tscn")

# declare variables
var password = "12-ba_na_na-12" #Encrypt Password

var dataPath = OS.get_data_dir() + "/Data/"

var time

var musicVolume = 1.0
var soundVolume = 1.0

var levelTimes = ["00:00:00","00:00:00","00:00:00","00:00:00","00:00:00",
					"00:00:00","00:00:00","00:00:00","00:00:00","00:00:00",
					"00:00:00","00:00:00","00:00:00","00:00:00","00:00:00",
					"00:00:00","00:00:00","00:00:00"]

var current_lang

var mute

## VALID LANGUAGES ##
var es = "es"
var en = "en"
var ca = "ca"

func _ready():
	
	if (OS.get_name() == "Android"):
		get_tree().set_auto_accept_quit(false)#disable android quit
	
	# determine if directory exists and if not exists create it.
	var dir = Directory.new()
	if !dir.dir_exists(dataPath):
		dir.open(dataPath)
		dir.make_dir(dataPath)
		
	load_game("gameData")
	load_gameVol("gameVol")
	
	if (current_lang == null):
		var default_lang = OS.get_locale().substr(0,2)
		if (default_lang != es && default_lang != en && default_lang != ca):
			TranslationServer.set_locale(en)
		else:
			TranslationServer.set_locale(OS.get_locale())
	else:
		TranslationServer.set_locale(current_lang)
	
	if(mute):
		AudioServer.set_fx_global_volume_scale(0)
		AudioServer.set_stream_global_volume_scale(0)
	else:
		AudioServer.set_fx_global_volume_scale(soundVolume)
		AudioServer.set_stream_global_volume_scale(musicVolume)

# save the game
func save_game(var fileName):
	# create a file object
	var saveData = File.new()
	saveData.open_encrypted_with_pass(dataPath + fileName + ".smg", File.WRITE, password)
	
	# create a a dictionary to store data
	var data = {
		levelTimes = levelTimes,
		current_lang = current_lang
	}
	
	# write data to JSON file
	saveData.store_line(data.to_json())
	saveData.close()
	
func save_gameVol(var fileName):
	# create a file object
	var saveData = File.new()
	saveData.open_encrypted_with_pass(dataPath + fileName + ".smg", File.WRITE, password)
	
	# create a a dictionary to store data
	var data = {
		musicVolume = musicVolume,
		soundVolume = soundVolume,
		mute = mute
	}
	
	# write data to JSON file
	saveData.store_line(data.to_json())
	saveData.close()

# load the game
func load_game(var fileName):
	# create a file
	var loadGame = File.new()
	
	# see if the file exists before opening it
	if !loadGame.file_exists(dataPath + fileName + ".smg"):
		#print ("File not found!")
		return

	# empty dictionary to assign temporary data
	var currentLine = {}

	# read data from file
	loadGame.open_encrypted_with_pass(dataPath + fileName + ".smg", File.READ, password)
	while(!loadGame.eof_reached()):
		
		# currentLine to parse through the file
		currentLine.parse_json(loadGame.get_line())
		
		# assign the data to the variables
		if (currentLine.has("levelTimes")):
			levelTimes = currentLine["levelTimes"]
		if (currentLine.has("current_lang")):
			current_lang = currentLine["current_lang"]
		
	loadGame.close()
	
	# for testing
	#print("file path: ", OS.get_data_dir())
	#print("levelTimes: ", levelTimes)
	#print("lang: ", current_lang)
	
func load_gameVol(var fileName):
	# create a file
	var loadGame = File.new()
	
	# see if the file exists before opening it
	if !loadGame.file_exists(dataPath + fileName + ".smg"):
		#print ("File not found!")
		return

	# empty dictionary to assign temporary data
	var currentLine = {}

	# read data from file
	loadGame.open_encrypted_with_pass(dataPath + fileName + ".smg", File.READ, password)
	while(!loadGame.eof_reached()):
		
		# currentLine to parse through the file
		currentLine.parse_json(loadGame.get_line())
		
		# assign the data to the variables
		if (currentLine.has("musicVolume")):
			musicVolume = currentLine["musicVolume"]
		if (currentLine.has("soundVolume")):
			soundVolume = currentLine["soundVolume"]
		if (currentLine.has("mute")):
			mute = currentLine["mute"]
		
	loadGame.close()
	
	# for testing
	#print("file path: ", OS.get_data_dir())
	#print("musicVolume: ", musicVolume)
	#print("soundVolume: ", soundVolume)
	#print("mute: ", mute)

# compare two String times in format 00:00:00
func compare_Strings_Time(time, time2):
	var temp = time.split(":")
	var temp2 = time2.split(":")
	var temp3 = int(temp[0]+temp[1]+temp[2])
	var temp4 = int(temp2[0]+temp2[1]+temp2[2])
	
	if(temp3 < temp4):
		return true
	else:
		return false
