script_name("GhettoMate")
script_author("Vlaek")
script_version('17/06/2020')
script_version_number(1)
script_url("https://vlaek.github.io/GhettoMate/")
script.update = false

local sampev, inicfg, imgui, encoding, bass = require 'lib.samp.events', require 'inicfg', require 'imgui', require 'encoding', require "lib.bass"
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local directIni = "\\GhettoMate\\GhettoMate.ini"
local directIni2 = "\\GhettoMate\\GhettoMateMoney.ini"
local directIni3 = "\\GhettoMate\\GhettoMateTime.ini"
local directIni4 = "\\GhettoMate\\GhettoMateSettings.ini"
local ini = {}
local ini2 = {}
local ini3 = {}
local ini4 = {}

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

local resX, resY = getScreenResolution()
local main_color = 0x323232

local Magaz1  = true
local Magaz2  = false
local Magaz3  = false
local Magaz4  = false
local Magaz5  = false
local Magaz6  = false
local Magaz7  = false
local Magaz8  = false
local Magaz9  = false
local Magaz10 = false
local Magaz11 = false
local Magaz12 = false
local Magaz13 = false
local Magaz14 = false
local Magaz15 = false
local Magaz16 = false

local timerMagaz = {u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно", }

local oneHour = 3600
local ServerHour = 0
local hour = 0
local hour2 = 0
local minute = 0
local second = 0
local totalSeconds = 0
local InterfacePosition = true

local timerM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local hourM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local minuteM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local secondM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local totalSecondsM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local color = {"{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}"}
local MagazTime = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false}

local timer = false
local sideTimer = false
local CalibrationA = false
local interface = false
--AutoGetGuns--
local GetGuns = false
--Sucher--
local Find = false
local NotFound = false
local Found = false
local WasFound = false
local Id = nil
--UGONYALA--
local ugontimer = 0
local ugtimer = 0
local mark, ugcheckpoint = nil, nil
local marks, ugcheckpoints = {}, {}
local vehlist = {}
local notify = false
local search = false

local vehnames = {
  "Landstalker","Bravura","Buffalo","1","Perenniel","Sentinel","1","1","1","1","1","Infernus",
  "Voodoo","1","1","Cheetah","1","Leviathan","Moonbeam","Esperanto","1","Washington","Bobcat","1","BF Injection",
  "Hunter","Premier","1","1","Banshee","1","1","1","1","Hotknife","1","Previon","1","1",
  "Stallion","1","1","1","1","1","Admiral","1","1","1","1","1","Turismo","1",
  "1","1","1","1","1","Solair","1","1","PCJ-600","1","Freeway","1","1",
  "Glendale","Oceanic","Sanchez","1","1","Quad","1","1","Hermes","Sabre","1","ZR-350","Walton","Regina",
  "Comet","1","1","1","1","1","1","1","1","Rancher","1","Virgo","Greenwood",
  "1","Hotring Racer","Sandking","Blista Compact","1","1","1","1","1","Hotring Racer A","Hotring Racer B",
  "1","Rancher","Super GT","Elegant","Journey","1","1","1","1","1","1","1",
  "Nebula","Majestic","Buccaneer","1","1","FCR-900","NRG-500","1","1","1","Fortune","Cadrona","1",
  "Willard","1","1","1","Feltzer","Remington","Slamvan","Blade","1","1","1","Vincent","Bullet","Clover",
  "Sadler","1","Hustler","Intruder","Primo","1","Tampa","Sunrise","Merit","1","1","Yosemite","Windsor","1",
  "1","Uranus","Jester","Sultan","Stratum","Elegy","1","1","Flash","Tahoma","Savanna","1","1","1",
  "1","1","1","1","Broadway","Tornado","1","1","Huntley","Stafford","BF-400","1","1","1","Emperor",
  "Wayfarer","Euros","1","Club","1","1","1","1","1","1","1","1",
  "1","1","Picador","1","Alpha","Phoenix","Glendale","Sadler","1","1",
  "1","1","1","1"
}

local vehclasses= {
  ["Landstalker"] = "N", ["Perenniel"] = "N",   ["Previon"] = "N", ["Stallion"] = "N",   ["Solair"] = "N", ["Glendale"] = "N",
  ["Sabre"] = "N", ["Walton"] = "N",   ["Regina"] = "N", ["Greenwood"] = "N",   ["Nebula"] = "N", ["Majestic"] = "N",
  ["Buccaneer"] = "N", ["Fortune"] = "N",   ["Cadrona"] = "N", ["Clover"] = "N",   ["Sadler"] = "N", ["Intruder"] = "N",
  ["Primo"] = "N", ["Tampa"] = "N",   ["Savanna"] = "N", ["Bravura"] = "D",  ["Sentinel"] = "D",  ["Voodoo"] = "D",
  ["Bobcat"] = "D",   ["Premier"] = "D",  ["Oceanic"] = "D",  ["Hermes"] = "D",  ["Blista Compact"] = "D",
  ["Elegant"] = "D",  ["Willard"] = "D",  ["Blade"] = "D",  ["Vincent"] = "D",  ["Sunrise"] = "D",  ["Merit"] = "D",
  ["Tahoma"] = "D",  ["Broadway"] = "D",  ["Tornado"] = "D",  ["Emperor"] = "D",  ["Picador"] = "D",
  ["Moonbeam"] = "C", ["Esperanto"] = "C", ["Washington"] = "C", ["Admiral"] = "C", ["Rancher"] = "C", ["Virgo"] = "C",
  ["Feltzer"] = "C", ["Remington"] = "C", ["Yosemite"] = "C", ["Windsor"] = "C", ["Stratum"] = "C", ["Huntley"] = "C",
  ["Stafford"] = "C", ["Phoenix"] = "C", ["PCJ-600"] = "C", ["BF-400"] = "C", ["Wayfarer"] = "C",  ["ZR-350"] = "B",
  ["Comet"] = "B", ["Slamvan"] = "B", ["Hustler"] = "B", ["Uranus"] = "B", ["Jester"] = "B", ["Sultan"] = "B",
  ["Elegy"] = "B", ["Flash"] = "B", ["Euros"] = "B", ["Alpha"] = "B", ["FCR-900"] = "B", ["Freeway"] = "B", ["Sanchez"] = "B",
  ["Quad"] = "B",  ["Buffalo"] = "A", ["Infernus"] = "A", ["Cheetah"] = "A", ["Banshee"] = "A", ["Turismo"] = "A",
  ["Super GT"] = "A", ["Bullet"] = "A", ["NRG-500"] = "A", ["Hotknife"] = "A", ["BF Injection"] = "A", ["Sandking"] = "A",
  ["Hotring Racer"] = "A", ["Hotring Racer A"] = "A", ["Hotring Racer B"] = "A"
}

secta = {[12]="А",[11]="Б",[10]="В",[9]="Г",[8]="Д",[7]="Ж",[6]="З",[5]="И",[4]="К",[3]="Л",[2]="М",[1]="Н",
[0]="О",[-1]="П",[-2]="Р",[-3]="С",[-4]="Т",[-5]="У",[-6]="Ф",[-7]="Х",[-8]="Ц",[-9]="Ч",[-10]="Ш",[-11]="Я"}

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	repeat wait(0) until sampGetCurrentServerName() ~= 'SA-MP'
	repeat 
		wait(0)
		for id = 0, 2303 do
			if sampTextdrawIsExists(id) and sampTextdrawGetString(id):find('Samp%-Rp.Ru') then
				samp_rp = true
			end
		end
	until samp_rp ~= nil

  local radio = bass.BASS_StreamCreateFile(false,getWorkingDirectory()..'/rsc/notify.mp3', 0, 0, 0)
  bass.BASS_ChannelSetAttribute(radio, BASS_ATTRIB_VOL, 20)
	
	_, my_id = sampGetPlayerIdByCharHandle(PLAYER_PED) 
	my_name = sampGetPlayerNickname(my_id)
	server = sampGetCurrentServerName():gsub('|', '')
	server = (server:find('02') and 'Two' or (server:find('Revolution') and 'Revolution' or (server:find('Legacy') and 'Legacy' or (server:find('Classic') and 'Classic' or ''))))
	if server == '' then thisScript():unload() end
	
	sampRegisterChatCommand("lhud", cmd_hud)
	sampRegisterChatCommand("gsucher", cmd_sucher)
	sampRegisterChatCommand('GhettoMate', function()
		ShowDialog(20)
	end)
	sampRegisterChatCommand('larek', function()
		ShowDialog(1)
	end)
	Wait = lua_thread.create_suspended(Waiting)
	Wait2 = lua_thread.create_suspended(Waiting2)
	DrugsWait = lua_thread.create_suspended(DrugsWaiting)
	
	AdressConfig = string.format("%s\\moonloader\\config", getGameDirectory())
	AdressGhettoMate = string.format("%s\\moonloader\\config\\GhettoMate", getGameDirectory())
	if not doesDirectoryExist(AdressConfig) then createDirectory(AdressConfig) end
	if not doesDirectoryExist(AdressGhettoMate) then createDirectory(AdressGhettoMate) end
	
	GhettoMateName = string.format('GhettoMateName')
	if ini[GhettoMateName] == nil then
		ini = inicfg.load({
			[GhettoMateName] = {
				Name1  = u8:decode"Деревня 1",
				Name2  = u8:decode"Деревня 2",
				Name3  = u8:decode"Вайнвуд",
				Name4  = u8:decode"Гетто",
				Name5  = u8:decode"Чиллиад",
				Name6  = u8:decode"Квартиры СФ",
				Name7  = u8:decode"СФ Топ",
				Name8  = u8:decode"Около фермы",
				Name9  = u8:decode"СФа",
				Name10 = u8:decode"СФ Бот",
				Name11 = u8:decode"Форт Карсон",
				Name12 = u8:decode"СТО ЛВ",
				Name13 = u8:decode"ЛВПД",
				Name14 = u8:decode"МО ЛВ",
				Name15 = u8:decode"ЛВ Ньюс",
				Name16 = u8:decode"АММО ЛВ"
			}
		}, directIni)
		inicfg.save(ini, directIni)
	end
	
	GhettoMateConfig = string.format('GhettoMateConfig')
	if ini[GhettoMateConfig] == nil then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Откалибруйте время в /GhettoMate", main_color)
		ini = inicfg.load({
			[GhettoMateConfig] = {
				time = tonumber(0),
				X = tonumber(0),
				Y = tonumber(0)
			}
		}, directIni)
		inicfg.save(ini, directIni)
	end
	
	GhettoMateMoney = string.format('GhettoMateMoney-%s', my_name)
	if ini2[GhettoMateMoney] == nil then
		ini2 = inicfg.load({
			[GhettoMateMoney] = {
				money  = tonumber(0),
				count  = tonumber(0),
				count1 = tonumber(0),
				count2 = tonumber(0),
				count3 = tonumber(0),
				count4 = tonumber(0)
			}
		}, directIni2)
		inicfg.save(ini2, directIni2)
	end
	
	GhettoMateTime = string.format('GhettoMateTime-Server-%s', server)
	if ini3[GhettoMateTime] == nil then
		ini3 = inicfg.load({
			[GhettoMateTime] = {
				time1  = u8:decode"Неизвестно",
				time2  = u8:decode"Неизвестно",
				time3  = u8:decode"Неизвестно",
				time4  = u8:decode"Неизвестно",
				time5  = u8:decode"Неизвестно",
				time6  = u8:decode"Неизвестно",
				time7  = u8:decode"Неизвестно",
				time8  = u8:decode"Неизвестно",
				time9  = u8:decode"Неизвестно",
				time10 = u8:decode"Неизвестно",
				time11 = u8:decode"Неизвестно",
				time12 = u8:decode"Неизвестно",
				time13 = u8:decode"Неизвестно",
				time14 = u8:decode"Неизвестно",
				time15 = u8:decode"Неизвестно",
				time16 = u8:decode"Неизвестно"
			}
		}, directIni3)
		inicfg.save(ini3, directIni3)
	end
	
	GhettoMateSeconds = string.format('GhettoMateSeconds-Server-%s', server)
	if ini3[GhettoMateSeconds] == nil then
		ini3 = inicfg.load({
			[GhettoMateSeconds] = {
				time1  = tonumber(0),
				time2  = tonumber(0),
				time3  = tonumber(0),
				time4  = tonumber(0),
				time5  = tonumber(0),
				time6  = tonumber(0),
				time7  = tonumber(0),
				time8  = tonumber(0),
				time9  = tonumber(0),
				time10 = tonumber(0),
				time11 = tonumber(0),
				time12 = tonumber(0),
				time13 = tonumber(0),
				time14 = tonumber(0),
				time15 = tonumber(0),
				time16 = tonumber(0)
			}
		}, directIni3)
		inicfg.save(ini3, directIni3)
	end
	
	GhettoMateSettings = string.format('GhettoMateSettings-%s', my_name)
	if ini4[GhettoMateSettings] == nil then
		ini4 = inicfg.load({
			[GhettoMateSettings] = {
				NotifyLarek=true,
				TimerNotifyLarek=tonumber(15),
				NotifyUgonyala=true,
				AnimUgonyala=true,
				IdAnimUgonyala=tonumber(14),
				NotifyFind=true,
				NotifyDrugs=true
			}
		}, directIni4)
		inicfg.save(ini4, directIni4)
	end
	
	ini = inicfg.load(GhettoMateConfig, directIni)
	ini = inicfg.load(GhettoMateName, directIni)
	ini2 = inicfg.load(GhettoMateMoney, directIni2)
	ini3 = inicfg.load(GhettoMateTime, directIni3)
	ini4 = inicfg.load(GhettoMateSettings, directIni4)
	
	checkUpdates()
	sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Успешно загрузился!", main_color)
	
	imgui.ApplyCustomStyle()
	imgui.Process = true
	
	while true do
		wait(250)
		
		imgui.ShowCursor = false
		
		if main_window_state.v == false then
			imgui.Process = false
		end
		
		if interface == true then
			main_window_state.v = true
			imgui.Process = main_window_state.v
		else
			main_window_state.v = false
		end
		if isKeyJustPressed(VK_MULTIPLY) then
			cmd_autogetguns()
		end
		GhettoMateConfig = string.format('GhettoMateConfig')
		ini = inicfg.load(GhettoMateConfig, directIni)
		hour = os.date("%H") + ini[GhettoMateConfig].time
		hour2 = os.date("%H")
		if hour == -1 then
			hour = 23
		end
		if hour == -2 then
			hour = 22
		end
		if hour == -3 then
			hour = 21
		end
		if hour == -4 then
			hour = 20
		end
		if hour == -5 then
			hour = 23
		end
		if hour == -6 then
			hour = 19
		end
		minute = os.date("%M")
		second = os.date("%S")
		totalSeconds = hour * 3600 + minute * 60 + second
		
		Timer()
		TimerM()
		Refresh()
		
		local caption = sampGetDialogCaption()
		local result, button, list, input = sampHasDialogRespond(1000)
		if caption == u8:decode'GhettoMate: Список' then
			if result and button == 1 then
				if dialogLine[list + 1]     ==  u8:decode'  1. Larek\t' then
					ShowDialog(1)
				elseif dialogLine[list + 1] ==  u8:decode'  2. AutoGetGuns\t' .. (GetGuns and '{06940f}ON' or '{d10000}OFF') then
					cmd_autogetguns()
					ShowDialog(20)
				elseif dialogLine[list + 1] ==  u8:decode'  3. Find\t'  .. (Find and '{06940f}ON' or '{d10000}OFF') then
					Find = false
					deleteCheckpoint(checkpoint)
					removeBlip(blip)
					ShowDialog(21)
				elseif dialogLine[list + 1] ==  u8:decode'  4. Ugonyala\t' .. (search and '{06940f}ON' or '{d10000}OFF') then
					sampSendChat("/fc")
					ShowDialog(22)
				elseif dialogLine[list + 1] ==  u8:decode'> Настройки\t' then
					ShowDialog(23)
				else
					ShowDialog(20)
				end
			end
		end

		local result, button, list, input = sampHasDialogRespond(1003)
		if caption == u8:decode'Настройки' then
			if result then
				if button == 1 then
					if dialogLine[list + 1]     ==  u8:decode'  1. Уведомления от Larek\t' .. (ini4[GhettoMateSettings].NotifyLarek and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyLarek = not ini4[GhettoMateSettings].NotifyLarek
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode'  2. Таймер уведомлений Larek\t' .. ini4[GhettoMateSettings].TimerNotifyLarek then
						ShowDialog(24)
						inicfg.save(ini4, directIni4)
					elseif dialogLine[list + 1] ==  u8:decode'  3. Уведомления от Ugonyala\t' .. (ini4[GhettoMateSettings].NotifyUgonyala and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyUgonyala = not ini4[GhettoMateSettings].NotifyUgonyala
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode'  4. Анимация угона\t' .. (ini4[GhettoMateSettings].AnimUgonyala and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].AnimUgonyala = not ini4[GhettoMateSettings].AnimUgonyala
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode'  5. Выбрать анимацию угона\t' .. ini4[GhettoMateSettings].IdAnimUgonyala then
						ShowDialog(25)
						inicfg.save(ini4, directIni4)
					elseif dialogLine[list + 1] ==  u8:decode'  6. Уведомления от Find\t' .. (ini4[GhettoMateSettings].NotifyFind and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyFind = not ini4[GhettoMateSettings].NotifyFind
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode'  7. Уведомления от Drugs\t' .. (ini4[GhettoMateSettings].NotifyDrugs and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyDrugs = not ini4[GhettoMateSettings].NotifyDrugs
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] == (script.update and u8:decode'{06940f}  8. [GhettoMate] Актуальная версия' or u8:decode'{d10000}  8. [GhettoMate] Версия устарела') then
						interface = false
						update()
					else
						ShowDialog(20)
					end
				end
				if button == 0 then
					ShowDialog(20)
				end
			end
		end

		local result, button, list, input = sampHasDialogRespond(1488)
		if caption == u8:decode'Larek: Список' then
			if result then
				if button == 1 then
					if dialogLine[list + 1]     ==  '  1. ' .. ini[GhettoMateName].Name1  .. '\t' .. color[1]  .. ini3[GhettoMateTime].time1 then
						ShowDialog(3, dialogTextToList[list + 1], input, false, 'config', 'MagazName1')
					elseif dialogLine[list + 1] ==  '  2. ' .. ini[GhettoMateName].Name2  .. '\t' .. color[2]  .. ini3[GhettoMateTime].time2 then
						ShowDialog(4, dialogTextToList[list + 1], input, false, 'config', 'MagazName2')
					elseif dialogLine[list + 1] ==  '  3. ' .. ini[GhettoMateName].Name3  .. '\t' .. color[3]  .. ini3[GhettoMateTime].time3 then
						ShowDialog(5, dialogTextToList[list + 1], input, false, 'config', 'MagazName3')
					elseif dialogLine[list + 1] ==  '  4. ' .. ini[GhettoMateName].Name4  .. '\t' .. color[4]  .. ini3[GhettoMateTime].time4 then
						ShowDialog(6, dialogTextToList[list + 1], input, false, 'config', 'MagazName4')
					elseif dialogLine[list + 1] ==  '  5. ' .. ini[GhettoMateName].Name5  .. '\t' .. color[5]  .. ini3[GhettoMateTime].time5 then
						ShowDialog(7, dialogTextToList[list + 1], input, false, 'config', 'MagazName5')
					elseif dialogLine[list + 1] ==  '  6. ' .. ini[GhettoMateName].Name6  .. '\t' .. color[6]  .. ini3[GhettoMateTime].time6 then
						ShowDialog(8, dialogTextToList[list + 1], input, false, 'config', 'MagazName6')
					elseif dialogLine[list + 1] ==  '  7. ' .. ini[GhettoMateName].Name7  .. '\t' .. color[7]  .. ini3[GhettoMateTime].time7 then
						ShowDialog(9, dialogTextToList[list + 1], input, false, 'config', 'MagazName7')
					elseif dialogLine[list + 1] ==  '  8. ' .. ini[GhettoMateName].Name8  .. '\t' .. color[8]  .. ini3[GhettoMateTime].time8 then
						ShowDialog(10, dialogTextToList[list + 1], input, false, 'config', 'MagazName8')
					elseif dialogLine[list + 1] ==  '  9. ' .. ini[GhettoMateName].Name9  .. '\t' .. color[9]  .. ini3[GhettoMateTime].time9 then
						ShowDialog(11, dialogTextToList[list + 1], input, false, 'config', 'MagazName9')
					elseif dialogLine[list + 1] ==  ' 10. ' .. ini[GhettoMateName].Name10 .. '\t' .. color[10] .. ini3[GhettoMateTime].time10 then
						ShowDialog(12, dialogTextToList[list + 1], input, false, 'config', 'MagazName10')
					elseif dialogLine[list + 1] ==  ' 11. ' .. ini[GhettoMateName].Name11 .. '\t' .. color[11] .. ini3[GhettoMateTime].time11 then
						ShowDialog(13, dialogTextToList[list + 1], input, false, 'config', 'MagazName11')
					elseif dialogLine[list + 1] ==  ' 12. ' .. ini[GhettoMateName].Name12 .. '\t' .. color[12] .. ini3[GhettoMateTime].time12 then
						ShowDialog(14, dialogTextToList[list + 1], input, false, 'config', 'MagazName12')
					elseif dialogLine[list + 1] ==  ' 13. ' .. ini[GhettoMateName].Name13 .. '\t' .. color[13] .. ini3[GhettoMateTime].time13 then
						ShowDialog(15, dialogTextToList[list + 1], input, false, 'config', 'MagazName13')
					elseif dialogLine[list + 1] ==  ' 14. ' .. ini[GhettoMateName].Name14 .. '\t' .. color[14] .. ini3[GhettoMateTime].time14 then
						ShowDialog(16, dialogTextToList[list + 1], input, false, 'config', 'MagazName14')
					elseif dialogLine[list + 1] ==  ' 15. ' .. ini[GhettoMateName].Name15 .. '\t' .. color[15] .. ini3[GhettoMateTime].time15 then
						ShowDialog(17, dialogTextToList[list + 1], input, false, 'config', 'MagazName15')
					elseif dialogLine[list + 1] ==  ' 16. ' .. ini[GhettoMateName].Name16 .. '\t' .. color[16] .. ini3[GhettoMateTime].time16 then
						ShowDialog(18, dialogTextToList[list + 1], input, false, 'config', 'MagazName16')
					elseif dialogLine[list + 1] == '> Larek HUD\t' .. (interface and '{06940f}ON' or '{d10000}OFF') then
						interface = not interface
						ShowDialog(1)
					elseif dialogLine[list + 1] == u8:decode'> Фиксация HUDa\t' .. (InterfacePosition and '{06940f}ON' or '{d10000}OFF') then
						InterfacePosition = not InterfacePosition
						inicfg.save(ini, directIni)
						ShowDialog(1)
					elseif dialogLine[list + 1] == u8:decode'> Разница во времени с Samp-RP\t'  then
						Calibration()
						ShowDialog(1)
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Время успешно откалибровано", main_color)
					elseif dialogLine[list + 1] == u8:decode'> Статистика\t'  then
						ShowDialog(19)
					else
						ShowDialog(20)
					end
				end
				if button == 0 then
					ShowDialog(20)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1490)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name1 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1491)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name2 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1492)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name3 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1493)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name4 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1494)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name5 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1495)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name6 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1496)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name7 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1497)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name8 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1498)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name9 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1499)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name10 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1500)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name11 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1501)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name12 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					if button == 0 then
						ShowDialog(20)
					end
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1502)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name13 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1503)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name14 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1504)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name15 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1505)
		if caption == u8:decode"Изменение названия" then
			if result then
				if button == 1 then
					ini[GhettoMateName].Name16 = input
					inicfg.save(ini, directIni)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое название: {FFFF00}" .. input, main_color)
					ShowDialog(1)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1506)
		if caption == u8:decode"Статистика" then
			if result then
				if button == 1 then
					ShowDialog(19)
				else
					ShowDialog(1)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1001)
		if caption == u8:decode"Sucher" then
			if result then
				if button == 1 then
					cmd_sucher(input)
					ShowDialog(20)
				else
					ShowDialog(20)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1002)
		if caption == u8:decode"Ugonyala" then
			if result then
				if button == 1 then
					sampSendChat("/fc " .. input)
					ShowDialog(20)
				else
					ShowDialog(20)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1003)
		if caption == u8:decode"Настройки" then
			if result then
				if button == 1 then
					ShowDialog(20)
				else
					ShowDialog(20)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1004)
		if caption == u8:decode"Таймер" then
			if result then
				if button == 1 then
					ini4[GhettoMateSettings].TimerNotifyLarek = input
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое время таймера составляет: " .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode" секунд", main_color)
					inicfg.save(ini4, directIni4)
					ShowDialog(23)
				else
					ShowDialog(23)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1005)
		if caption == u8:decode"Анимация" then
			if result then
				if button == 1 then
					ini4[GhettoMateSettings].IdAnimUgonyala = input
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новый id анимации: " .. ini4[GhettoMateSettings].IdAnimUgonyala, main_color)
					inicfg.save(ini4, directIni4)
					ShowDialog(23)
				else
					ShowDialog(23)
				end
			end
		end
		if Find then
			Suchen()
		end

	--UGONYALA--
    ugtimer = ugontimer - os.clock()
    charinstream = getAllChars()
    carsinstream = getAllVehicles()
    for i, car in ipairs(carsinstream) do
      for modelid = 400, 611 do
        if vehnames[modelid-399] ~= "1" then
          if isCarModel(car, modelid) then
            result, vehId = sampGetVehicleIdByCarHandle(car)
            driverNickname = nil
            isDriver = false
            for j, ped in ipairs(charinstream) do
              if isCharInCar(ped, car) then
                isDriver, driverId= sampGetPlayerIdByCharHandle(ped)
                driverNickname = sampGetPlayerNickname(driverId)
              end
            end
            posX, posY, posZ = getCarCoordinates(car)
            if getCarDoorLockStatus(car)==2 then
              isRepeat = false
              for k, vehh in ipairs(vehlist) do
                if vehId == vehh[5] then
                  isRepeat = true
                  vehh[2] = posX
                  vehh[3] = posY
                  vehh[4] = posZ
                  vehh[6] = driverNickname
                  vehh[7] = os.clock()
                  if carname then
                    if string.lower(carname) == string.lower(vehnames[modelid-399]) then
                      removeMarks()
                      mark = addSpriteBlipForCoord(vehh[2],vehh[3],vehh[4],55)
                      checkpoint = createCheckpoint(1, vehh[2],vehh[3],vehh[4],vehh[2],vehh[3],vehh[4], 1)
					  if ini4[GhettoMateSettings].NotifyUgonyala then
						  if isDriver then
							sampAddChatMessage(string.format(u8:decode" [GhettoMate] {9ACD32}\"%s\" {FF8C00}в кв. [{00CED1}%s-%s{FF8C00}]{FF8C00}, за рулем: {FF6347}%s. {FF8C00}Метка на карте", vehnames[modelid-399],secta[alpha], digit+12, driverNickname), main_color)
						  else
							sampAddChatMessage(string.format(u8:decode" [GhettoMate] {9ACD32}\"%s\" {FF8C00}в кв. [{00CED1}%s-%s{FF8C00}]{FF8C00}. {FF8C00}Метка на карте", vehnames[modelid-399],secta[alpha], digit+12), main_color)
						  end
					  end
                      if marks then
                        for i, mark in ipairs(marks) do
                          removeBlip(mark)
                        end
                      end
                      if checkpoints then
                        for i, checkpoint in ipairs(checkpoints) do
                          deleteCheckpoint(checkpoint)
                        end
                      end
                    end
                  end
                end
              end
              if not isRepeat then
                table.insert(vehlist, {vehnames[modelid-399],posX,posY,posZ,vehId, driverNickname, os.clock()})
                digit = math.ceil(posX/250)
                alpha = math.ceil(posY/250)
				if ini4[GhettoMateSettings].NotifyUgonyala then
					if notify then
					  if isDriver then
						sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Новый {9ACD32}\"%s\" {FFFFFF}в кв. [{00CED1}%s-%s{FFFFFF}]{FFFFFF}, за рулем: {FF6347}%s", vehnames[modelid-399],secta[alpha], digit+12, driverNickname), main_color)
					  else
						sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Новый {9ACD32}\"%s\" {FFFFFF}в кв. [{00CED1}%s-%s{FFFFFF}]{FFFFFF}", vehnames[modelid-399],secta[alpha], digit+12), main_color)
					  end
					end
				end
              end
            else
              for k, vehh in ipairs(vehlist) do
                if vehId == vehh[5] then
                  vehh[2] = posX
                  vehh[3] = posY
                  vehh[4] = posZ
                  if driverNickname ~= NickName then
                    vehh[6] = driverNickname
                  end
                  vehh[7] = os.clock()
                  if carname then
                    if string.lower(carname) == string.lower(vehnames[modelid-399]) then
                      removeMarks()
                      mark = addSpriteBlipForCoord(vehh[2],vehh[3],vehh[4],55)
                      checkpoint = createCheckpoint(1, vehh[2],vehh[3],vehh[4],vehh[2],vehh[3],vehh[4], 1)
					  if ini4[GhettoMateSettings].NotifyUgonyala then
						  if isDriver then
							sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Открытый {9ACD32}\"%s\" {FF8C00}в кв. [{00CED1}%s-%s{FF8C00}]{FF8C00}, за рулем: {FF6347}%s. {FF8C00}Метка на карте", vehnames[modelid-399],secta[alpha], digit+12, driverNickname), main_color)
						  else
							sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Открытый {9ACD32}\"%s\" {FF8C00}в кв. [{00CED1}%s-%s{FF8C00}]{FF8C00}. {FF8C00}Метка на карте", vehnames[modelid-399],secta[alpha], digit+12), main_color)
						  end
					  end
                      if marks then
                        for i, mark in ipairs(marks) do
                          removeBlip(mark)
                        end
                      end
                      if checkpoints then
                        for i, checkpoint in ipairs(checkpoints) do
                          deleteCheckpoint(checkpoint)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    if sampIsChatVisible() and sampGetChatInputText() == "/q" and wasKeyPressed(13) then off = 1 end
    if not sampIsScoreboardOpen() and sampIsChatVisible() and not isKeyDown(116) and not isKeyDown(121) and off == nil then
      if ugtimer > 0 then
        sound = true
      elseif sound then
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(u8:decode"[GhettoMate] {FFFFFF}Угон снова доступен", main_color)
			sound = false
			bass.BASS_ChannelPlay(radio, false)
		end
      end
    end
  end
end

function cmd_hud(arg)
	interface = not interface
end 

function imgui.ApplyCustomStyle()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end
function imgui.OnDrawFrame()
	if InterfacePosition == true then 
		imgui.SetNextWindowPos(imgui.ImVec2(ini[GhettoMateConfig].X, ini[GhettoMateConfig].Y))
		inicfg.save(ini, directIni)
	end
	imgui.SetNextWindowSize(imgui.ImVec2(resX/8.5, resY/20*6.6))
	imgui.Begin("Larek HUD", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
	local pos = imgui.GetWindowPos()
	ini[GhettoMateConfig].X = pos.x
	ini[GhettoMateConfig].Y = pos.y
	inicfg.save(ini, directIni)
	
if ini3[GhettoMateTime].time1 == u8:decode"Неизвестно" then
		color[1] = "{808080}"
	else
		if timerM[1] == 1 then
			color[1] = "{d10000}"
		else
			color[1] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time2 == u8:decode"Неизвестно" then
		color[2] = "{808080}"
	else
		if timerM[2] == 1 then
			color[2] = "{d10000}"
		else
			color[2] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time3 == u8:decode"Неизвестно" then
		color[3] = "{808080}"
	else
		if timerM[3] == 1 then
			color[3] = "{d10000}"
		else
			color[3] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time4 == u8:decode"Неизвестно" then
		color[4] = "{808080}"
	else
		if timerM[4] == 1 then
			color[4] = "{d10000}"
		else
			color[4] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time5 == u8:decode"Неизвестно" then
		color[5] = "{808080}"
	else
		if timerM[5] == 1 then
			color[5] = "{d10000}"
		else
			color[5] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time6 == u8:decode"Неизвестно" then
		color[6] = "{808080}"
	else
		if timerM[6] == 1 then
			color[6] = "{d10000}"
		else
			color[6] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time7 == u8:decode"Неизвестно" then
		color[7] = "{808080}"
	else
		if timerM[7] == 1 then
			color[7] = "{d10000}"
		else
			color[7] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time8 == u8:decode"Неизвестно" then
		color[8] = "{808080}"
	else
		if timerM[8] == 1 then
			color[8] = "{d10000}"
		else
			color[8] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time9 == u8:decode"Неизвестно" then
		color[9] = "{808080}"
	else
		if timerM[9] == 1 then
			color[9] = "{d10000}"
		else
			color[9] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time10 == u8:decode"Неизвестно" then
		color[10] = "{808080}"
	else
		if timerM[10] == 1 then
			color[10] = "{d10000}"
		else
			color[10] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time11 == u8:decode"Неизвестно" then
		color[11] = "{808080}"
	else
		if timerM[11] == 1 then
			color[11] = "{d10000}"
		else
			color[11] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time12 == u8:decode"Неизвестно" then
		color[12] = "{808080}"
	else
		if timerM[12] == 1 then
			color[12] = "{d10000}"
		else
			color[12] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time13 == u8:decode"Неизвестно" then
		color[13] = "{808080}"
	else
		if timerM[13] == 1 then
			color[13] = "{d10000}"
		else
			color[13] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time14 == u8:decode"Неизвестно" then
		color[14] = "{808080}"
	else
		if timerM[14] == 1 then
			color[14] = "{d10000}"
		else
			color[14] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time15 == u8:decode"Неизвестно" then
		color[15] = "{808080}"
	else
		if timerM[15] == 1 then
			color[15] = "{d10000}"
		else
			color[15] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time16 == u8:decode"Неизвестно" then
		color[16] = "{808080}"
	else
		if timerM[16] == 1 then
			color[16] = "{d10000}"
		else
			color[16] = "{06940f}"
		end
	end	
	
	imgui.TextColoredRGB(u8"1.  " .. ini[GhettoMateName].Name1)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[1] .. ini3[GhettoMateTime].time1)
	imgui.TextColoredRGB(u8"2.  " .. ini[GhettoMateName].Name2)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8""  .. color[2] .. ini3[GhettoMateTime].time2)	
	imgui.TextColoredRGB(u8"3.  " .. ini[GhettoMateName].Name3)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[3] .. ini3[GhettoMateTime].time3)
	imgui.TextColoredRGB(u8"4.  " .. ini[GhettoMateName].Name4)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[4] .. ini3[GhettoMateTime].time4)
	imgui.TextColoredRGB(u8"5.  " .. ini[GhettoMateName].Name5)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[5] .. ini3[GhettoMateTime].time5)
	imgui.TextColoredRGB(u8"6.  " .. ini[GhettoMateName].Name6)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[6] .. ini3[GhettoMateTime].time6)	
	imgui.TextColoredRGB(u8"7.  " .. ini[GhettoMateName].Name7)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[7] .. ini3[GhettoMateTime].time7)	
	imgui.TextColoredRGB(u8"8.  " .. ini[GhettoMateName].Name8)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[8] .. ini3[GhettoMateTime].time8)
	imgui.TextColoredRGB(u8"9.  " .. ini[GhettoMateName].Name9)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[9] .. ini3[GhettoMateTime].time9)
	imgui.TextColoredRGB(u8"10. " .. ini[GhettoMateName].Name10)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[10] .. ini3[GhettoMateTime].time10)
	imgui.TextColoredRGB(u8"11. " .. ini[GhettoMateName].Name11)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[11] .. ini3[GhettoMateTime].time11)
	imgui.TextColoredRGB(u8"12. " .. ini[GhettoMateName].Name12)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[12] .. ini3[GhettoMateTime].time12)	
	imgui.TextColoredRGB(u8"13. " .. ini[GhettoMateName].Name13)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[13] .. ini3[GhettoMateTime].time13)
	imgui.TextColoredRGB(u8"14. " .. ini[GhettoMateName].Name14)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[14] .. ini3[GhettoMateTime].time14)
	imgui.TextColoredRGB(u8"15. " .. ini[GhettoMateName].Name15)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[15] .. ini3[GhettoMateTime].time15)
	imgui.TextColoredRGB(u8"16. " .. ini[GhettoMateName].Name16)
		imgui.SameLine((resX/5) / 3)
	imgui.TextColoredRGB(u8"" .. color[16] .. ini3[GhettoMateTime].time16)	
	imgui.Separator()
	imgui.TextColoredRGB(u8:decode"Денег награблено: " .. ini2[GhettoMateMoney].money)
	imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count)

	imgui.End()
end

function Waiting()        
	if timer == true then
		wait(10000)
		timer = false
	end
end

function Waiting2()       
	if sideTimer == true then
		wait(1000)
		sideTimer = false
	end
end

function DrugsWaiting()
	wait(60000)
	sampAddChatMessage(" [TaxiMate] {FFFFFF}Юзай, " .. my_name .. "!", main_color)
end

function Timer()
	if timer == false then
		if totalSeconds == ini3[GhettoMateSeconds].time1 then
			MagazTime[1] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time2 then
			MagazTime[2] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time3 then
			MagazTime[3] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time4 then
			MagazTime[4] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time5 then
			MagazTime[5] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time6 then
			MagazTime[6] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time7 then
			MagazTime[7] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time8 then
			MagazTime[8] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time9 then
			MagazTime[9] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time10 then
			MagazTime[10] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time11 then
			MagazTime[11] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time12 then
			MagazTime[12] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time13 then
			MagazTime[13] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time14 then
			MagazTime[14] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time15 then
			MagazTime[15] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
		if totalSeconds == ini3[GhettoMateSeconds].time16 then
			MagazTime[16] = true
			MagazTimeFunction()
			timer = true
			Wait:run()
		end
	end
	if ini4[GhettoMateSettings].NotifyLarek then
		if sideTimer == false then
			if totalSeconds == ini3[GhettoMateSeconds].time1 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name1 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time2 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name2 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time3 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name3 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time4 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name4 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time5 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name5 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time6 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name6 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time7 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name7 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time8 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name8 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time9 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name9 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time10 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name10 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time11 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name11 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time12 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name12 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time13 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name13 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time14 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name14 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time15 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name15 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!", main_color)
				sideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[GhettoMateSeconds].time16 - ini4[GhettoMateSettings].TimerNotifyLarek then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк {FFFF00}" .. ini[GhettoMateName].Name16 .. u8:decode"{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд!!", main_color)
				sideTimer = true
				Wait2:run()
			end
		end
	end
end

function TimerM()
	if totalSeconds <= ini3[GhettoMateSeconds].time1 then
		timerM[1] = 1
	else
		timerM[1] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time2 then
		timerM[2] = 1
	else
		timerM[2] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time3 then
		timerM[3] = 1
	else
		timerM[3] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time4 then
		timerM[4] = 1
	else
		timerM[4] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time5 then
		timerM[5] = 1
	else
		timerM[5] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time6 then
		timerM[6] = 1
	else
		timerM[6] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time7 then
		timerM[7] = 1
	else
		timerM[7] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time8 then
		timerM[8] = 1
	else
		timerM[8] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time9 then
		timerM[9] = 1
	else
		timerM[9] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time10 then
		timerM[10] = 1
	else
		timerM[10] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time11 then
		timerM[11] = 1
	else
		timerM[11] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time12 then
		timerM[12] = 1
	else
		timerM[12] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time13 then
		timerM[13] = 1
	else
		timerM[13] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time14 then
		timerM[14] = 1
	else
		timerM[14] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time15 then
		timerM[15] = 1
	else
		timerM[15] = 2
	end
	if totalSeconds <= ini3[GhettoMateSeconds].time16 then
		timerM[16] = 1
	else
		timerM[16] = 2
	end
end

function Refresh()
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time1) > oneHour then
		ini3[GhettoMateSeconds].time1 = 0
		ini3[GhettoMateTime].time1 = u8:decode"Неизвестно"
		color[1] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time2) > oneHour then
		ini3[GhettoMateSeconds].time2 = 0
		ini3[GhettoMateTime].time2 = u8:decode"Неизвестно"
		color[2] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time3) > oneHour then
		ini3[GhettoMateSeconds].time3 = 0
		ini3[GhettoMateTime].time3 = u8:decode"Неизвестно"
		color[3] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time4) > oneHour then
		ini3[GhettoMateSeconds].time4 = 0
		ini3[GhettoMateTime].time4 = u8:decode"Неизвестно"
		color[4] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time5) > oneHour then
		ini3[GhettoMateSeconds].time5 = 0
		ini3[GhettoMateTime].time5 = u8:decode"Неизвестно"
		color[5] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time6) > oneHour then
		ini3[GhettoMateSeconds].time6 = 0
		ini3[GhettoMateTime].time6 = u8:decode"Неизвестно"
		color[6] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time7) > oneHour then
		ini3[GhettoMateSeconds].time7 = 0
		ini3[GhettoMateTime].time7 = u8:decode"Неизвестно"
		color[7] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time8) > oneHour then
		ini3[GhettoMateSeconds].time8 = 0
		ini3[GhettoMateTime].time8 = u8:decode"Неизвестно"
		color[8] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time9) > oneHour then
		ini3[GhettoMateSeconds].time9 = 0
		ini3[GhettoMateTime].time9 = u8:decode"Неизвестно"
		color[9] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time10) > oneHour then
		ini3[GhettoMateSeconds].time10 = 0
		ini3[GhettoMateTime].time10 = u8:decode"Неизвестно"
		color[10] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time11) > oneHour then
		ini3[GhettoMateSeconds].time11 = 0
		ini3[GhettoMateTime].time11 = u8:decode"Неизвестно"
		color[11] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time12) > oneHour then
		ini3[GhettoMateSeconds].time12 = 0
		ini3[GhettoMateTime].time12 = u8:decode"Неизвестно"
		color[12] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time13) > oneHour then
		ini3[GhettoMateSeconds].time13 = 0
		ini3[GhettoMateTime].time13 = u8:decode"Неизвестно"
		color[13] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time14) > oneHour then
		ini3[GhettoMateSeconds].time14 = 0
		ini3[GhettoMateTime].time14 = u8:decode"Неизвестно"
		color[14] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time15) > oneHour then
		ini3[GhettoMateSeconds].time15 = 0
		ini3[GhettoMateTime].time15 = u8:decode"Неизвестно"
		color[15] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time16) > oneHour then
		ini3[GhettoMateSeconds].time16 = 0
		ini3[GhettoMateTime].time16 = u8:decode"Неизвестно"
		color[16] = "{808080}"
	end
end

function ShowDialog(int, dtext, dinput, string_or_number, ini1, ini2)
	d = {}
	d[1], d[2], d[3], d[4], d[5], d[6] = int, dtext, dinput, string_or_number, ini1, ini2
	
	if ini3[GhettoMateTime].time1 == u8:decode"Неизвестно" then
		color[1] = "{808080}"
	else
		if timerM[1] == 1 then
			color[1] = "{d10000}"
		else
			color[1] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time2 == u8:decode"Неизвестно" then
		color[2] = "{808080}"
	else
		if timerM[2] == 1 then
			color[2] = "{d10000}"
		else
			color[2] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time3 == u8:decode"Неизвестно" then
		color[3] = "{808080}"
	else
		if timerM[3] == 1 then
			color[3] = "{d10000}"
		else
			color[3] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time4 == u8:decode"Неизвестно" then
		color[4] = "{808080}"
	else
		if timerM[4] == 1 then
			color[4] = "{d10000}"
		else
			color[4] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time5 == u8:decode"Неизвестно" then
		color[5] = "{808080}"
	else
		if timerM[5] == 1 then
			color[5] = "{d10000}"
		else
			color[5] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time6 == u8:decode"Неизвестно" then
		color[6] = "{808080}"
	else
		if timerM[6] == 1 then
			color[6] = "{d10000}"
		else
			color[6] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time7 == u8:decode"Неизвестно" then
		color[7] = "{808080}"
	else
		if timerM[7] == 1 then
			color[7] = "{d10000}"
		else
			color[7] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time8 == u8:decode"Неизвестно" then
		color[8] = "{808080}"
	else
		if timerM[8] == 1 then
			color[8] = "{d10000}"
		else
			color[8] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time9 == u8:decode"Неизвестно" then
		color[9] = "{808080}"
	else
		if timerM[9] == 1 then
			color[9] = "{d10000}"
		else
			color[9] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time10 == u8:decode"Неизвестно" then
		color[10] = "{808080}"
	else
		if timerM[10] == 1 then
			color[10] = "{d10000}"
		else
			color[10] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time11 == u8:decode"Неизвестно" then
		color[11] = "{808080}"
	else
		if timerM[11] == 1 then
			color[11] = "{d10000}"
		else
			color[11] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time12 == u8:decode"Неизвестно" then
		color[12] = "{808080}"
	else
		if timerM[12] == 1 then
			color[12] = "{d10000}"
		else
			color[12] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time13 == u8:decode"Неизвестно" then
		color[13] = "{808080}"
	else
		if timerM[13] == 1 then
			color[13] = "{d10000}"
		else
			color[13] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time14 == u8:decode"Неизвестно" then
		color[14] = "{808080}"
	else
		if timerM[14] == 1 then
			color[14] = "{d10000}"
		else
			color[14] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time15 == u8:decode"Неизвестно" then
		color[15] = "{808080}"
	else
		if timerM[15] == 1 then
			color[15] = "{d10000}"
		else
			color[15] = "{06940f}"
		end
	end
	if ini3[GhettoMateTime].time16 == u8:decode"Неизвестно" then
		color[16] = "{808080}"
	else
		if timerM[16] == 1 then
			color[16] = "{d10000}"
		else
			color[16] = "{06940f}"
		end
	end
	
	if int == 20 then 
		dialogLine, dialogTextToList = {}, {}
		dialogLine[#dialogLine + 1] = '  1. Larek\t'
		dialogLine[#dialogLine + 1] = '  2. AutoGetGuns\t' .. (GetGuns and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = '  3. Sucher\t' .. (Find and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = '  4. Ugonyala\t' .. (search and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'> Настройки\t'
		
		local text = ""
		for k,v in pairs(dialogLine) do
			text = text..v.."\n"
		end
		sampShowDialog(1000, u8:decode'GhettoMate: Список', text, u8:decode"Выбрать", u8:decode"Выход", 4)
	end
	
	if int == 21 then
		sampShowDialog(1001, u8:decode"Sucher", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	
	if int == 22 then
		sampShowDialog(1002, u8:decode"Ugonyala", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end

	if int == 23 then 
		dialogLine, dialogTextToList = {}, {}
		dialogLine[#dialogLine + 1] = u8:decode'  1. Уведомления от Larek\t' .. (ini4[GhettoMateSettings].NotifyLarek and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  2. Таймер уведомлений Larek\t' .. ini4[GhettoMateSettings].TimerNotifyLarek
		dialogLine[#dialogLine + 1] = u8:decode'  3. Уведомления от Ugonyala\t' .. (ini4[GhettoMateSettings].NotifyUgonyala and '{06940f}ON' or '{d10000}OFF') 
		dialogLine[#dialogLine + 1] = u8:decode'  4. Анимация угона\t' .. (ini4[GhettoMateSettings].AnimUgonyala and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  5. Выбрать анимацию угона\t' .. ini4[GhettoMateSettings].IdAnimUgonyala
		dialogLine[#dialogLine + 1] = u8:decode'  6. Уведомления от Find\t' .. (ini4[GhettoMateSettings].NotifyFind and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  7. Уведомления от Drugs\t' .. (ini4[GhettoMateSettings].NotifyDrugs and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  8. Обновить скрипт\t' --.. (ini4[GhettoMateSettings].NotifyDrugs and '{06940f}ON' or '{d10000}OFF')
		
		local text3 = ""
		for k,v in pairs(dialogLine) do
			text3 = text3..v.."\n"
		end
		sampShowDialog(1003, u8:decode'Настройки', text3, u8:decode"Выбрать", u8:decode"Назад", 4)
	end
	if int == 24 then
		sampShowDialog(1004, u8:decode"Таймер", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	
	if int == 25 then
		sampShowDialog(1005, u8:decode"Анимация", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
		
	if int == 1 then
		dialogLine, dialogTextToList = {}, {}
		dialogLine[#dialogLine + 1] = '  1. ' .. ini[GhettoMateName].Name1  .. '\t' .. color[1]  .. ini3[GhettoMateTime].time1
		dialogLine[#dialogLine + 1] = '  2. ' .. ini[GhettoMateName].Name2  .. '\t' .. color[2]  .. ini3[GhettoMateTime].time2
		dialogLine[#dialogLine + 1] = '  3. ' .. ini[GhettoMateName].Name3  .. '\t' .. color[3]  .. ini3[GhettoMateTime].time3
		dialogLine[#dialogLine + 1] = '  4. ' .. ini[GhettoMateName].Name4  .. '\t' .. color[4]  .. ini3[GhettoMateTime].time4
		dialogLine[#dialogLine + 1] = '  5. ' .. ini[GhettoMateName].Name5  .. '\t' .. color[5]  .. ini3[GhettoMateTime].time5
		dialogLine[#dialogLine + 1] = '  6. ' .. ini[GhettoMateName].Name6  .. '\t' .. color[6]  .. ini3[GhettoMateTime].time6
		dialogLine[#dialogLine + 1] = '  7. ' .. ini[GhettoMateName].Name7  .. '\t' .. color[7]  .. ini3[GhettoMateTime].time7
		dialogLine[#dialogLine + 1] = '  8. ' .. ini[GhettoMateName].Name8  .. '\t' .. color[8]  .. ini3[GhettoMateTime].time8
		dialogLine[#dialogLine + 1] = '  9. ' .. ini[GhettoMateName].Name9  .. '\t' .. color[9]  .. ini3[GhettoMateTime].time9
		dialogLine[#dialogLine + 1] = ' 10. ' .. ini[GhettoMateName].Name10 .. '\t' .. color[10] .. ini3[GhettoMateTime].time10
		dialogLine[#dialogLine + 1] = ' 11. ' .. ini[GhettoMateName].Name11 .. '\t' .. color[11] .. ini3[GhettoMateTime].time11
		dialogLine[#dialogLine + 1] = ' 12. ' .. ini[GhettoMateName].Name12 .. '\t' .. color[12] .. ini3[GhettoMateTime].time12
		dialogLine[#dialogLine + 1] = ' 13. ' .. ini[GhettoMateName].Name13 .. '\t' .. color[13] .. ini3[GhettoMateTime].time13
		dialogLine[#dialogLine + 1] = ' 14. ' .. ini[GhettoMateName].Name14 .. '\t' .. color[14] .. ini3[GhettoMateTime].time14
		dialogLine[#dialogLine + 1] = ' 15. ' .. ini[GhettoMateName].Name15 .. '\t' .. color[15] .. ini3[GhettoMateTime].time15
		dialogLine[#dialogLine + 1] = ' 16. ' .. ini[GhettoMateName].Name16 .. '\t' .. color[16] .. ini3[GhettoMateTime].time16
		dialogLine[#dialogLine + 1] = u8:decode'> Larek HUD\t' .. (interface and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'> Фиксация HUDa\t' .. (InterfacePosition and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'> Разница во времени с Samp-RP\t'
		dialogLine[#dialogLine + 1] = u8:decode'> Статистика\t'

		local text2 = ""
		for k,v in pairs(dialogLine) do
			text2 = text2..v.."\n"
		end
		sampShowDialog(1488, u8:decode'Larek: Список', text2, u8:decode"Выбрать", u8:decode"Назад", 4)
	end
	if int == 3 then
		sampShowDialog(1490, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 4 then
		sampShowDialog(1491, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 5 then
		sampShowDialog(1492, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 6 then
		sampShowDialog(1493, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 7 then
		sampShowDialog(1494, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 8 then
		sampShowDialog(1495, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 9 then
		sampShowDialog(1496, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 10 then
		sampShowDialog(1497, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 11 then
		sampShowDialog(1498, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 12 then
		sampShowDialog(1499, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 13 then
		sampShowDialog(1500, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 14 then
		sampShowDialog(1501, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 15 then
		sampShowDialog(1502, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 16 then
		sampShowDialog(1503, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 17 then
		sampShowDialog(1504, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 18 then
		sampShowDialog(1505, u8:decode"Изменение названия", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	if int == 19 then
		GhettoMateMoney = string.format('GhettoMateMoney-%s', my_name)
		ini2 = inicfg.load(GhettoMateMoney, directIni2)
		sampShowDialog(1506, u8:decode'Статистика', u8:decode"Денег награблено: \t" .. ini2[GhettoMateMoney].money .. u8:decode"\nМагазинов ограблено: \t" .. ini2[GhettoMateMoney].count
		.. u8:decode"\nОграблений в 2: \t" .. ini2[GhettoMateMoney].count2 .. u8:decode"\nОграблений в 3: \t" .. ini2[GhettoMateMoney].count3 .. u8:decode"\nОграблений в 4: \t" .. ini2[GhettoMateMoney].count4 .. u8:decode"\nОграблений в 1: \t" .. ini2[GhettoMateMoney].count1, u8:decode"Выбрать", u8:decode"Выход", 4)
	end
end

function MagazTimeFunction()
	if MagazTime[1] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name1 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[1] = false
	end
	if MagazTime[2] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name2 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[2] = false
	end
	if MagazTime[3] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name3 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[3] = false
	end
	if MagazTime[4] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name4 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[4] = false
	end
	if MagazTime[5] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name5 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[5] = false
	end
	if MagazTime[6] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name6 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[6] = false
	end
	if MagazTime[7] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name7 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[7] = false
	end
	if MagazTime[8] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name8 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[8] = false
	end
	if MagazTime[9] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name9 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[9] = false
	end
	if MagazTime[10] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name10 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[10] = false
	end
	if MagazTime[11] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name11 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[11] = false
	end
	if MagazTime[12] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name12 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[12] = false
	end
	if MagazTime[13] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name13 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[13] = false
	end
	if MagazTime[14] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name14 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[14] = false
	end
	if MagazTime[15] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name15 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[15] = false
	end
	if MagazTime[16] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name16 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		MagazTime[16] = false
	end
end

function sampev.onSendPickedUpPickup(pickupId)
	if pickupId == 1039 then  -- вошел
		Magaz1 = true
	end
	if pickupId == 1040 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then  -- вышел
		Magaz1 = false
	end
	if pickupId == 1037 then  
		Magaz2 = true
	end
	if pickupId == 1038 or pickupId == 1039 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then  
		Magaz2 = false
	end
	if pickupId == 979 then   
		Magaz3 = true
	end
	if pickupId == 980 or pickupId == 1039 or pickupId == 1037 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then
		Magaz3 = false
	end
	if pickupId == 977 then   
		Magaz4 = true
	end
	if pickupId == 978 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz4 = false
	end
	if pickupId == 983 then   
		Magaz5 = true
	end
	if pickupId == 984 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz5 = false
	end
	if pickupId == 1035 then   
		Magaz6 = true
	end
	if pickupId == 1036 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz6 = false
	end
	if pickupId == 987 then  
		Magaz7 = true
	end
	if pickupId == 988 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz7 = false
	end
	if pickupId == 981 then   
		Magaz8 = true
	end
	if pickupId == 982 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz8 = false
	end
	if pickupId == 985 then   
		Magaz9 = true
	end
	if pickupId == 986 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz9 = false
	end
	if pickupId == 1033 then  
		Magaz10 = true
	end
	if pickupId == 1034 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz10 = false
	end
	if pickupId == 1031 then  
		Magaz11 = true
	end
	if pickupId == 1032 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz11 = false
	end
	if pickupId == 1019 then  
		Magaz12 = true
	end
	if pickupId == 1020 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz12 = false
	end
	if pickupId == 1025 then  
		Magaz13 = true
	end
	if pickupId == 1026 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1021 or pickupId == 1023 or pickupId == 1029 then 
		Magaz13 = false
	end
	if pickupId == 1021 then  
		Magaz14 = true
	end
	if pickupId == 1022 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1023 or pickupId == 1029 then 
		Magaz14 = false
	end
	if pickupId == 1023 then  
		Magaz15 = true
	end
	if pickupId == 1024 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1029 then 
		Magaz15 = false
	end
	if pickupId == 1029 then   
		Magaz16 = true
	end
	if pickupId == 1030 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023 then 
		Magaz16 = false
	end
end

function sampev.onServerMessage(color, text)
	if Magaz1 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[1] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time1 = timerMagaz[1]
				inicfg.save(ini3, directIni3)
			hourM[1], minuteM[1], secondM[1] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time1 = hourM[1] * 3600 + minuteM[1] * 60 + secondM[1]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz2 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[2] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time2 = timerMagaz[2]
				inicfg.save(ini3, directIni3)
			hourM[2], minuteM[2], secondM[2] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time2 = hourM[2] * 3600 + minuteM[2] * 60 + secondM[2]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz3 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[3] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time3 = timerMagaz[3]
				inicfg.save(ini3, directIni3)
			hourM[3], minuteM[3], secondM[3] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time3 = hourM[3] * 3600 + minuteM[3] * 60 + secondM[3]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz4 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[4] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time4 = timerMagaz[4]
				inicfg.save(ini3, directIni3)
			hourM[4], minuteM[4], secondM[4] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time4 = hourM[4] * 3600 + minuteM[4] * 60 + secondM[4]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz5 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[5] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time5 = timerMagaz[5]
				inicfg.save(ini3, directIni3)
			hourM[5], minuteM[5], secondM[5] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time5 = hourM[5] * 3600 + minuteM[5] * 60 + secondM[5]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz6 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[6] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time6 = timerMagaz[6]
				inicfg.save(ini3, directIni3)
			hourM[6], minuteM[6], secondM[6] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time6 = hourM[6] * 3600 + minuteM[6] * 60 + secondM[6]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz7 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[7] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time7 = timerMagaz[7]
				inicfg.save(ini3, directIni3)
			hourM[7], minuteM[7], secondM[7] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time7 = hourM[7] * 3600 + minuteM[7] * 60 + secondM[7]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz8 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[8] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time8 = timerMagaz[8]
				inicfg.save(ini3, directIni3)
			hourM[8], minuteM[8], secondM[8] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time8 = hourM[8] * 3600 + minuteM[8] * 60 + secondM[8]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz9 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[9] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time9 = timerMagaz[9]
				inicfg.save(ini3, directIni3)
			hourM[9], minuteM[9], secondM[9] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time9 = hourM[9] * 3600 + minuteM[9] * 60 + secondM[9]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz10 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[10] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time10 = timerMagaz[10]
				inicfg.save(ini3, directIni3)
			hourM[10], minuteM[10], secondM[10] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time10 = hourM[10] * 3600 + minuteM[10] * 60 + secondM[10]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz11 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[11] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time11 = timerMagaz[11]
				inicfg.save(ini3, directIni3)
			hourM[11], minuteM[11], secondM[11] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time11 = hourM[11] * 3600 + minuteM[11] * 60 + secondM[11]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz12 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[12] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time12 = timerMagaz[12]
				inicfg.save(ini3, directIni3)
			hourM[12], minuteM[12], secondM[12] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time12 = hourM[12] * 3600 + minuteM[12] * 60 + secondM[12]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz13 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[13] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time13 = timerMagaz[13]
				inicfg.save(ini3, directIni3)
			hourM[13], minuteM[13], secondM[13] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time13 = hourM[13] * 3600 + minuteM[13] * 60 + secondM[13]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz14 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[14] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time14 = timerMagaz[14]
				inicfg.save(ini3, directIni3)
			hourM[14], minuteM[14], secondM[14] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time14 = hourM[14] * 3600 + minuteM[14] * 60 + secondM[14]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz15 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[15] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time15 = timerMagaz[15]
				inicfg.save(ini3, directIni3)
			hourM[15], minuteM[15], secondM[15] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time15 = hourM[15] * 3600 + minuteM[15] * 60 + secondM[15]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz16 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[16] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time16 = timerMagaz[16]
				inicfg.save(ini3, directIni3)
			hourM[16], minuteM[16], secondM[16] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time16 = hourM[16] * 3600 + minuteM[16] * 60 + secondM[16]
			inicfg.save(ini3, directIni3)
		end
	end
	
	-- AUTOGETGUNS--
	
	if GetGuns and not paused then
		if string.find(text, u8:decode" открыл(а) склад с оружием", 1, true) then
			sampSendChat("/get guns")
			GetGuns = false
		end
		if string.find(text, u8:decode" закрыл(а) склад с оружием", 1, true) then
			GetGuns = false
			sampAddChatMessage(" [GhettoMate] {FFFFFF}AutoGetGuns: {d10000}off", main_color)
		end
	end	
	
	--UGONYALA--
	
	if string.find(text, u8:decode"SMS: Слишком долго. Нам нужны хорошие автоугонщики, а не черепахи") then
		stopSearch()
	end

	if string.find(text, u8:decode" Отличная тачка. Будет нужна работа, приходи.") then
		sampAddChatMessage("{FFFFFF} TH |{FF0000} Следующий угон доступен через 15 минут. Таймер активирован.")
		stopSearch()
		ugontimer = os.clock() + 900
	end

	if string.find(text, u8:decode"Заказ можно брать раз в 15 минут. Осталось .+:.+") then
		minutes, seconds = string.match(text, u8:decode"Заказ можно брать раз в 15 минут. Осталось (.+):(.+)")
		ugontimer = tonumber(minutes)*60+tonumber(seconds)+os.clock()
	end

	if string.find(text, u8:decode"Пригони нам тачку марки .+, и мы тебе хорошо заплатим.") then
		carname = string.match(text, u8:decode"Пригони нам тачку марки (.+), и мы тебе хорошо заплатим.")
		sampSendChat("/fc "..carname)
	end

	if string.find(text, u8:decode"SMS: Это то что нам нужно, гони её на склад.") then
		stopSearch()
	end
	
	if ini4[GhettoMateSettings].AnimUgonyala then
		if string.find(text, u8:decode"SMS: Вот тачка которую мы заказывали.") then
			sampSendChat("/anim " .. ini4[GhettoMateSettings].IdAnimUgonyala)
		end
	end
	-- DRUGS --
	if ini4[GhettoMateSettings].NotifyDrugs then
		if string.find(text, u8:decode"(( Здоровье пополнено до: .+ ))") or string.find(text, u8:decode"(( Остаток: .+ грамм ))") then
			DrugsWait:run()
		end
	end
end

function sampev.onDisplayGameText(style, time, text)
	if Magaz1 == true or Magaz2 == true or Magaz3 == true or Magaz4 == true or Magaz5 == true or Magaz6 == true or Magaz7 == true or Magaz8 == true or Magaz9 == true or Magaz10 == true or Magaz11 == true or Magaz12 == true or Magaz13 == true or Magaz14 == true or Magaz15 == true or Magaz16 == true then 
		if string.find(text, "$5000") then
			ini2[GhettoMateMoney].money  = ini2[GhettoMateMoney].money + 5000
			ini2[GhettoMateMoney].count  = ini2[GhettoMateMoney].count + 1
			ini2[GhettoMateMoney].count2 = ini2[GhettoMateMoney].count2 + 1
			inicfg.save(ini2, directIni2)
		end
		if string.find(text, "$3333") then
			ini2[GhettoMateMoney].money  = ini2[GhettoMateMoney].money + 3333
			ini2[GhettoMateMoney].count  = ini2[GhettoMateMoney].count + 1
			ini2[GhettoMateMoney].count3 = ini2[GhettoMateMoney].count3 + 1
			inicfg.save(ini2, directIni2)
		end
		if string.find(text, "$2500") then
			ini2[GhettoMateMoney].money  = ini2[GhettoMateMoney].money + 2500
			ini2[GhettoMateMoney].count  = ini2[GhettoMateMoney].count + 1
			ini2[GhettoMateMoney].count4 = ini2[GhettoMateMoney].count4 + 1
			inicfg.save(ini2, directIni2)
		end
		if string.find(text, "$10000") then
			ini2[GhettoMateMoney].money  = ini2[GhettoMateMoney].money + 10000
			ini2[GhettoMateMoney].count  = ini2[GhettoMateMoney].count + 1
			ini2[GhettoMateMoney].count1 = ini2[GhettoMateMoney].count1 + 1
			inicfg.save(ini2, directIni2)
		end
	end
	if CalibrationA == true then
		if string.find(text, "%d:%d") then
			ServerHour = string.match(text, "(%d+):")
			ini[GhettoMateConfig].time = ServerHour - hour2
			inicfg.save(ini, directIni)
		end
		CalibrationA = false
	end
end

function Calibration()
	CalibrationA = true
	sampSendChat("/time")
end

function checkUpdates()
  local fpath = os.tmpname()
  if doesFileExist(fpath) then os.remove(fpath) end
  downloadUrlToFile("https://raw.githubusercontent.com/Vlaek/GhettoMate/master/version.json", fpath, function(_, status, _, _)
    if status == 58 then
      if doesFileExist(fpath) then
        local file = io.open(fpath, 'r')
        if file then
          local info = decodeJson(file:read('*a'))
          file:close()
          os.remove(fpath)
          if info['version_num'] > thisScript()['version_num'] then
						sampAddChatMessage(u8:decode' [GhettoMate] {FFFFFF}Доступна новая версия скрипта!', main_color)
							script.update = true
            return true
          end
        end
      end
    end
  end)
end

function update()
  downloadUrlToFile("https://raw.githubusercontent.com/Vlaek/GhettoMate/master/GhettoMate.lua", thisScript().path, function(_, status, _, _)
    if status == 6 then
			sampAddChatMessage(u8:decode' [GhettoMate] {FFFFFF}Скрипт обновлён!', main_color)
      thisScript():reload()
    end
  end)
end

-- AUTOGETGUNS--

function cmd_autogetguns()
	GetGuns = not GetGuns
	if GetGuns == true then
		sampAddChatMessage(" [GhettoMate] {FFFFFF}AutoGetGuns: {00FF00}on", main_color)
	end
	if GetGuns == false then
		sampAddChatMessage(" [GhettoMate] {FFFFFF}AutoGetGuns: {d10000}off", main_color)
	end
end

--SUCHER--

function cmd_sucher(arg)
	Find = not Find
	Found = false
	NotFound = false
	WasFound = false
	if tonumber(arg) == tonumber(my_id) then
		if ini4[GhettoMateSettings].NotifyFind then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Не имеет смысла", main_color)
		end
		Find = false
	end
	Id = arg
	if not Find then
		if ini4[GhettoMateSettings].NotifyFind then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Поиск прекращен", main_color)
		end
		deleteCheckpoint(checkpoint)
		removeBlip(blip)
	end
end

function Suchen()
	local result, ped = sampGetCharHandleBySampPlayerId(Id)
	local playerNickname = sampGetPlayerNickname(Id)
	if result then
		local posX, posY, posZ = getCharCoordinates(ped)
		deleteCheckpoint(checkpoint)
		removeBlip(blip)
		checkpoint = createCheckpoint(1, posX, posY, posZ, posX, posY, posZ, 1)
		blip = addSpriteBlipForCoord(posX, posY, posZ, 3)
		if Found == false then
			if ini4[GhettoMateSettings].NotifyFind then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} обнаружена!", main_color)
			end
			Found = true
			NotFound = false
			WasFound = true
		end
	else
		deleteCheckpoint(checkpoint)
		removeBlip(blip)
		if NotFound == false and WasFound == false then
			if ini4[GhettoMateSettings].NotifyFind then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} не обнаружена!", main_color)
			end
			NotFound = true
			Found = false
		end
		if NotFound == false and WasFound == true then
			if ini4[GhettoMateSettings].NotifyFind then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} пропала!", main_color)
			end
			NotFound = true
			Found = false
		end
	end
end

--UGONYALA--

function sampev.onSendCommand(cmd)
  local args = {}

  for arg in cmd:gmatch("%S+") do
    table.insert(args, arg)
  end

  if args[1] == '/fc' then
    if args[2] then
      found = false
      carname = args[2]
      if args[3] then
        for i = 3, #args do
          if args[i] then
            carname = carname .. ' ' .. args[i]
          end
        end
      end
      for i, veh in ipairs(vehnames) do
        if string.lower(carname)==string.lower(veh) then
          found = true
          carname = veh
        end
      end
      if found then
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Поиск {9ACD32}\"%s\" {00FF00}активирован",carname), main_color)
		end
        search = true
        removeMarks()
        for i, veh in ipairs(vehlist) do
          if string.lower(carname)==string.lower(veh[1]) then
            digit = math.ceil(veh[2]/250)
            alpha = math.ceil(veh[3]/250)
            table.insert(marks,addSpriteBlipForCoord(veh[2],veh[3],veh[4],55))
            table.insert(checkpoints, createCheckpoint(1, veh[2],veh[3],veh[4],veh[2],veh[3],veh[4], 1))
			if ini4[GhettoMateSettings].NotifyUgonyala then
				if veh[6] then
				  sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}\"%s\" был в кв. [{00CED1}%s-%s{FFFFFF}]{FFFFFF} %s минут назад, за рулем был: {FF6347}%s", veh[1], secta[alpha], digit+12, math.floor((os.clock()-veh[7])/60), veh[6]), main_color)
				else
				  sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}\"%s\" был в кв. [{00CED1}%s-%s{FFFFFF}] %s минут назад", veh[1], secta[alpha], digit+12, math.floor((os.clock()-veh[7])/60)), main_color)
				end
			end
          end
        end
      else
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Транспорт не найдён", main_color)
		end
        carname = nil
      end
    else
      stopSearch()
      if ugtimer>0 then
        if math.floor(ugtimer%60)>=10 then
		  if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Угон доступен через: {FFFFFF}%s:%s",math.floor(ugtimer/60),math.floor(ugtimer%60)), main_color)
		  end
        else
		  if ini4[GhettoMateSettings].NotifyUgonyala then
            sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Угон доступен через: {FFFFFF}%s:0%s",math.floor(ugtimer/60),math.floor(ugtimer%60)), main_color)
		  end
        end
      else
	    if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Угон доступен", main_color)
		end
      end
    end
  end

  if args[1] == '/notify' then
    if notify then
      sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Уведомления отключены", main_color)
      notify = false
    else
      sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Уведомления включены", main_color)
      notify = true
    end
  end
end

function stopSearch()
	removeMarks()
	if search then
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Поиск {9ACD32}\"%s\" {FF0000}прекращен", carname), main_color)
		end
		search = false
	end
	carname = nil
end

function removeMarks()
	for i, mark in ipairs(marks) do
		removeBlip(mark)
	end
	for i, ugcheckpoint in ipairs(ugcheckpoints) do
		deleteCheckpoint(ugcheckpoint)
	end
	removeBlip(mark)
	deleteCheckpoint(ugcheckpoint)
end

function mySort(a,b)
	if math.floor((os.clock()-a[7])/60) > math.floor((os.clock()-b[7])/60) then
		v = b
		b = a
		a = v
		return true
	end
	return false
end
