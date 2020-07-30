script_name("GhettoMate")
script_author("Vlaek (Oleg_Cutov aka bier aka Vladanus)")
script_version('24/07/2020')
script_version_number(14)
script_url("https://vlaek.github.io/GhettoMate/")
script.update = false

local sampev, inicfg, imgui, encoding, keys = require 'lib.samp.events', require 'inicfg', require 'imgui', require 'encoding', require "vkeys"
local as_action = require 'moonloader'.audiostream_state

require "reload_all"
require "lib.sampfuncs"
require "lib.moonloader"
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local ini  = {}
local ini2 = {}
local ini3 = {}
local ini4 = {}

local main_window_state  = imgui.ImBool(false)
local larek_window_state = imgui.ImBool(false)
local mo_window_state    = imgui.ImBool(false)
local ug_window_state    = imgui.ImBool(false)

local resX, resY = getScreenResolution()
local main_color = 0x323232

local Magaz1  = false
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
local InterfacePositionMO = true

local timerM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local hourM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local minuteM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local secondsM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local color = {"{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}", "{808080}"}
local MagazTime = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false}

local timer = false
local sideTimer = false
local CalibrationA = false
--AutoGetGuns--
local GetGuns = false
local NickSklad = 0
--Sucher--
local Find = false
local NotFound = false
local Found = false
local WasFound = false
local TargetId = nil
local TargetDead = false
local TargetLeave = false
--MO--
local MOtimer = false
local MOsideTimer = false
local MOLS = false
local MOSF = false
local MOLV = false
local timerMagazO = {u8:decode"Неизвестно", u8:decode"Неизвестно", u8:decode"Неизвестно"}
local timerMO   = {0, 0, 0}
local hourMO    = {0, 0, 0}
local minuteMO  = {0, 0, 0}
local secondsMO = {0, 0, 0}
local colorMO = {"{808080}", "{808080}", "{808080}"}
local MOTime = {false, false, false}
--UGONYALA--
local ugontimer = 0
local ugtimer = 0
local ugdistance = 0
local mark, ugcheckpoint = nil, nil
local marks, ugcheckpoints = {}, {}
local vehlist = {}
local search = false
local thiefPos = ""
--DRUGS
local DrugsCount = 0
local Use = true
local DrugsTimer = 0
local UseDrugsTimer = 0
--sellgun
local price_gun = 0
local text_buffer_pt1 = imgui.ImBuffer(256)
local text_buffer_id1 = imgui.ImBuffer(256)
local text_buffer_pt2 = imgui.ImBuffer(256)
local text_buffer_id2 = imgui.ImBuffer(256)
local text_buffer_pt3 = imgui.ImBuffer(256)
local text_buffer_id3 = imgui.ImBuffer(256)
local text_buffer_pt4 = imgui.ImBuffer(256)
local text_buffer_id4 = imgui.ImBuffer(256)
local text_buffer_pt5 = imgui.ImBuffer(256)
local text_buffer_id5 = imgui.ImBuffer(256)
local text_buffer_pt6 = imgui.ImBuffer(256)
local text_buffer_id6 = imgui.ImBuffer(256)
local text_buffer_pt7 = imgui.ImBuffer(256)
local text_buffer_id7 = imgui.ImBuffer(256)
local text_buffer_pt8 = imgui.ImBuffer(256)
local text_buffer_id8 = imgui.ImBuffer(256)
local text_buffer_nick = imgui.ImBuffer(256)
local text_buffer_car  = imgui.ImBuffer(256)

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

local coord = {
	[u8:decode'возле Russian Mafia.'] = { x = 1048.270020, y = 2111.360107, z = 10.820000 },
	[u8:decode'в Montgomery.'] = { x = 1336.939941, y = 287.940002, z = 19.559999 },
	[u8:decode'в San-Fierro'] = { x = -2437.260010, y = 1035.900024, z = 50.389999 },
	[u8:decode'возле Фермы 3.'] = { x = 253.089996, y = 8.980000, z = 2.450000 },
	[u8:decode'рядом с Дальнобоем.'] = { x = 2121.6999511719, y = 2719.1398925781, z = 10.819999694824 }
} -- by Serhiy_Rubin

local zone = {
	[u8:decode"Мэрия"] = { x = 1481.229248, y = -1749.487305, z = 15.445300},
	[u8:decode"Автошкола"] = { x = -2026.514404, y = -95.752701, z = 34.729801},
	[u8:decode"Автовокзал [LS]"] = { x = 1143.750122, y = -1746.589111, z = 13.135900},
	[u8:decode"ЖД вокзал [LS]"] = { x = 1808.494507, y = -1896.349854, z = 13.068900},
	[u8:decode"Авто/ЖД вокзал [SF]"] = { x = -1985.027222, y = 113.767799, z = 27.256201},
	[u8:decode"Авто/ЖД вокзал [LV]"] = { x = 2843.035156, y = 1343.983032, z = 10.352100},
	[u8:decode"Fort Carson"] = { x = 61.247101, y = 1189.191040, z = 18.397301},
	[u8:decode"Прием металла"] = { x = 2263.516846, y = -2537.962158, z = 8.374100},
	[u8:decode"Наркопритон"] = { x = 2182.824707, y = -1669.634644, z = 14.134600},
	[u8:decode"Аэропорт [LS]"] = { x = 1967.201050, y = -2173.359375, z = 13.056900},
	[u8:decode"Аэропорт [SF]"] = { x = -1551.542847, y = -436.707214, z = 5.571300},
	[u8:decode"Аэропорт [LV]"] = { x = 1726.291260, y = 1610.033325, z = 9.659000},
	[u8:decode"Причал"] = { x = -2704.270996, y = 2367.194824, z = 70.221397},
	[u8:decode"Vinewood"] = { x = 1380.432251, y = -897.429016, z = 36.463100},
	[u8:decode"Пляж Santa Maria"] = { x = 331.410309, y = -1802.567505, z = 4.184100},
	[u8:decode"Стадион [SF]"] = { x = -2133.911133, y = -444.985199, z = 35.335800},
	[u8:decode"Спортзал [LV]"] = { x = 2098.566895, y = 2480.085938, z = 10.820300},
	[u8:decode"Пейнтбол"] = { x = 2488.860107, y = 2776.471191, z = 10.787000},
	[u8:decode"Церковь"] = { x = -1981.333252, y = 1117.466675, z = 53.123600},
	[u8:decode"Военкомат"] = { x = -551.301514, y = 2593.905029, z = 53.928398},
	[u8:decode"Перегон машин. Получение"] = { x = 2476.624756, y = -2596.437256, z = 13.648400},
	[u8:decode"Перегон машин. Сдача"] = { x = -1705.791138, y = 12.411100, z = 3.554700},
	[u8:decode"Торговая площадка"] = { x = -1939.609131, y = 555.069824, z = 35.171902},
	[u8:decode"Черный рынок"] = { x = 2519.776367, y = -1272.694214, z = 34.883598},
	[u8:decode"Кладбище"] = { x = 815.756226, y = -1103.168091, z = 25.790300},
	[u8:decode"Банк ЛС"] = { x = 1411.718750, y = -1699.705566, z = 13.539500},
	[u8:decode"Банк СФ"] = { x = -2226.506348, y = 251.924103, z = 35.320301},
	[u8:decode"Банк ЛВ"] = { x = 2412.576660, y = 1123.766235, z = 10.820300},
	[u8:decode"Склад с алкоголем"] = { x = -49.508301, y = -297.973602, z = 4.979400},
	[u8:decode"Нефтезавод"] = { x = -1029.870972, y = -590.956909, z = 32.012501},
	[u8:decode"Склад продуктов"] = { x = -502.780609, y = -553.796204, z = 25.087400},
	[u8:decode"Склад для урожая с ферм"] = { x = 1629.969971, y = 2326.031494, z = 10.820300},
	[u8:decode"Автобусный парк"] = { x = 1638.358643, y = -1148.711914, z = 23.479000},
	[u8:decode"Стоянка машин Хот догов"] = { x = -2407.622803, y = 741.159424, z = 34.924900},
	[u8:decode"Стоянка Инкассаторов"] = { x = -2206.516113, y = 312.605194, z = 35.443501},
	[u8:decode"Работа грузчика"] = { x = 2230.001709, y = -2211.310547, z = 13.546800},
	[u8:decode"Склад с наркотиками"] = { x = 2182.824707, y = -1669.634644, z = 14.134600},
	[u8:decode"Спортзал [LV]"] = { x = 2098.566895, y = 2480.085938, z = 10.820300},
	[u8:decode"Автоугонщики"] = { x = 2494.080078, y = -1464.709961, z = 24.020000},
	[u8:decode"Стоянка грабителей ЛЭП"] = { x = 2285.899658, y = -2339.326904, z = 13.546900},
	[u8:decode"Стоянка электриков"] = { x = -84.297798, y = -1125.867188, z = 0.655700},
	[u8:decode"Клуб Alhambra"] = { x = 1827.609253, y = -1682.122070, z = 13.118200},
	[u8:decode"Клуб Jizzy"] = { x = -2593.454834, y = 1362.782349, z = 6.657800},
	[u8:decode"Клуб Pig Pen"] = { x = 2417.153076, y = -1244.189941, z = 23.380501},
	[u8:decode"Бар Grove street"] = { x = 2306.214355, y = -1651.560547, z = 14.055600},
	[u8:decode"Бар Misty"] = { x = -2246.219482, y = -90.975998, z = 34.886700},
	[u8:decode"Клуб Amnesia"] = { x = 2507.358398, y = 1242.260132, z = 10.826900},
	[u8:decode"Бар Big Spread Ranch"] = { x = 693.625305, y = 1967.683716, z = 5.539100},
	[u8:decode"Бар Lil Probe Inn"] = { x = -89.612503, y = 1378.249268, z = 10.469700},
	[u8:decode"Бар Tierra Robada"] = { x = -2501.242920, y = 2318.692627, z = 4.984300},
	[u8:decode"Comedy club"] = { x = 1879.190918, y = 2339.538330, z = 11.979900},
	[u8:decode"4 Дракона"] = { x = 2019.318115, y = 1007.755920, z = 10.820300},
	[u8:decode"Калигула"] = { x = 2196.960693, y = 1677.085815, z = 12.367100},
	[u8:decode"Склад бара 4Драконов"] = { x = 1908.672607, y = 965.244629, z = 10.820300},
	[u8:decode"Склад бара Калигулы"] = { x = 2314.892822, y = 1733.299561, z = 10.820300},
	[u8:decode"Belagio"] = { x = 1658.526611, y = 2250.043457, z = 12.070100},
	[u8:decode"Sobrino de Botin"] = { x = 2269.751465, y = -74.159599, z = 27.772400},
	[u8:decode"Автосалон: Nope"] = { x = 557.109619, y = -1285.791626, z = 16.809401},
	[u8:decode"Автосалон: D and C"] = { x = -1987.325806, y = 288.925507, z = 33.982700},
	[u8:decode"Автосалон: B and A"] = { x = -1638.351440, y = 1202.657227, z = 6.762800},
	[u8:decode"Автосалон [LV]:  B and A"] = { x = 2159.575195, y = 1385.734131, z = 10.386600},
	[u8:decode"Магазин одежды [LS]"] = { x = 461.512390, y = -1500.866211, z = 31.059700},
	[u8:decode"Магазин одежды [SF]"] = { x = -1694.672119, y = 951.845581, z = 24.890600},
	[u8:decode"Магазин одежды [LV]"] = { x = 2802.930664, y = 2430.718018, z = 11.062500},
	[u8:decode"Оружейный магазин [LS]"] = { x = 1363.999512, y = -1288.826660, z = 13.108200},
	[u8:decode"Оружейный магазин [SF]"] = { x = -2611.327393, y = 213.002808, z = 5.190800},
	[u8:decode"Оружейный магазин [LV]"] = { x = 2154.377686, y = 935.150208, z = 10.391700},
	[u8:decode"Аренда вертолета [LS]"] = { x = 1571.372192, y = -1335.252197, z = 16.484400},
	[u8:decode"Аренда вертолета [SF]"] = { x = -2241.166992, y = 2322.205566, z = 7.545400},
	[u8:decode"Аренда вертолета [LV]"] = { x = 2614.588379, y = 2735.326416, z = 36.538601},
	[u8:decode"Мэрия"] = { x = 1481.229248, y = -1749.487305, z = 15.445300},
	[u8:decode"Автошкола"] = { x = -2026.514404, y = -95.752701, z = 34.729801},
	[u8:decode"Медики"] = { x = -2658.259766, y = 627.981018, z = 14.453100},
	[u8:decode"Полиция [LS]"] = { x = 1548.657715, y = -1675.475220, z = 14.620200},
	[u8:decode"Полиция [SF]"] = { x = -1607.410034, y = 723.037170, z = 11.895400},
	[u8:decode"Полиция [LV]"] = { x = 2283.758789, y = 2420.525146, z = 10.381600},
	[u8:decode"ФБР"] = { x = -2418.072754, y = 497.657501, z = 29.606501},
	[u8:decode"Военная база [Авианосец]"] = { x = -1554.953613, y = 500.124207, z = 6.745500},
	[u8:decode"Военная база [Зона 51]"] = { x = 133.322205, y = 1994.773560, z = 19.049900},
	[u8:decode"Новости [LS]"] = { x = 1632.979248, y = -1712.134644, z = 12.878200},
	[u8:decode"Новости [SF]"] = { x = -2013.973755, y = 469.190094, z = 34.742901},
	[u8:decode"Новости [LV]"] = { x = 2617.339600, y = 1179.765137, z = 10.388400},
	[u8:decode"Особняк Yakuza"] = { x = 1538.844360, y = 2761.891602, z = 10.388200},
	[u8:decode"Особняк Русской мафии"] = { x = 1001.480103, y = 1690.514526, z = 10.486100},
	[u8:decode"Особняк La Cosa Nostra"] = { x = 1461.381958, y = 659.340027, z = 10.387200},
	[u8:decode"Район Grove street"] = { x = 2491.886963, y = -1666.881348, z = 12.910300},
	[u8:decode"Район Vagos"] = { x = 2803.555420, y = -1585.062500, z = 10.492400},
	[u8:decode"Район Ballas"] = { x = 2702.399414, y = -2003.425903, z = 12.972800},
	[u8:decode"Район Rifa"] = { x = 2184.550537, y = -1765.587158, z = 12.948300},
	[u8:decode"Район Aztecas"] = { x = 1723.966553, y = -2112.802734, z = 12.949000},
	[u8:decode"Ферма номер: 0"] = { x = -381.502808, y = -1438.979248, z = 25.726601},
	[u8:decode"Ферма номер: 1"] = { x = -112.575401, y = -10.423600, z = 3.109400},
	[u8:decode"Ферма номер: 2"] = { x = -1060.398560, y = -1205.524048, z = 129.218704},
	[u8:decode"Ферма номер: 3"] = { x = -5.595900, y = 67.837303, z = 3.117100},
	[u8:decode"Ферма номер: 4"] = { x = 1925.693237, y = 170.401703, z = 37.281200},
	[u8:decode"Порт ЛС"] = { x = 2507.131348, y = -2234.151855, z = 13.546900},
	[u8:decode"Порт СФ"] = { x = -1731.500000, y = 118.919899, z = 3.549900},
	[u8:decode"Нефтезавод №1"] = { x = 256.260010, y = 1414.930054, z = 10.699900},
	[u8:decode"Нефтезавод №2"] = { x = -1046.780029, y = -670.650024, z = 32.349899},
	[u8:decode"Склад угля №1"] = { x = 832.456787, y = 863.901611, z = 12.665400},
	[u8:decode"Склад угля №2"] = { x = -1872.910034, y = -1720.079956, z = 21.750000},
	[u8:decode"Лесопилка №1"] = { x = -449.269897, y = -65.660004, z = 59.409901},
	[u8:decode"Лесопилка №2"] = { x = -1978.709961, y = -2435.139893, z = 30.620001},
	[u8:decode"Аренда машин"] = { x = 2236.611816, y = 2770.693848, z = 10.302900},
	[u8:decode"Hell’s Angels MC"] = { x = 681.496521, y = -475.403198, z = 16.335800},
	[u8:decode"Mongols MC"] = { x = -1265.713867, y = 2716.588623, z = 50.266300},
	[u8:decode"Pagans MC"] = { x = -2104.451904, y = -2481.883057, z = 30.625000},
	[u8:decode"Outlaws MC"] = { x = -309.605103, y = 1303.436035, z = 53.664200},
	[u8:decode"Sons of Silence MC"] = { x = 1243.829102, y = 203.576202, z = 19.554701},
	[u8:decode"Warlocks MC"] = { x = 661.681824, y = 1717.991211, z = 7.187500},
	[u8:decode"Highwaymen MC"] = { x = 22.934000, y = -2646.949219, z = 40.465599},
	[u8:decode"Bandidos MC"] = { x = -1940.291016, y = 2380.227783, z = 49.695301},
	[u8:decode"Free Souls MC"] = { x = -253.842606, y = 2603.138184, z = 62.858200},
	[u8:decode"Vagos MC"] = { x = -315.249115, y = 1773.921875, z = 43.640499},
	[u8:decode"Idlewood"] = { x = 1940.922241, y = -1772.977905, z = 13.640600},
	[u8:decode"Mulholland"] = { x = 1003.979614, y = -937.547302, z = 42.327900},
	[u8:decode"Flint"] = { x = -90.936501, y = -1169.390747, z = 2.417000},
	[u8:decode"Whetstone"] = { x = -1605.548340, y = -2714.580322, z = 48.533501},
	[u8:decode"Doherty"] = { x = -2026.463135, y = 156.733704, z = 29.039101},
	[u8:decode"Easter"] = { x = -1675.596558, y = 413.487213, z = 7.179500},
	[u8:decode"Juniper"] = { x = -2410.803467, y = 975.240906, z = 45.460800},
	[u8:decode"ElGuebrabos"] = { x = -1328.197510, y = 2677.596924, z = 50.062500},
	[u8:decode"BoneCounty"] = { x = 614.468323, y = 1692.853638, z = 7.187500},
	[u8:decode"FortCarson"] = { x = 70.458099, y = 1218.595947, z = 18.812201},
	[u8:decode"Come-A-Lot"] = { x = 2115.459717, y = 920.206421, z = 10.820300},
	[u8:decode"PricklePine"] = { x = 2147.674561, y = 2747.945313, z = 10.820300},
	[u8:decode"Montgomery"] = { x = 1381.814453, y = 459.148010, z = 20.345100},
	[u8:decode"Dillimore"] = { x = 655.649109, y = -564.918518, z = 16.335800},
	[u8:decode"AngelPine"] = { x = -2243.743896, y = -2560.555420, z = 31.921801},
	[u8:decode"Julius"] = { x = 2640.000244, y = 1106.087646, z = 11.820300},
	[u8:decode"Emerald Isle"] = { x = 2202.513672, y = 2474.136230, z = 11.820300},
	[u8:decode"Redsands"] = { x = 1596.309814, y = 2199.004639, z = 11.820300},
	[u8:decode"Tierra Robada"] = { x = -1471.741943, y = 1863.972412, z = 33.632801},
	[u8:decode"Flats"] = { x = -2718.883301, y = 50.532200, z = 5.335900},
	[u8:decode"Palomino Creek"] = { x = 2250.245117, y = 52.701401, z = 23.667101},
	[u8:decode"Financial"] = { x = -1807.485352, y = 944.666626, z = 25.890600},
	[u8:decode"Garcia"] = { x = -2335.718750, y = -166.687805, z = 36.554501},
	[u8:decode"Esplanade"] = { x = -1721.592529, y = 1360.345215, z = 8.185100},
	[u8:decode"Marina Cluck"] = { x = 928.539917, y = -1352.939331, z = 14.343700},
	[u8:decode"Willowfield"] = { x = 2397.851563, y = -1899.040039, z = 14.546600},
	[u8:decode"East"] = { x = 2419.725586, y = -1509.026245, z = 25.000000},
	[u8:decode"Marina Burger"] = { x = 810.510010, y = -1616.193848, z = 14.546600},
	[u8:decode"Redsands West"] = { x = 1157.925537, y = 2072.282227, z = 12.062500},
	[u8:decode"Redsands East"] = { x = 1872.255249, y = 2071.863037, z = 12.062500},
	[u8:decode"Strip"] = { x = 2083.269775, y = 2224.697510, z = 12.023400},
	[u8:decode"Creek"] = { x = 2838.201660, y = 2407.693848, z = 12.069000},
	[u8:decode"Old Venturas Strip"] = { x = 2472.861816, y = 2034.192627, z = 12.062500},
	[u8:decode"Old Venturas Strip"] = { x = 2393.200684, y = 2041.559448, z = 11.820300},
	[u8:decode"Spinybed"] = { x = 2169.407715, y = 2795.919189, z = 11.820300},
	[u8:decode"Angel Pine"] = { x = -2155.095215, y = -2460.377930, z = 30.851601},
	[u8:decode"СТО [LS]"] = { x = 854.575928, y = -605.205322, z = 18.421801},
	[u8:decode"СТО [SF]"] = { x = -1799.868042, y = 1200.299316, z = 25.119400},
	[u8:decode"СТО [LV]"] = { x = 1658.380371, y = 2200.350342, z = 10.820300},
	[u8:decode"Гараж ЛС"] = { x = 1636.659180, y = -1525.564209, z = 13.306700},
	[u8:decode"Гараж СФ"] = { x = -1979.227905, y = 436.112000, z = 25.910801},
	[u8:decode"Гараж ЛВ"] = { x = 1447.295410, y = 2370.614990, z = 10.528000},
	[u8:decode"Соревнования Гонки"] = { x = 1286.696167, y = -1329.237183, z = 13.554400},
	[u8:decode"Соревнования Страйкбол"] = { x = 2704.779053, y = -1701.145874, z = 11.843800},
} -- by Serhiy_Rubin

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
	_, my_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	my_name = sampGetPlayerNickname(my_id)
	server = sampGetCurrentServerName():gsub('|', '')
	server = (server:find('02') and 'Two' or (server:find('Revolution') and 'Revolution' or (server:find('Legacy') and 'Legacy' or (server:find('Classic') and 'Classic' or ''))))
	if server == '' then thisScript():unload() end
	AdressConfig = string.format("%s\\moonloader\\config" , getGameDirectory())
	AdressFolder = string.format("%s\\moonloader\\config\\GhettoMate\\%s\\%s", getGameDirectory(), server, my_name)
	if not doesDirectoryExist(AdressConfig) then createDirectory(AdressConfig) end
	if not doesDirectoryExist(AdressFolder) then createDirectory(AdressFolder) end
	directIni = string.format("GhettoMate\\%s\\%s\\GhettoMate.ini", server, my_name)
	directIni2 = string.format("GhettoMate\\%s\\%s\\GhettoMateMoney.ini", server, my_name)
	directIni3 = string.format("GhettoMate\\%s\\GhettoMateTime.ini", server)
	directIni4 = string.format("GhettoMate\\%s\\%s\\GhettoMateSettings.ini", server, my_name)

	sampRegisterChatCommand("lhud", cmd_hud)
	sampRegisterChatCommand("gm", cmd_menu)
	sampRegisterChatCommand("mohud", cmd_MOhud)
	sampRegisterChatCommand("gfind", cmd_sucher)
	sampRegisterChatCommand("drugs", cmd_usedrugs)

	Wait         = lua_thread.create_suspended(Waiting)
	MOWait       = lua_thread.create_suspended(MOWaiting)
	Wait2        = lua_thread.create_suspended(Waiting2)
	MOWait2      = lua_thread.create_suspended(MOWaiting2)
	DrugsWait    = lua_thread.create_suspended(DrugsWaiting)
	UseDrugsWait = lua_thread.create_suspended(UseDrugsWaiting)
	MONotifyWait = lua_thread.create_suspended(MONotifyWaiting)
	GunWait      = lua_thread.create_suspended(GunWaiting)

	soundManager.loadSound("message_sms")
	soundManager.loadSound("message_news")
	soundManager.loadSound("message_tip")
	soundManager.loadSound("message_alarm")
	soundManager.loadSound("message_sos")

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
		ini = inicfg.load({
			[GhettoMateConfig] = {
				time            = tonumber(0),
				X               = tonumber(resX/2),
				Y               = tonumber(resY/2),
				X_MO            = tonumber(resX/2),
				Y_MO            = tonumber(resX/2),
				timeCalibration = false,
				price_Deagle    = tonumber(200),
				price_M4        = tonumber(200),
				price_Shotgun   = tonumber(200),
				price_SDpistol  = tonumber(100),
				price_AK47      = tonumber(200),
				price_SMG       = tonumber(150),
				price_Rifle     = tonumber(300),
				price_Drugs     = tonumber(30),
				my_mats         = tonumber(0),
				my_drugs        = tonumber(0)
			}
		}, directIni)
		inicfg.save(ini, directIni)
	end

	GunList = string.format('GunList')
	if ini[GunList] == nil then
		ini = inicfg.load({
			[GunList] = {
				gun1 = tonumber(0),
				pt1  = tonumber(30),
				gun2 = tonumber(1),
				pt2  = tonumber(160),
				gun3 = tonumber(2),
				pt3  = tonumber(10)
			}
		}, directIni)
		inicfg.save(ini, directIni)
	end

	GhettoMateMoney = string.format('GhettoMateMoney')
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

	GhettoMateMO = string.format('GhettoMateMO')
	if ini2[GhettoMateMO] == nil then
		ini2 = inicfg.load({
			[GhettoMateMO] = {
				mats  = tonumber(0),
				cars  = tonumber(0)
			}
		}, directIni2)
		inicfg.save(ini2, directIni2)
	end

	GhettoMateCapture = string.format('GhettoMateCapture')
	if ini2[GhettoMateCapture] == nil then
		ini2 = inicfg.load({
			[GhettoMateCapture] = {
				kill          = tonumber(0),
				death         = tonumber(0),
				grove_kill    = tonumber(0),
				ballas_kill   = tonumber(0),
				aztecas_kill  = tonumber(0),
				vagos_kill    = tonumber(0),
				rifa_kill     = tonumber(0),
				gun_fist      = tonumber(0),
				gun_m4        = tonumber(0),
				gun_deagle    = tonumber(0),
				gun_ak47      = tonumber(0),
				gun_sdpistol  = tonumber(0),
				gun_shotgun   = tonumber(0),
				gun_rifle     = tonumber(0),
				gun_bat       = tonumber(0),
				gun_ost       = tonumber(0),
				CaptureKill   = tonumber(0),
				CaptureDeath  = tonumber(0)
			}
		}, directIni2)
		inicfg.save(ini2, directIni2)
	end

	GhettoMateTime = string.format('GhettoMateTime')
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

	GhettoMateSeconds = string.format('GhettoMateSeconds')
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

	TimeMO = string.format('TimeMO')
	if ini3[TimeMO] == nil then
		ini3 = inicfg.load({
			[TimeMO] = {
				time1 = u8:decode"Неизвестно",
				time2 = u8:decode"Неизвестно",
				time3 = u8:decode"Неизвестно"
			}
		}, directIni3)
		inicfg.save(ini3, directIni3)
	end

	SecondsMO = string.format('SecondsMO')
	if ini3[SecondsMO] == nil then
		ini3 = inicfg.load({
			[SecondsMO] = {
				time1 = tonumber(0),
				time2 = tonumber(0),
				time3 = tonumber(0)
			}
		}, directIni3)
		inicfg.save(ini3, directIni3)
	end

	GhettoMateSettings = string.format('GhettoMateSettings')
	if ini4[GhettoMateSettings] == nil then
		ini4 = inicfg.load({
			[GhettoMateSettings] = {
				NotifyLarek       = true,
				TimerNotifyLarek  = tonumber(15),
				NotifyUgonyala    = true,
				AnimUgonyala      = true,
				IdAnimUgonyala    = tonumber(14),
				NotifyFind        = true,
				NotifyDrugs       = true,
				NotifyAutoGetGuns = true,
				TimerNotifyMO     = tonumber(15),
				NotifyMO          = true,
				Health            = 120,
				Sounds            = false,
				NotifyCapture     = true
			}
		}, directIni4)
		inicfg.save(ini4, directIni4)
	end

	ini  = inicfg.load(GhettoMateConfig, directIni)
	ini2 = inicfg.load(GhettoMateMoney, directIni2)
	ini3 = inicfg.load(GhettoMateTime, directIni3)
	ini4 = inicfg.load(GhettoMateSettings, directIni4)
	imgui.initBuffers()

	checkUpdates()
	sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Успешно загрузился!", main_color)

	if not ini[GhettoMateConfig].timeCalibration then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Откалибруйте время в /gm", main_color)
	end

	imgui.ApplyCustomStyle()
	imgui.GetIO().Fonts:Clear()
	imgui.GetIO().Fonts:AddFontFromFileTTF("C:\\Windows\\Fonts\\arial.ttf", 14/(1600/getScreenResolution()), nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	imgui.RebuildFonts()
	imgui.Process = false
	imgui.ShowCursor = false
	while true do
		wait(250)
		
		paused = isGamePaused()

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
		TimerMO()
		TimerM()
		TimerMMO()
		Refresh()
		RefreshMO()
		AfterDeathReload()
		LarekChecker()
		MOChecker()

		if isKeyJustPressed(VK_MULTIPLY) then
			cmd_autogetguns()
		end

		if isKeyJustPressed(VK_ADD) then
			cmd_usedrugs()
		end

		if Find then
			Suchen()
		end

		DrugsTimer = UseDrugsTimer - os.clock()

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
						if getCarDoorLockStatus(car) == 2 then
							isRepeat = false
							isRepeatTwo = false
							for k, vehh in ipairs(vehlist) do
								if vehId == vehh[5] then
									isRepeat = true
									isRepeatTwo = true
									vehh[2] = posX
									vehh[3] = posY
									vehh[4] = posZ
									vehh[6] = driverNickname
									vehh[7] = os.clock()
									if carname then
										if string.lower(carname) == string.lower(vehnames[modelid-399]) and driverNickname ~= my_name then
											removeMarks()
											mark = addSpriteBlipForCoord(vehh[2],vehh[3],vehh[4],55)
											ugcheckpoint = createCheckpoint(1, vehh[2],vehh[3],vehh[4],vehh[2],vehh[3],vehh[4], 1)
											search = true
											if ini4[GhettoMateSettings].NotifyUgonyala then
												if isDriver then
													--sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Транспорт {FF0000}\"%s\" {FFFFFF}обнаружен! За рулем: {FF0000}%s", vehnames[modelid-399], driverNickname), main_color)
												else
													--sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Транспорт {FF0000}\"%s\" {FFFFFF}обнаружен!", vehnames[modelid-399]), main_color)
												end
												if ini4[GhettoMateSettings].Sounds then
													--soundManager.playSound("message_tip")
												end
											end
											--[[if marks then
												for i, mark in ipairs(marks) do
													removeBlip(mark)
												end
											end
											if ugcheckpoints then
												for i, ugcheckpoint in ipairs(ugcheckpoints) do
													deleteCheckpoint(ugcheckpoint)
												end
											end]]
										end
									end
								end
							end
							if not isRepeat and not search and driverNickname ~= my_name then
								table.insert(vehlist, {vehnames[modelid-399], posX, posY, posZ, vehId, driverNickname, os.clock()})
							end
							if not isRepeatTwo and search and driverNickname ~= my_name then
								table.insert(vehlist, {vehnames[modelid-399],posX,posY,posZ,vehId, driverNickname, os.clock()})
								if string.lower(carname) == string.lower(vehnames[modelid-399]) then
									if ini4[GhettoMateSettings].NotifyUgonyala then
										if isDriver then
											sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FF0000}\"%s\" {FFFFFF}обнаружен! За рулем: {FF0000}%s", vehnames[modelid-399], driverNickname), main_color)
										else
											sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FF0000}\"%s\" {FFFFFF}обнаружен!", vehnames[modelid-399]), main_color)
										end
										if ini4[GhettoMateSettings].Sounds then
											soundManager.playSound("message_tip")
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
									if driverNickname ~= my_name then
										vehh[6] = driverNickname
									end
									vehh[7] = os.clock()
									if carname then
										if string.lower(carname) == string.lower(vehnames[modelid-399]) and driverNickname ~= my_name then
											removeMarks()
											mark = addSpriteBlipForCoord(vehh[2],vehh[3],vehh[4],55)
											ugcheckpoint = createCheckpoint(1, vehh[2],vehh[3],vehh[4],vehh[2],vehh[3],vehh[4], 1)
											if ini4[GhettoMateSettings].NotifyUgonyala then
												if isDriver then
												--	sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Открытый {FF0000}\"%s\" {FFFFFF}обнаружен! За рулем: {FF0000}%s", vehnames[modelid-399], driverNickname), main_color)
												else
												--	sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Открытый {FF0000}\"%s\" {FFFFFF}обнаружен!", vehnames[modelid-399]), main_color)
												end
												if ini4[GhettoMateSettings].Sounds then
													soundManager.playSound("message_tip")
												end
											end
											--[[if marks then
												for i, mark in ipairs(marks) do
													removeBlip(mark)
												end
											end
											if ugcheckpoints then
												for i, ugcheckpoint in ipairs(ugcheckpoints) do
													deleteCheckpoint(ugcheckpoint)
												end
											end]]
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
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Угон снова доступен", main_color)
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_tip")
					end
					sound = false
				end
			end
		end
	end
end

function cmd_hud(arg)
	larek_window_state.v = not larek_window_state.v
	if not larek_window_state.v and not mo_window_state.v and not main_window_state.v then
		imgui.Process = false
	end
	if larek_window_state.v then
		imgui.Process = true
	end
end

function cmd_MOhud(arg)
	mo_window_state.v = not mo_window_state.v
	if not larek_window_state.v and not mo_window_state.v and not main_window_state.v then
		imgui.Process = false
	end
	if mo_window_state.v then
		imgui.Process = true
	end
end

function cmd_menu()
	main_window_state.v = not main_window_state.v
	if not larek_window_state.v and not mo_window_state.v and not main_window_state.v then
		imgui.Process = false
	end
	if main_window_state.v then
		imgui.Process = true
	end
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

function imgui.initBuffers()
	imgui.settingsTab = 1

	imgui.LarekName1  = imgui.ImBuffer(u8(ini[GhettoMateName].Name1),  256)
	imgui.LarekName2  = imgui.ImBuffer(u8(ini[GhettoMateName].Name2),  256)
	imgui.LarekName3  = imgui.ImBuffer(u8(ini[GhettoMateName].Name3),  256)
	imgui.LarekName4  = imgui.ImBuffer(u8(ini[GhettoMateName].Name4),  256)
	imgui.LarekName5  = imgui.ImBuffer(u8(ini[GhettoMateName].Name5),  256)
	imgui.LarekName6  = imgui.ImBuffer(u8(ini[GhettoMateName].Name6),  256)
	imgui.LarekName7  = imgui.ImBuffer(u8(ini[GhettoMateName].Name7),  256)
	imgui.LarekName8  = imgui.ImBuffer(u8(ini[GhettoMateName].Name8),  256)
	imgui.LarekName9  = imgui.ImBuffer(u8(ini[GhettoMateName].Name9),  256)
	imgui.LarekName10 = imgui.ImBuffer(u8(ini[GhettoMateName].Name10), 256)
	imgui.LarekName11 = imgui.ImBuffer(u8(ini[GhettoMateName].Name11), 256)
	imgui.LarekName12 = imgui.ImBuffer(u8(ini[GhettoMateName].Name12), 256)
	imgui.LarekName13 = imgui.ImBuffer(u8(ini[GhettoMateName].Name13), 256)
	imgui.LarekName14 = imgui.ImBuffer(u8(ini[GhettoMateName].Name14), 256)
	imgui.LarekName15 = imgui.ImBuffer(u8(ini[GhettoMateName].Name15), 256)
	imgui.LarekName16 = imgui.ImBuffer(u8(ini[GhettoMateName].Name16), 256)

	imgui.TimerNotifyMO = imgui.ImInt(ini4[GhettoMateSettings].TimerNotifyMO)
	imgui.Health = imgui.ImInt(ini4[GhettoMateSettings].Health)
	imgui.IdAnimUgonyala = imgui.ImInt(ini4[GhettoMateSettings].IdAnimUgonyala)
	imgui.TimerNotifyLarek = imgui.ImInt(ini4[GhettoMateSettings].TimerNotifyLarek)

	imgui.price_Drugs = imgui.ImInt(ini.GhettoMateConfig.price_Drugs)
	imgui.price_Deagle = imgui.ImInt(ini.GhettoMateConfig.price_Deagle)
	imgui.price_M4 = imgui.ImInt(ini.GhettoMateConfig.price_M4)
	imgui.price_Shotgun = imgui.ImInt(ini.GhettoMateConfig.price_Shotgun)
	imgui.price_SDpistol = imgui.ImInt(ini.GhettoMateConfig.price_SDpistol)
	imgui.price_AK47 = imgui.ImInt(ini.GhettoMateConfig.price_AK47)
	imgui.price_SMG = imgui.ImInt(ini.GhettoMateConfig.price_SMG)
	imgui.price_Rifle = imgui.ImInt(ini.GhettoMateConfig.price_Rifle)

	combo_select1 = imgui.ImInt(ini.GunList.gun1)
	combo_select2 = imgui.ImInt(ini.GunList.gun2)
	combo_select3 = imgui.ImInt(ini.GunList.gun3)
	imgui.pt1 = imgui.ImInt(ini.GunList.pt1)
	imgui.pt2 = imgui.ImInt(ini.GunList.pt2)
	imgui.pt3 = imgui.ImInt(ini.GunList.pt3)

end

function imgui.OnDrawFrame()
	if main_window_state.v then
		local resX, resY = getScreenResolution()
		imgui.SetNextWindowSize(vec(212, 190))
		imgui.SetNextWindowPos(vec(200, 118), 2)
		imgui.ShowCursor = true
		imgui.Begin('GhettoMate ', main_window_state, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
		imgui.BeginChild('top', vec(210, 9), false)
			imgui.BeginChild("##inp101", vec(32.5,9), false)
				if imgui.Selectable(' Параметры', imgui.settingsTab == 1) then
					imgui.settingsTab = 1
				end
			imgui.EndChild()
			imgui.SameLine()
			imgui.BeginChild("##inp102",vec(32.5, 9), false)
				if imgui.Selectable('       Larek', imgui.settingsTab == 2) then
					imgui.settingsTab = 2
				end
			imgui.EndChild()
			imgui.SameLine()
			imgui.BeginChild("##inp103",vec(32.5, 9), false)
				if imgui.Selectable('         MO', imgui.settingsTab == 3) then
					imgui.settingsTab = 3
				end
			imgui.EndChild()
			imgui.SameLine()
			imgui.BeginChild("##inp104",vec(32.5, 9), false)
				if imgui.Selectable('      Seller', imgui.settingsTab == 4) then
					imgui.settingsTab = 4
				end
			imgui.EndChild()
			imgui.SameLine()
			imgui.BeginChild("##inp105",vec(32.5, 9), false)
				if imgui.Selectable('     Capture', imgui.settingsTab == 5) then
					imgui.settingsTab = 5
				end
			imgui.EndChild()
			imgui.SameLine()
			imgui.BeginChild("##inp107",vec(32.5, 9), false)
				if imgui.Selectable(' Информация', imgui.settingsTab == 6) then
					imgui.settingsTab = 6
				end
			imgui.EndChild()
		imgui.EndChild()

		imgui.BeginChild('bottom', vec(205, 160), true)
		if imgui.settingsTab == 1 then
			imgui.initBuffers()
			if imgui.Checkbox("Уведомления от Larek. Таймер уведомлений: ", imgui.ImBool(ini4[GhettoMateSettings].NotifyLarek)) then
				ini4[GhettoMateSettings].NotifyLarek = not ini4[GhettoMateSettings].NotifyLarek
				inicfg.save(ini4, directIni4)
			end
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##inp1", imgui.TimerNotifyLarek, 1, 1) then
				if imgui.TimerNotifyLarek.v ~= nil and imgui.TimerNotifyLarek.v ~= "" and imgui.TimerNotifyLarek.v >= 0 and imgui.TimerNotifyLarek.v <= 1800 then
					ini4[GhettoMateSettings].TimerNotifyLarek = imgui.TimerNotifyLarek.v
					inicfg.save(ini4, directIni4)
				end
			end
			imgui.PopItemWidth()
			if imgui.Checkbox("Уведомления от Ugonyala", imgui.ImBool(ini4[GhettoMateSettings].NotifyUgonyala)) then
				ini4[GhettoMateSettings].NotifyUgonyala = not ini4[GhettoMateSettings].NotifyUgonyala
				inicfg.save(ini4, directIni4)
			end
			if imgui.Checkbox("Анимация угона:", imgui.ImBool(ini4[GhettoMateSettings].AnimUgonyala)) then
				ini4[GhettoMateSettings].AnimUgonyala = not ini4[GhettoMateSettings].AnimUgonyala
				inicfg.save(ini4, directIni4)
			end
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##inp2", imgui.IdAnimUgonyala, 1, 1) then
				if imgui.IdAnimUgonyala.v ~= nil and imgui.IdAnimUgonyala.v ~= "" and imgui.IdAnimUgonyala.v >= 0 and imgui.IdAnimUgonyala.v <= 45 then
					ini4[GhettoMateSettings].IdAnimUgonyala = imgui.IdAnimUgonyala.v
					inicfg.save(ini4, directIni4)
				end
			end
			imgui.PopItemWidth()
			if imgui.Checkbox("Уведомления от поиска игрока", imgui.ImBool(ini4[GhettoMateSettings].NotifyFind)) then
				ini4[GhettoMateSettings].NotifyFind = not ini4[GhettoMateSettings].NotifyFind
				inicfg.save(ini4, directIni4)
			end

			if imgui.Checkbox("Уведомления от Drugs. Максимальное количество ХП: ", imgui.ImBool(ini4[GhettoMateSettings].NotifyDrugs)) then
				ini4[GhettoMateSettings].NotifyDrugs = not ini4[GhettoMateSettings].NotifyDrugs
				inicfg.save(ini4, directIni4)
			end
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##inp3", imgui.Health, 1, 1) then
				if imgui.Health.v ~= nil and imgui.Health.v ~= "" then
					ini4[GhettoMateSettings].Health = imgui.Health.v
					inicfg.save(ini4, directIni4)
				end
			end
			imgui.PopItemWidth()
			if imgui.Checkbox("Уведомления от AutoGetGuns", imgui.ImBool(ini4[GhettoMateSettings].NotifyAutoGetGuns)) then
				ini4[GhettoMateSettings].NotifyAutoGetGuns = not ini4[GhettoMateSettings].NotifyAutoGetGuns
				inicfg.save(ini4, directIni4)
			end
			if imgui.Checkbox("Уведомления от магазинов одежды. Таймер уведомлений: ", imgui.ImBool(ini4[GhettoMateSettings].NotifyMO)) then
				ini4[GhettoMateSettings].NotifyMO = not ini4[GhettoMateSettings].NotifyMO
				inicfg.save(ini4, directIni4)
			end
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##inp4", imgui.TimerNotifyMO, 1, 1) then
				if imgui.TimerNotifyMO.v ~= nil and imgui.TimerNotifyMO.v ~= "" and imgui.TimerNotifyMO.v >= 0 and imgui.TimerNotifyMO.v <= 1800 then
					ini4[GhettoMateSettings].TimerNotifyMO = imgui.TimerNotifyMO.v
					inicfg.save(ini4, directIni4)
				end
			end
			imgui.PopItemWidth()
			if imgui.Checkbox("Звуки", imgui.ImBool(ini4[GhettoMateSettings].Sounds)) then
				ini4[GhettoMateSettings].Sounds = not ini4[GhettoMateSettings].Sounds
				inicfg.save(ini4, directIni4)
			end
			if imgui.Checkbox("Уведомления во время капта", imgui.ImBool(ini4[GhettoMateSettings].NotifyCapture)) then
				ini4[GhettoMateSettings].NotifyCapture = not ini4[GhettoMateSettings].NotifyCapture
				inicfg.save(ini4, directIni4)
			end

			if larek_window_state.v then
				if imgui.Button("Выключить Larek HUD", vec(55,0)) then
					cmd_hud()
				end
			else
				if imgui.Button("Включить Larek HUD", vec(55,0)) then
					cmd_hud()
				end
			end
			imgui.SameLine(toScreenX(60))
			if InterfacePosition then
				if imgui.Button("Фиксация HUDa" .. "##inp1110", vec(55,0)) then
					InterfacePosition = not InterfacePosition
					inicfg.save(ini, directIni)
				end
			else
				if imgui.Button("Зафиксировать HUD" .. "##inp1113", vec(55,0)) then
					InterfacePosition = not InterfacePosition
					inicfg.save(ini, directIni)
				end
			end
			if not ini[GhettoMateConfig].timeCalibration then
				imgui.SameLine(toScreenX(120))
				if imgui.Button("Откалибровать время", vec(60,0)) then
					Calibration()
				end
			end

			if mo_window_state.v then
				if imgui.Button("Выключить MO HUD", vec(55,0)) then
					cmd_MOhud()
				end
			else
				if imgui.Button("Включить MO HUD", vec(55,0)) then
					cmd_MOhud()
				end
			end
			imgui.SameLine(toScreenX(60))
			if InterfacePositionMO then
				if imgui.Button("Фиксация HUDa" .. "##inp1111", vec(55,0)) then
					InterfacePositionMO = not InterfacePositionMO
					inicfg.save(ini, directIni)
				end
			else
				if imgui.Button("Зафиксировать HUD" .. "##inp1112", vec(55,0)) then
					InterfacePositionMO = not InterfacePositionMO
					inicfg.save(ini, directIni)
				end
			end

			if not search then
				imgui.PushItemWidth(toScreenX(55))
				imgui.InputText(u8"##inp111", text_buffer_car)
				imgui.PopItemWidth()
				imgui.SameLine()
				if imgui.Button("Искать машину", vec(55,0)) then
					if text_buffer_car.v ~= nil and text_buffer_car.v ~= "" then
						sampSendChat("/fc " .. text_buffer_car.v)
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ошибка", main_color)
					end
				end
			else
				if imgui.Button("Прекратить поиск машины", vec(112,0)) then
					sampSendChat("/fc")
				end
			end
			if ugtimer ~= nil and ugtimer ~= "" and isNumber(ugtimer) and ugtimer > 0 then
				imgui.SameLine(toScreenX(116))
				imgui.Text("" .. math.floor(ugtimer))
			end

			if DrugsTimer ~= nil and DrugsTimer ~= "" and isNumber(DrugsTimer) and DrugsTimer > 0 then
				imgui.SameLine(toScreenX(139.5))
				imgui.Text("" .. math.floor(DrugsTimer))
			end
				
			imgui.SameLine(toScreenX(148))
			if not Use then
				if imgui.Button("Drugs OFF", vec(55,0)) then
					cmd_usedrugs()
				end
			else
				if imgui.Button("Drugs ON", vec(55,0)) then
					cmd_usedrugs()
				end
			end

			if not Find then
				imgui.PushItemWidth(toScreenX(55))
				imgui.InputText(u8"##inp112", text_buffer_nick)
				imgui.PopItemWidth()
				imgui.SameLine()
				if imgui.Button("Искать игрока по id", vec(55,0)) then
					if text_buffer_nick.v ~= nil and text_buffer_nick.v ~= "" and isNumber(text_buffer_nick.v) then
						cmd_sucher(text_buffer_nick.v)
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ошибка", main_color)
					end
				end
			else
				if imgui.Button("Прекратить поиск игрока", vec(112,0)) then
					cmd_sucher(0)
				end
			end
			imgui.SameLine(toScreenX(148))
			if not GetGuns then
				if imgui.Button("AutoGetGuns ON", vec(55,0)) then
					cmd_autogetguns()
				end
			else
				if imgui.Button("AutoGetGuns OFF", vec(55,0)) then
					cmd_autogetguns()
				end
			end


		elseif imgui.settingsTab == 2 then
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10001', imgui.LarekName1) then
				if imgui.LarekName1.v ~= nil and imgui.LarekName1.v ~= "" then
					ini[GhettoMateName].Name1 = u8:decode(imgui.LarekName1.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[1] .. ini3[GhettoMateTime].time1)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10002', imgui.LarekName9) then
				if imgui.LarekName9.v ~= nil and imgui.LarekName9.v ~= "" then
					ini[GhettoMateName].Name9 = u8:decode(imgui.LarekName9.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[9] .. ini3[GhettoMateTime].time9)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10003', imgui.LarekName2) then
				if imgui.LarekName2.v ~= nil and imgui.LarekName2.v ~= "" then
					ini[GhettoMateName].Name2 = u8:decode(imgui.LarekName2.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8""  .. color[2] .. ini3[GhettoMateTime].time2)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10004', imgui.LarekName10) then
				if imgui.LarekName10.v ~= nil and imgui.LarekName10.v ~= "" then
					ini[GhettoMateName].Name10 = u8:decode(imgui.LarekName10.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[10] .. ini3[GhettoMateTime].time10)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10005', imgui.LarekName3) then
				if imgui.LarekName3.v ~= nil and imgui.LarekName3.v ~= "" then
					ini[GhettoMateName].Name3 = u8:decode(imgui.LarekName3.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[3] .. ini3[GhettoMateTime].time3)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10006', imgui.LarekName11) then
				if imgui.LarekName11.v ~= nil and imgui.LarekName11.v ~= "" then
					ini[GhettoMateName].Name11 = u8:decode(imgui.LarekName11.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[11] .. ini3[GhettoMateTime].time11)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10007', imgui.LarekName4) then
				if imgui.LarekName4.v ~= nil and imgui.LarekName4.v ~= "" then
					ini[GhettoMateName].Name4 = u8:decode(imgui.LarekName4.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[4] .. ini3[GhettoMateTime].time4)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10008', imgui.LarekName12) then
				if imgui.LarekName12.v ~= nil and imgui.LarekName12.v ~= "" then
					ini[GhettoMateName].Name12 = u8:decode(imgui.LarekName12.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[12] .. ini3[GhettoMateTime].time12)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp10009', imgui.LarekName5) then
				if imgui.LarekName5.v ~= nil and imgui.LarekName5.v ~= "" then
					ini[GhettoMateName].Name5 = u8:decode(imgui.LarekName5.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[5] .. ini3[GhettoMateTime].time5)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100010', imgui.LarekName13) then
				if imgui.LarekName13.v ~= nil and imgui.LarekName13.v ~= "" then
					ini[GhettoMateName].Name13 = u8:decode(imgui.LarekName13.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[13] .. ini3[GhettoMateTime].time13)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100011', imgui.LarekName6) then
				if imgui.LarekName6.v ~= nil and imgui.LarekName6.v ~= "" then
					ini[GhettoMateName].Name6 = u8:decode(imgui.LarekName6.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[6] .. ini3[GhettoMateTime].time6)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100012', imgui.LarekName14) then
				if imgui.LarekName14.v ~= nil and imgui.LarekName14.v ~= "" then
					ini[GhettoMateName].Name14 = u8:decode(imgui.LarekName14.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[14] .. ini3[GhettoMateTime].time14)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100013', imgui.LarekName7) then
				if imgui.LarekName7.v ~= nil and imgui.LarekName7.v ~= "" then
					ini[GhettoMateName].Name7 = u8:decode(imgui.LarekName7.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[7] .. ini3[GhettoMateTime].time7)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100014', imgui.LarekName15) then
				if imgui.LarekName15.v ~= nil and imgui.LarekName15.v ~= "" then
					ini[GhettoMateName].Name15 = u8:decode(imgui.LarekName15.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[15] .. ini3[GhettoMateTime].time15)

			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100015', imgui.LarekName8) then
				if imgui.LarekName8.v ~= nil and imgui.LarekName8.v ~= "" then
					ini[GhettoMateName].Name8 = u8:decode(imgui.LarekName8.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. color[8] .. ini3[GhettoMateTime].time8)
				imgui.SameLine(toScreenX(100))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.InputText('##inp100016', imgui.LarekName16) then
				if imgui.LarekName16.v ~= nil and imgui.LarekName16.v ~= "" then
					ini[GhettoMateName].Name16 = u8:decode(imgui.LarekName16.v)
					inicfg.save(ini, directIni)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Введите название", main_color)
				end
			end
			imgui.PopItemWidth()
				imgui.SameLine(toScreenX(150))
			imgui.TextColoredRGB(u8"" .. color[16] .. ini3[GhettoMateTime].time16)

			imgui.Separator()
			imgui.TextColoredRGB(u8:decode"Денег награблено: " .. ini2[GhettoMateMoney].money)
			imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count)
			imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count2)
			imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count3)
			imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count4)
			imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count1)

		elseif imgui.settingsTab == 3 then
			imgui.TextColoredRGB(u8"1.  MO LS")
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. colorMO[1] .. ini3[TimeMO].time1)
			imgui.TextColoredRGB(u8"2.  MO SF")
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8""  .. colorMO[2] .. ini3[TimeMO].time2)
			imgui.TextColoredRGB(u8"3.  MO LV")
				imgui.SameLine(toScreenX(50))
			imgui.TextColoredRGB(u8"" .. colorMO[3] .. ini3[TimeMO].time3)
			imgui.Separator()
			imgui.TextColoredRGB(u8:decode"Статистика: ")
			imgui.TextColoredRGB(u8:decode"Материалов привезено: " .. ini2[GhettoMateMO].mats)
			imgui.TextColoredRGB(u8:decode"Фур украдено: " .. ini2[GhettoMateMO].cars)
			if imgui.Button("Сообщить тайминги" .. '##inp13', vec(55,0)) then
				MONotifyWaiting()
			end

		elseif imgui.settingsTab == 4 then
			--imgui.Dummy(vec(165/6, 18))
			imgui.Dummy(vec(165/6, 0))
			imgui.SameLine(toScreenX(34))
			imgui.Text("Патроны")
			imgui.SameLine(toScreenX(64))
			imgui.Text("Цена за пт", vec(165/6, 150/8))
			imgui.SameLine(toScreenX(34))
			imgui.Dummy(vec(165/3, 0))
			imgui.SameLine(toScreenX(94))
			imgui.Text("ID", vec(165/6, 150/8))
			imgui.SameLine(toScreenX(124))
			imgui.Dummy(vec(165/3, 0))
			imgui.SameLine(toScreenX(153))
			imgui.Text("Материалов: " .. ini.GhettoMateConfig.my_mats)

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("1. Deagle", vec(25,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp11', text_buffer_pt1)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp", imgui.price_Deagle, 0, 500) then
				ini.GhettoMateConfig.price_Deagle = imgui.price_Deagle.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp14', text_buffer_id1)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp13', vec(28,0)) then
				if text_buffer_pt1.v ~= nil and text_buffer_pt1.v ~= "" and isNumber(text_buffer_pt1.v) and tonumber(text_buffer_pt1.v) > 0 and isNumber(text_buffer_pt1.v) then
					if text_buffer_id1.v ~= nil and text_buffer_id1.v ~= "" and isNumber(text_buffer_id1.v) and tonumber(text_buffer_id1.v) >= 0 and tonumber(text_buffer_id1.v) < 1000 then
						sampSendChat("/sellgun deagle " .. tonumber(text_buffer_pt1.v) .. " " .. ini.GhettoMateConfig.price_Deagle * tonumber(text_buffer_pt1.v) .. " " .. tonumber(text_buffer_id1.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp14', vec(28,0)) then
				if text_buffer_pt1.v ~= nil and text_buffer_pt1.v ~= ""  and isNumber(text_buffer_pt1.v) and tonumber(text_buffer_pt1.v) > 0 and isNumber(text_buffer_pt1.v) then
					sampSendChat("/gun deagle " .. tonumber(text_buffer_pt1.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. math.floor(tonumber(ini.GhettoMateConfig.my_mats)/3))

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("2. M4", vec(25,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp21', text_buffer_pt2)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp24", imgui.price_M4, 0, 500) then
				ini.GhettoMateConfig.price_M4 = imgui.price_M4.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp22', text_buffer_id2)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp23', vec(28,0)) then
				if text_buffer_pt2.v ~= nil and text_buffer_pt2.v ~= ""  and isNumber(text_buffer_pt2.v) and tonumber(text_buffer_pt2.v) > 0 and isNumber(text_buffer_pt2.v) then
					if text_buffer_id2.v ~= nil and text_buffer_id2.v ~= "" and isNumber(text_buffer_id2.v) and tonumber(text_buffer_id2.v) >= 0 and tonumber(text_buffer_id2.v) < 1000 then
						sampSendChat("/sellgun m4 " .. tonumber(text_buffer_pt2.v) .. " " .. ini.GhettoMateConfig.price_M4 * tonumber(text_buffer_pt2.v) .. " " .. tonumber(text_buffer_id2.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp24', vec(28,0)) then
				if text_buffer_pt2.v ~= nil and text_buffer_pt2.v ~= "" and isNumber(text_buffer_pt2.v) and tonumber(text_buffer_pt2.v) > 0 and isNumber(text_buffer_pt2.v) then
					sampSendChat("/gun M4 " .. tonumber(text_buffer_pt2.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. math.floor(tonumber(ini.GhettoMateConfig.my_mats)/3))

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("3. Shotgun\t", vec(28,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp31', text_buffer_pt3)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp34", imgui.price_Shotgun, 0, 500) then
				ini.GhettoMateConfig.price_Shotgun = imgui.price_Shotgun.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp32', text_buffer_id3)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp33', vec(28,0)) then
				if text_buffer_pt3.v ~= nil and text_buffer_pt3.v ~= "" and isNumber(text_buffer_pt3.v) and tonumber(text_buffer_pt3.v) > 0 and isNumber(text_buffer_pt3.v) then
					if text_buffer_id3.v ~= nil and text_buffer_id3.v ~= "" and isNumber(text_buffer_id3.v) and tonumber(text_buffer_id3.v) >= 0 and tonumber(text_buffer_id3.v) < 1000 then
						sampSendChat("/sellgun Shotgun " .. tonumber(text_buffer_pt3.v) .. " " .. ini.GhettoMateConfig.price_Shotgun * tonumber(text_buffer_pt3.v) .. " " .. tonumber(text_buffer_id3.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp34', vec(28,0)) then
				if text_buffer_pt3.v ~= nil and text_buffer_pt3.v ~= "" and isNumber(text_buffer_pt3.v) and tonumber(text_buffer_pt3.v) > 0 and isNumber(text_buffer_pt3.v) then
					sampSendChat("/gun Shotgun " .. tonumber(text_buffer_pt3.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. math.floor(tonumber(ini.GhettoMateConfig.my_mats)/3))

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("4. Rifle\t", vec(28,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp41', text_buffer_pt4)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp44", imgui.price_Rifle, 0, 500) then
				ini.GhettoMateConfig.price_Rifle = imgui.price_Rifle.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp42', text_buffer_id4)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp43', vec(28,0)) then
				if text_buffer_pt4.v ~= nil and text_buffer_pt4.v ~= "" and isNumber(text_buffer_pt4.v) and tonumber(text_buffer_pt4.v) > 0 and isNumber(text_buffer_pt4.v) then
					if text_buffer_id4.v ~= nil and text_buffer_id4.v ~= "" and isNumber(text_buffer_id4.v) and tonumber(text_buffer_id4.v) >= 0 and tonumber(text_buffer_id4.v) < 1000 then
						sampSendChat("/sellgun Rifle " .. tonumber(text_buffer_pt4.v) .. " " .. ini.GhettoMateConfig.price_Rifle * tonumber(text_buffer_pt4.v) .. " " .. tonumber(text_buffer_id4.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp44', vec(28,0)) then
				if text_buffer_pt4.v ~= nil and text_buffer_pt4.v ~= "" and isNumber(text_buffer_pt4.v) and tonumber(text_buffer_pt4.v) > 0 and isNumber(text_buffer_pt4.v) then
					sampSendChat("/gun Rifle " .. tonumber(text_buffer_pt4.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. math.floor(tonumber(ini.GhettoMateConfig.my_mats)/5))

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("5. AK47\t", vec(28,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp51', text_buffer_pt5)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp54", imgui.price_AK47, 0, 500) then
				ini.GhettoMateConfig.price_AK47 = imgui.price_AK47.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp52', text_buffer_id5)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp53', vec(28,0)) then
				if text_buffer_pt5.v ~= nil and text_buffer_pt5.v ~= "" and isNumber(text_buffer_pt5.v) and tonumber(text_buffer_pt5.v) > 0 and isNumber(text_buffer_pt5.v) then
					if text_buffer_id5.v ~= nil and text_buffer_id5.v ~= "" and isNumber(text_buffer_id5.v) and tonumber(text_buffer_id5.v) >= 0 and tonumber(text_buffer_id5.v) < 1000 then
						sampSendChat("/sellgun AK47 " .. tonumber(text_buffer_pt5.v) .. " " .. ini.GhettoMateConfig.price_AK47 * tonumber(text_buffer_pt5.v) .. " " .. tonumber(text_buffer_id5.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp54', vec(28,0)) then
				if text_buffer_pt5.v ~= nil and text_buffer_pt5.v ~= "" and isNumber(text_buffer_pt5.v) and tonumber(text_buffer_pt5.v) > 0 and isNumber(text_buffer_pt5.v) then
					sampSendChat("/gun AK47 " .. tonumber(text_buffer_pt5.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. math.floor(tonumber(ini.GhettoMateConfig.my_mats)/3))

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("6. SDpistol\t", vec(28,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp61', text_buffer_pt6)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp64", imgui.price_SDpistol, 0, 500) then
				ini.GhettoMateConfig.price_SDpistol = imgui.price_SDpistol.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp62', text_buffer_id6)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp63', vec(28,0)) then
				if text_buffer_pt6.v ~= nil and text_buffer_pt6.v ~= "" and isNumber(text_buffer_pt6.v) and tonumber(text_buffer_pt6.v) > 0 and isNumber(text_buffer_pt6.v) then
					if text_buffer_id6.v ~= nil and text_buffer_id6.v ~= "" and isNumber(text_buffer_id6.v) and tonumber(text_buffer_id6.v) >= 0 and tonumber(text_buffer_id6.v) < 1000 then
						sampSendChat("/sellgun SDpistol " .. tonumber(text_buffer_pt6.v) .. " " .. ini.GhettoMateConfig.price_SDpistol * tonumber(text_buffer_pt6.v) .. " " .. tonumber(text_buffer_id6.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp64', vec(28,0)) then
				if text_buffer_id6.v ~= nil and text_buffer_id6.v ~= "" and isNumber(text_buffer_pt6.v) and tonumber(text_buffer_id6.v) >= 0 and tonumber(text_buffer_id6.v) < 1000 then
					sampSendChat("/gun SDpistol " .. tonumber(text_buffer_pt6.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. tonumber(ini.GhettoMateConfig.my_mats)/1)

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("7. SMG\t", vec(28,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp71', text_buffer_pt7)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp74", imgui.price_SMG, 0, 500) then
				ini.GhettoMateConfig.price_SMG = imgui.price_SMG.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp72', text_buffer_id7)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp73', vec(28,0)) then
				if text_buffer_pt7.v ~= nil and text_buffer_pt7.v ~= "" and isNumber(text_buffer_pt7.v) and tonumber(text_buffer_pt7.v) > 0 and isNumber(text_buffer_pt7.v) then
					if text_buffer_id7.v ~= nil and text_buffer_id7.v ~= "" and isNumber(text_buffer_id7.v) and tonumber(text_buffer_id7.v) >= 0 and tonumber(text_buffer_id7.v) < 1000 then
						sampSendChat("/sellgun SMG " .. tonumber(text_buffer_pt7.v) .. " " .. ini.GhettoMateConfig.price_SMG * tonumber(text_buffer_pt7.v) .. " " .. tonumber(text_buffer_id7.v))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Себе" .. '##inp74', vec(28,0)) then
				if text_buffer_pt7.v ~= nil and text_buffer_pt7.v ~= "" and isNumber(text_buffer_pt7.v) and tonumber(text_buffer_pt7.v) > 0 and isNumber(text_buffer_pt7.v) then
					sampSendChat("/gun SMG " .. tonumber(text_buffer_pt7.v))
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. math.floor(tonumber(ini.GhettoMateConfig.my_mats)/2))

			imgui.Dummy(vec(3, 0))
			imgui.SameLine()
			imgui.Text("8. Нарко\t", vec(28,0))
			imgui.SameLine(toScreenX(34))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp81', text_buffer_pt8)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(64))
			imgui.PushItemWidth(toScreenX(165/6))
			if imgui.SliderInt("##inp84", imgui.price_Drugs, 0, 150) then
				ini.GhettoMateConfig.price_Drugs = imgui.price_Drugs.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(94))
			imgui.PushItemWidth(toScreenX(165/6))
			imgui.InputText('##inp82', text_buffer_id8)
			imgui.PopItemWidth()
			imgui.SameLine(toScreenX(124))
			if imgui.Button("Продать" .. '##inp83', vec(28,0)) then
				if text_buffer_pt8.v ~= nil and text_buffer_pt8.v ~= "" and isNumber(text_buffer_pt8.v) and tonumber(text_buffer_pt8.v) > 0 and isNumber(text_buffer_pt8.v) then
					if text_buffer_id8.v ~= nil and text_buffer_id8.v ~= "" and isNumber(text_buffer_id8.v) and tonumber(text_buffer_id8.v) >= 0 and tonumber(text_buffer_id8.v) < 1000 then
						sampSendChat("/selldrugs " .. tonumber(text_buffer_id8.v) .. " " .. tonumber(text_buffer_pt8.v) .. " " .. (ini.GhettoMateConfig.price_Drugs * tonumber(text_buffer_pt8.v)))
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
					end
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Количество наркотиков должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(154))
			if imgui.Button("Заюзать" .. '##inp84', vec(28,0)) then
				if text_buffer_pt8.v ~= nil and text_buffer_pt8.v ~= "" and isNumber(text_buffer_pt8.v) and tonumber(text_buffer_pt8.v) > 0 and isNumber(text_buffer_pt8.v) then
					sampSendChat("/usedrugs " .. text_buffer_pt8.v)
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Количество наркотиков должно быть больше нуля", main_color)
				end
			end
			imgui.SameLine(toScreenX(184))
			imgui.Text("" .. tonumber(ini.GhettoMateConfig.my_drugs)/1)
			imgui.Separator()


			imgui.SetCursorPos(vec(10, 128))
			if imgui.Button("Сделать", vec(28,0)) then
				GunWait:run(ini.GunList.gun1, ini.GunList.gun2, ini.GunList.gun3, ini.GunList.pt1, ini.GunList.pt2, ini.GunList.pt3)
			end
			imgui.SetCursorPos(vec(40, 115))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.Combo("##Combo1", combo_select1, "Deagle\0M4\0Shotgun\0Rifle\0SDpistol\0AK47\0SMG\0-\0\0") then
				ini.GunList.gun1 = combo_select1.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##InputInt1", imgui.pt1, 1, 1) then
				if imgui.pt1.v ~= nil and imgui.pt1.v ~= "" and isNumber(imgui.pt1.v) and imgui.pt1.v >= 0 then
					ini[GunList].pt1 = imgui.pt1.v
					inicfg.save(ini, directIni)
				end
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			if combo_select1.v == 0 then
				mats1 = imgui.pt1.v * 3
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 1 then
				mats1 = imgui.pt1.v * 3
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 2 then
				mats1 = imgui.pt1.v * 3
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 5 then
				mats1 = imgui.pt1.v * 3
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 3 then
				mats1 = imgui.pt1.v * 5
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 4 then
				mats1 = imgui.pt1.v * 1
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 6 then
				mats1 = imgui.pt1.v * 2
				imgui.Text("" .. mats1)
			end
			if combo_select1.v == 7 then
				mats1 = imgui.pt1.v * 0
				imgui.Text("" .. mats1)
			end

			imgui.SetCursorPos(vec(40, 128))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.Combo("##Combo2", combo_select2, "Deagle\0M4\0Shotgun\0Rifle\0SDpistol\0AK47\0SMG\0-\0\0") then
				ini.GunList.gun2 = combo_select2.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##InputInt2", imgui.pt2, 1, 1) then
				if imgui.pt2.v ~= nil and imgui.pt2.v ~= "" and isNumber(imgui.pt2.v) and imgui.pt2.v >= 0 then
					ini[GunList].pt2 = imgui.pt2.v
					inicfg.save(ini, directIni)
				end
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			if combo_select2.v == 0 then
				mats2 = imgui.pt2.v * 3
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 1 then
				mats2 = imgui.pt2.v * 3
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 2 then
				mats2 = imgui.pt2.v * 3
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 5 then
				mats2 = imgui.pt2.v * 3
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 3 then
				mats2 = imgui.pt2.v * 5
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 4 then
				mats2 = imgui.pt2.v * 1
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 6 then
				mats2 = imgui.pt2.v * 2
				imgui.Text("" .. mats2)
			end
			if combo_select2.v == 7 then
				mats2 = imgui.pt2.v * 0
				imgui.Text("" .. mats1)
			end

			imgui.SetCursorPos(vec(40, 141))
			imgui.PushItemWidth(toScreenX(43))
			if imgui.Combo("##Combo3", combo_select3, "Deagle\0M4\0Shotgun\0Rifle\0SDpistol\0AK47\0SMG\0-\0\0") then
				ini.GunList.gun3 = combo_select3.v
				inicfg.save(ini, directIni)
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			imgui.PushItemWidth(toScreenX(165/5))
			if imgui.InputInt("##InputInt3", imgui.pt3, 1, 1) then
				if imgui.pt3.v ~= nil and imgui.pt3.v ~= "" and isNumber(imgui.pt3.v) and imgui.pt3.v >= 0 then
					ini[GunList].pt3 = imgui.pt3.v
					inicfg.save(ini, directIni)
				end
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			if combo_select3.v == 0 then
				mats3 = imgui.pt3.v * 3
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 1 then
				mats3 = imgui.pt3.v * 3
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 2 then
				mats3 = imgui.pt3.v * 3
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 5 then
				mats3 = imgui.pt3.v * 3
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 3 then
				mats3 = imgui.pt3.v * 5
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 4 then
				mats3 = imgui.pt3.v * 1
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 6 then
				mats3 = imgui.pt3.v * 2
				imgui.Text("" .. mats3)
			end
			if combo_select3.v == 7 then
				mats3 = imgui.pt3.v * 0
				imgui.Text("" .. mats3)
			end

			imgui.SetCursorPos(vec(133, 129.5))
			imgui.Text("" .. mats1 + mats2 + mats3)

		elseif imgui.settingsTab == 5 then
			imgui.Text("Статистика: ")
			if ini2[GhettoMateCapture].kill == 0 and ini2[GhettoMateCapture].death == 0 then
				imgui.Text("Убийств / Смертей: " .. ini2[GhettoMateCapture].kill .. " / " .. ini2[GhettoMateCapture].death .. " [0%]")
			elseif ini2[GhettoMateCapture].kill ~= 0 and ini2[GhettoMateCapture].death == 0 then
				imgui.Text("Убийств / Смертей: " .. ini2[GhettoMateCapture].kill .. " / " .. ini2[GhettoMateCapture].death .. " [100%]")
			else
				imgui.Text("Убийств / Смертей: " .. ini2[GhettoMateCapture].kill .. " / " .. ini2[GhettoMateCapture].death .. " [" .. math.floor(ini2[GhettoMateCapture].kill / ini2[GhettoMateCapture].death*100)/100 .. "%]")
			end
			imgui.SameLine(toScreenX(100))
				if ini2[GhettoMateCapture].CaptureKill == nil then ini2[GhettoMateCapture].CaptureKill = 0 inicfg.save(ini2, directIni2) end -- potom dell
				if ini2[GhettoMateCapture].CaptureDeath == nil then ini2[GhettoMateCapture].CaptureDeath = 0 inicfg.save(ini2, directIni2) end -- potom dell
			if ini2[GhettoMateCapture].CaptureDeath == 0 and ini2[GhettoMateCapture].CaptureKill == 0 then 
				imgui.Text("Убийств / Смертей за капт: " .. ini2[GhettoMateCapture].CaptureKill .. " / " .. ini2[GhettoMateCapture].CaptureDeath .. " [0%]")
			elseif ini2[GhettoMateCapture].CaptureDeath == 0 and ini2[GhettoMateCapture].CaptureKill ~= 0 then 
				imgui.Text("Убийств / Смертей за капт: " .. ini2[GhettoMateCapture].CaptureKill .. " / " .. ini2[GhettoMateCapture].CaptureDeath .. " [100%]")
			else
				imgui.Text("Убийств / Смертей за капт: " .. ini2[GhettoMateCapture].CaptureKill .. " / " .. ini2[GhettoMateCapture].CaptureDeath .. " [" .. math.floor(ini2[GhettoMateCapture].CaptureKill / ini2[GhettoMateCapture].CaptureDeath*100)/100 .. "%]")
			end
			
			imgui.Text("  ")
			imgui.Text("Grove убито: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].grove_kill)

			imgui.Text("Aztecas убито: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].aztecas_kill)

			imgui.Text("Ballas убито: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].ballas_kill)

			imgui.Text("Vagos убито: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].vagos_kill)

			imgui.Text("Rifa убито: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].rifa_kill)

			imgui.Text("  ")

			imgui.Text("Убийств с Deagle: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_deagle)

			imgui.Text("Убийств с M4: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_m4)

			imgui.Text("Убийств с Shotgun: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_shotgun)

			imgui.Text("Убийств с Rifle: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_rifle)

			imgui.Text("Убийств с SDpistol: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_sdpistol)

			imgui.Text("Убийств с кулака: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_fist)

			imgui.Text("Убийств с бейсбольной биты: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_bat)

			imgui.Text("Убийств с остального оружия: ")
			imgui.SameLine(toScreenX(80))
			imgui.Text("" .. ini2[GhettoMateCapture].gun_ost)

		else
			if script.update then
				if imgui.Button("Обновить скрипт", vec(112,0)) then
					imgui.Process = false
					update()
				end
			else
				imgui.Text("Актуальная версия скрипта")
			end

			imgui.SetCursorPos(vec(5, 30))
			imgui.Text("Список команд:")
				imgui.BeginChild('List', vec(198, 115), true)
					imgui.Text("/gm - включить главное меню скрипта")
					imgui.Text("/lhud - включить Larek HUD")
					imgui.Text("/mohud - включить MO HUD")
					imgui.Text("//gun - сделать набор оружия из Seller")
					imgui.Text("/autogetguns - включить/выключить AutoGetGuns")
					imgui.Text("/fc [CarName] - поиск машины, без аргумента завершает поиск")
					imgui.Text("/gfind [id] - поиск игрока")
					imgui.Text("/drugs - заюзать нарко до фулл хп")
					imgui.Text("/l [1, 2.. 16] - сообщить в какой ларёк необходимо ехать")
					imgui.Text("/mo [LS, SF, LV] - сообщить в какой MO необходимо ехать")
					imgui.Text("/sg [GunName] [PT] [ID] - продать оружие [Цена: PT * Цена за ед.]")
					imgui.Text("/sd [N] [ID] - продать наркотики [Цена: N * Цена за ед.]")
				imgui.EndChild()
		end
		imgui.EndChild()
		imgui.End()
	else
		imgui.ShowCursor = false
	end

	if larek_window_state.v then
		if InterfacePosition == true then
			imgui.SetNextWindowPos(imgui.ImVec2(ini[GhettoMateConfig].X, ini[GhettoMateConfig].Y))
			inicfg.save(ini, directIni)
		end
		imgui.SetNextWindowSize(vec(80, 180))
		imgui.Begin("Larek HUD", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
		local pos = imgui.GetWindowPos()
		ini[GhettoMateConfig].X = pos.x
		ini[GhettoMateConfig].Y = pos.y
		inicfg.save(ini, directIni)

		imgui.TextColoredRGB(u8"1.  " .. ini[GhettoMateName].Name1)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[1] .. ini3[GhettoMateTime].time1)
		imgui.TextColoredRGB(u8"2.  " .. ini[GhettoMateName].Name2)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8""  .. color[2] .. ini3[GhettoMateTime].time2)
		imgui.TextColoredRGB(u8"3.  " .. ini[GhettoMateName].Name3)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[3] .. ini3[GhettoMateTime].time3)
		imgui.TextColoredRGB(u8"4.  " .. ini[GhettoMateName].Name4)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[4] .. ini3[GhettoMateTime].time4)
		imgui.TextColoredRGB(u8"5.  " .. ini[GhettoMateName].Name5)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[5] .. ini3[GhettoMateTime].time5)
		imgui.TextColoredRGB(u8"6.  " .. ini[GhettoMateName].Name6)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[6] .. ini3[GhettoMateTime].time6)
		imgui.TextColoredRGB(u8"7.  " .. ini[GhettoMateName].Name7)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[7] .. ini3[GhettoMateTime].time7)
		imgui.TextColoredRGB(u8"8.  " .. ini[GhettoMateName].Name8)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[8] .. ini3[GhettoMateTime].time8)
		imgui.TextColoredRGB(u8"9.  " .. ini[GhettoMateName].Name9)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[9] .. ini3[GhettoMateTime].time9)
		imgui.TextColoredRGB(u8"10. " .. ini[GhettoMateName].Name10)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[10] .. ini3[GhettoMateTime].time10)
		imgui.TextColoredRGB(u8"11. " .. ini[GhettoMateName].Name11)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[11] .. ini3[GhettoMateTime].time11)
		imgui.TextColoredRGB(u8"12. " .. ini[GhettoMateName].Name12)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[12] .. ini3[GhettoMateTime].time12)
		imgui.TextColoredRGB(u8"13. " .. ini[GhettoMateName].Name13)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[13] .. ini3[GhettoMateTime].time13)
		imgui.TextColoredRGB(u8"14. " .. ini[GhettoMateName].Name14)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[14] .. ini3[GhettoMateTime].time14)
		imgui.TextColoredRGB(u8"15. " .. ini[GhettoMateName].Name15)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[15] .. ini3[GhettoMateTime].time15)
		imgui.TextColoredRGB(u8"16. " .. ini[GhettoMateName].Name16)
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. color[16] .. ini3[GhettoMateTime].time16)
		imgui.Separator()
		imgui.TextColoredRGB(u8:decode"Денег награблено: " .. ini2[GhettoMateMoney].money)
		imgui.TextColoredRGB(u8:decode"Магазинов ограблено: " .. ini2[GhettoMateMoney].count)
		imgui.End()
	end

	if mo_window_state.v then
		if InterfacePositionMO == true then
			imgui.SetNextWindowPos(imgui.ImVec2(ini[GhettoMateConfig].X_MO, ini[GhettoMateConfig].Y_MO))
			inicfg.save(ini, directIni)
		end
		imgui.SetNextWindowSize(vec(80, 63))
		imgui.Begin("MO HUD", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
		local pos_MO = imgui.GetWindowPos()
		ini[GhettoMateConfig].X_MO = pos_MO.x
		ini[GhettoMateConfig].Y_MO = pos_MO.y
		inicfg.save(ini, directIni)

		imgui.TextColoredRGB(u8"1.  MO LS")
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. colorMO[1] .. ini3[TimeMO].time1)
		imgui.TextColoredRGB(u8"2.  MO SF")
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8""  .. colorMO[2] .. ini3[TimeMO].time2)
		imgui.TextColoredRGB(u8"3.  MO LV")
			imgui.SameLine(toScreenX(50))
		imgui.TextColoredRGB(u8"" .. colorMO[3] .. ini3[TimeMO].time3)
		imgui.Separator()
		imgui.TextColoredRGB(u8:decode"Материалов привезено: " .. ini2[GhettoMateMO].mats)
		imgui.TextColoredRGB(u8:decode"Фур украдено: " .. ini2[GhettoMateMO].cars)
		imgui.End()
	end
end

function Waiting()
	if timer == true then
		wait(10000)
		timer = false
	end
end

function MOWaiting()
	if MOtimer == true then
		wait(10000)
		MOtimer = false
	end
end

function Waiting2()
	if sideTimer == true then
		wait(1000)
		sideTimer = false
	end
end

function MOWaiting2()
	if MOsideTimer == true then
		wait(1000)
		MOsideTimer = false
	end
end

function DrugsWaiting()
	wait(60000)
	sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Юзай, {00FF00}" .. my_name .. "{FFFFFF}!", main_color)
	if ini4[GhettoMateSettings].Sounds then
		soundManager.playSound("message_news")
	end
	Use = true
end

function UseDrugsWaiting(DrugsCount)
	wait(600)
	sampSendChat("/usedrugs " .. DrugsCount)
end

function GunWaiting(gun1, gun2, gun3, pt1, pt2, pt3)
	if gun1 == 0 then gun1 = "deagle" end
	if gun1 == 1 then gun1 = "m4" end
	if gun1 == 2 then gun1 = "shotgun" end
	if gun1 == 3 then gun1 = "rifle" end
	if gun1 == 4 then gun1 = "sdpistol" end
	if gun1 == 5 then gun1 = "ak47" end
	if gun1 == 6 then gun1 = "smg" end
	if gun1 == 7 then gun1 = "-" end

	if gun2 == 0 then gun2 = "deagle" end
	if gun2 == 1 then gun2 = "m4" end
	if gun2 == 2 then gun2 = "shotgun" end
	if gun2 == 3 then gun2 = "rifle" end
	if gun2 == 4 then gun2 = "sdpistol" end
	if gun2 == 5 then gun2 = "ak47" end
	if gun2 == 6 then gun2 = "smg" end
	if gun2 == 7 then gun2 = "-" end

	if gun3 == 0 then gun3 = "deagle" end
	if gun3 == 1 then gun3 = "m4" end
	if gun3 == 2 then gun3 = "shotgun" end
	if gun3 == 3 then gun3 = "rifle" end
	if gun3 == 4 then gun3 = "sdpistol" end
	if gun3 == 5 then gun3 = "ak47" end
	if gun3 == 6 then gun3 = "smg" end
	if gun3 == 7 then gun3 = "-" end

	if gun1 ~= "-" then
		wait(600)
		sampSendChat("/gun " .. gun1 .. " " .. pt1)
	end
	if gun2 ~= "-" then
		wait(600)
		sampSendChat("/gun " .. gun2 .. " " .. pt2)
	end
	if gun2 ~= "-" then
		wait(600)
		sampSendChat("/gun " .. gun3 .. " " .. pt3)
	end
end

function MONotifyWaiting()
	if ini3[TimeMO].time1 ~= u8:decode"Неизвестно" then
		wait(1200)
		if ini3[SecondsMO].time1 - totalSeconds > 0 then
			sampSendChat(u8:decode"/f MO LS даёт в " .. ini3[TimeMO].time1 .. u8:decode" [Нельзя]")
		else
			sampSendChat(u8:decode"/f MO LS даёт в " .. ini3[TimeMO].time1 .. u8:decode" [Можно]")
		end
	end
	if ini3[TimeMO].time2 ~= u8:decode"Неизвестно" then
		wait(1200)
		if ini3[SecondsMO].time2 - totalSeconds > 0 then
			sampSendChat(u8:decode"/f MO SF даёт в " .. ini3[TimeMO].time2 .. u8:decode" [Нельзя]")
		else
			sampSendChat(u8:decode"/f MO SF даёт в " .. ini3[TimeMO].time2 .. u8:decode" [Можно]")
		end
	end
	if ini3[TimeMO].time3 ~= u8:decode"Неизвестно" then
		wait(1200)
		if ini3[SecondsMO].time3 - totalSeconds > 0 then
			sampSendChat(u8:decode"/f MO LV даёт в " .. ini3[TimeMO].time3 .. u8:decode" [Нельзя]")
		else
			sampSendChat(u8:decode"/f MO LV даёт в " .. ini3[TimeMO].time3 .. u8:decode" [Можно]")
		end
	end
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

function TimerMO()
	if MOtimer == false then
		if totalSeconds == ini3[SecondsMO].time1 then
			MOTime[1] = true
			MOTimeFunction()
			MOtimer = true
			MOWait:run()
		end
		if totalSeconds == ini3[SecondsMO].time2 then
			MOTime[2] = true
			MOTimeFunction()
			MOtimer = true
			MOWait:run()
		end
		if totalSeconds == ini3[SecondsMO].time3 then
			MOTime[3] = true
			MOTimeFunction()
			MOtimer = true
			MOWait:run()
		end
	end
	if ini4[GhettoMateSettings].NotifyLarek then
		if MOsideTimer == false then
			if totalSeconds == ini3[SecondsMO].time1 - ini4[GhettoMateSettings].TimerNotifyMO then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}MO LS{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyMO .. u8:decode"{FFFFFF} секунд!", main_color)
				MOsideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[SecondsMO].time2 - ini4[GhettoMateSettings].TimerNotifyMO then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}MO SF{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyMO .. u8:decode"{FFFFFF} секунд!", main_color)
				MOsideTimer = true
				Wait2:run()
			end
			if totalSeconds == ini3[SecondsMO].time3 - ini4[GhettoMateSettings].TimerNotifyMO then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}MO LV{FFFFFF} будет доступен через {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyMO .. u8:decode"{FFFFFF} секунд!", main_color)
				MOsideTimer = true
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

function TimerMMO()
	if totalSeconds <= ini3[SecondsMO].time1 then
		timerMO[1] = 1
	else
		timerMO[1] = 2
	end
	if totalSeconds <= ini3[SecondsMO].time2 then
		timerMO[2] = 1
	else
		timerMO[2] = 2
	end
	if totalSeconds <= ini3[SecondsMO].time3 then
		timerMO[3] = 1
	else
		timerMO[3] = 2
	end
end

function Refresh()
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time1) > oneHour then
		ini3[GhettoMateSeconds].time1 = 0
		ini3[GhettoMateTime].time1 = u8:decode"Неизвестно"
		color[1] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time2) > oneHour then
		ini3[GhettoMateSeconds].time2 = 0
		ini3[GhettoMateTime].time2 = u8:decode"Неизвестно"
		color[2] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time3) > oneHour then
		ini3[GhettoMateSeconds].time3 = 0
		ini3[GhettoMateTime].time3 = u8:decode"Неизвестно"
		color[3] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time4) > oneHour then
		ini3[GhettoMateSeconds].time4 = 0
		ini3[GhettoMateTime].time4 = u8:decode"Неизвестно"
		color[4] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time5) > oneHour then
		ini3[GhettoMateSeconds].time5 = 0
		ini3[GhettoMateTime].time5 = u8:decode"Неизвестно"
		color[5] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time6) > oneHour then
		ini3[GhettoMateSeconds].time6 = 0
		ini3[GhettoMateTime].time6 = u8:decode"Неизвестно"
		color[6] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time7) > oneHour then
		ini3[GhettoMateSeconds].time7 = 0
		ini3[GhettoMateTime].time7 = u8:decode"Неизвестно"
		color[7] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time8) > oneHour then
		ini3[GhettoMateSeconds].time8 = 0
		ini3[GhettoMateTime].time8 = u8:decode"Неизвестно"
		color[8] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time9) > oneHour then
		ini3[GhettoMateSeconds].time9 = 0
		ini3[GhettoMateTime].time9 = u8:decode"Неизвестно"
		color[9] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time10) > oneHour then
		ini3[GhettoMateSeconds].time10 = 0
		ini3[GhettoMateTime].time10 = u8:decode"Неизвестно"
		color[10] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time11) > oneHour then
		ini3[GhettoMateSeconds].time11 = 0
		ini3[GhettoMateTime].time11 = u8:decode"Неизвестно"
		color[11] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time12) > oneHour then
		ini3[GhettoMateSeconds].time12 = 0
		ini3[GhettoMateTime].time12 = u8:decode"Неизвестно"
		color[12] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time13) > oneHour then
		ini3[GhettoMateSeconds].time13 = 0
		ini3[GhettoMateTime].time13 = u8:decode"Неизвестно"
		color[13] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time14) > oneHour then
		ini3[GhettoMateSeconds].time14 = 0
		ini3[GhettoMateTime].time14 = u8:decode"Неизвестно"
		color[14] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time15) > oneHour then
		ini3[GhettoMateSeconds].time15 = 0
		ini3[GhettoMateTime].time15 = u8:decode"Неизвестно"
		color[15] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[GhettoMateSeconds].time16) > oneHour then
		ini3[GhettoMateSeconds].time16 = 0
		ini3[GhettoMateTime].time16 = u8:decode"Неизвестно"
		color[16] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
end

function RefreshMO()
	if math.abs(totalSeconds - ini3[SecondsMO].time1) > oneHour then
		ini3[SecondsMO].time1 = 0
		ini3[TimeMO].time1 = u8:decode"Неизвестно"
		color[1] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[SecondsMO].time2) > oneHour then
		ini3[SecondsMO].time2 = 0
		ini3[TimeMO].time2 = u8:decode"Неизвестно"
		color[2] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
	if math.abs(totalSeconds - ini3[SecondsMO].time3) > oneHour then
		ini3[SecondsMO].time3 = 0
		ini3[TimeMO].time3 = u8:decode"Неизвестно"
		color[3] = "{808080}"
		inicfg.save(ini3, directIni3)
	end
end

function MagazTimeFunction()
	if MagazTime[1] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name1 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[1] = false
	end
	if MagazTime[2] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name2 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[2] = false
	end
	if MagazTime[3] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name3 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[3] = false
	end
	if MagazTime[4] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name4 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[4] = false
	end
	if MagazTime[5] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name5 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[5] = false
	end
	if MagazTime[6] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name6 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[6] = false
	end
	if MagazTime[7] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name7 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[7] = false
	end
	if MagazTime[8] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name8 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[8] = false
	end
	if MagazTime[9] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name9 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[9] = false
	end
	if MagazTime[10] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name10 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[10] = false
	end
	if MagazTime[11] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name11 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[11] = false
	end
	if MagazTime[12] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name12 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[12] = false
	end
	if MagazTime[13] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name13 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[13] = false
	end
	if MagazTime[14] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name14 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[14] = false
	end
	if MagazTime[15] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name15 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[15] = false
	end
	if MagazTime[16] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Ларёк{FFFF00} " .. ini[GhettoMateName].Name16 .. u8:decode" {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MagazTime[16] = false
	end
end

function MOTimeFunction()
	if MOTime[1] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}MO LS  {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MOTime[1] = false
	end
	if MOTime[2] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}MO SF  {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MOTime[2] = false
	end
	if MOTime[3] == true then
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}MO LV  {FFFFFF}снова доступен для ограбления!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_news")
		end
		MOTime[3] = false
	end
end

function sampev.onSendPickedUpPickup(pickupId)
	if pickupId == 1139 then  -- вошел
		Magaz1 = true
	else
		Magaz1 = false
	end
	if pickupId == 1137 then
		Magaz2 = true
	else
		Magaz2 = false
	end
	if pickupId == 1079 then
		Magaz3 = true
	else
		Magaz3 = false
	end
	if pickupId == 1077 then
		Magaz4 = true
	else
		Magaz4 = false
	end
	if pickupId == 1083 then
		Magaz5 = true
	else
		Magaz5 = false
	end
	if pickupId == 1135 then
		Magaz6 = true
	else
		Magaz6 = false
	end
	if pickupId == 1087 then
		Magaz7 = true
	else
		Magaz7 = false
	end
	if pickupId == 1081 then
		Magaz8 = true
	else
		Magaz8 = false
	end
	if pickupId == 1085 then
		Magaz9 = true
	else
		Magaz9 = false
	end
	if pickupId == 1133 then
		Magaz10 = true
	else
		Magaz10 = false
	end
	if pickupId == 1131 then
		Magaz11 = true
	else
		Magaz11 = false
	end
	if pickupId == 1119 then
		Magaz12 = true
	else
		Magaz12 = false
	end
	if pickupId == 1125 then
		Magaz13 = true
	else
		Magaz13 = false
	end
	if pickupId == 1121 then
		Magaz14 = true
	else
		Magaz14 = false
	end
	if pickupId == 1123 then
		Magaz15 = true
	else
		Magaz15 = false
	end
	if pickupId == 1129 then
		Magaz16 = true
	else
		Magaz16 = false
	end

	if pickupId == 1832 then
		MOLS = true
	else
		MOLS = false
	end
	if pickupId == 1834 then
		MOSF = true
	else
		MOSF = false
	end
	if pickupId == 1836 then
		MOLV = true
	else
		MOLV = false
	end
end

function sampev.onServerMessage(color, text)
	if Magaz1 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[1] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time1 = timerMagaz[1]
				inicfg.save(ini3, directIni3)
			hourM[1], minuteM[1], secondsM[1] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time1 = hourM[1] * 3600 + minuteM[1] * 60 + secondsM[1]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz2 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[2] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time2 = timerMagaz[2]
				inicfg.save(ini3, directIni3)
			hourM[2], minuteM[2], secondsM[2] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time2 = hourM[2] * 3600 + minuteM[2] * 60 + secondsM[2]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz3 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[3] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time3 = timerMagaz[3]
				inicfg.save(ini3, directIni3)
			hourM[3], minuteM[3], secondsM[3] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time3 = hourM[3] * 3600 + minuteM[3] * 60 + secondsM[3]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz4 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[4] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time4 = timerMagaz[4]
				inicfg.save(ini3, directIni3)
			hourM[4], minuteM[4], secondsM[4] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time4 = hourM[4] * 3600 + minuteM[4] * 60 + secondsM[4]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz5 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[5] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time5 = timerMagaz[5]
				inicfg.save(ini3, directIni3)
			hourM[5], minuteM[5], secondsM[5] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time5 = hourM[5] * 3600 + minuteM[5] * 60 + secondsM[5]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz6 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[6] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time6 = timerMagaz[6]
				inicfg.save(ini3, directIni3)
			hourM[6], minuteM[6], secondsM[6] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time6 = hourM[6] * 3600 + minuteM[6] * 60 + secondsM[6]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz7 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[7] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time7 = timerMagaz[7]
				inicfg.save(ini3, directIni3)
			hourM[7], minuteM[7], secondsM[7] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time7 = hourM[7] * 3600 + minuteM[7] * 60 + secondsM[7]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz8 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[8] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time8 = timerMagaz[8]
				inicfg.save(ini3, directIni3)
			hourM[8], minuteM[8], secondsM[8] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time8 = hourM[8] * 3600 + minuteM[8] * 60 + secondsM[8]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz9 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[9] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time9 = timerMagaz[9]
				inicfg.save(ini3, directIni3)
			hourM[9], minuteM[9], secondsM[9] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time9 = hourM[9] * 3600 + minuteM[9] * 60 + secondsM[9]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz10 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[10] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time10 = timerMagaz[10]
				inicfg.save(ini3, directIni3)
			hourM[10], minuteM[10], secondsM[10] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time10 = hourM[10] * 3600 + minuteM[10] * 60 + secondsM[10]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz11 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[11] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time11 = timerMagaz[11]
				inicfg.save(ini3, directIni3)
			hourM[11], minuteM[11], secondsM[11] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time11 = hourM[11] * 3600 + minuteM[11] * 60 + secondsM[11]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz12 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[12] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time12 = timerMagaz[12]
				inicfg.save(ini3, directIni3)
			hourM[12], minuteM[12], secondsM[12] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time12 = hourM[12] * 3600 + minuteM[12] * 60 + secondsM[12]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz13 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[13] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time13 = timerMagaz[13]
				inicfg.save(ini3, directIni3)
			hourM[13], minuteM[13], secondsM[13] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time13 = hourM[13] * 3600 + minuteM[13] * 60 + secondsM[13]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz14 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[14] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
			ini3[GhettoMateTime].time14 = timerMagaz[14]
			hourM[14], minuteM[14], secondsM[14] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time14 = hourM[14] * 3600 + minuteM[14] * 60 + secondsM[14]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz15 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[15] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time15 = timerMagaz[15]
				inicfg.save(ini3, directIni3)
			hourM[15], minuteM[15], secondsM[15] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time15 = hourM[15] * 3600 + minuteM[15] * 60 + secondsM[15]
			inicfg.save(ini3, directIni3)
		end
	end
	if Magaz16 == true then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[16] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[GhettoMateTime].time16 = timerMagaz[16]
				inicfg.save(ini3, directIni3)
			hourM[16], minuteM[16], secondsM[16] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[GhettoMateSeconds].time16 = hourM[16] * 3600 + minuteM[16] * 60 + secondsM[16]
			inicfg.save(ini3, directIni3)
		end
	end
	if MOLS then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[1] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[TimeMO].time1 = timerMagaz[1]
				inicfg.save(ini3, directIni3)
			hourMO[1], minuteMO[1], secondsMO[1] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[SecondsMO].time1 = hourMO[1] * 3600 + minuteMO[1] * 60 + secondsMO[1]
			inicfg.save(ini3, directIni3)
		end
	end
	if MOSF then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[2] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[TimeMO].time2 = timerMagaz[2]
				inicfg.save(ini3, directIni3)
			hourMO[2], minuteMO[2], secondsMO[2] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[SecondsMO].time2 = hourMO[2] * 3600 + minuteMO[2] * 60 + secondsMO[2]
			inicfg.save(ini3, directIni3)
		end
	end
	if MOLV then
		if string.find(text, u8:decode" Следующее ограбление будет доступно в .+") then
			timerMagaz[3] = string.match(text, u8:decode" Следующее ограбление будет доступно в (.+)")
				ini3[TimeMO].time3 = timerMagaz[3]
				inicfg.save(ini3, directIni3)
			hourMO[3], minuteMO[3], secondsMO[3] =  string.match(text, u8:decode" Следующее ограбление будет доступно в (%d+)[^%d]+(%d+)[^%d]+(%d+)")
			ini3[SecondsMO].time3 = hourMO[3] * 3600 + minuteMO[3] * 60 + secondsMO[3]
			inicfg.save(ini3, directIni3)
		end
	end
	if string.find(text, string.format(u8:decode" %s разгрузил(а) на склад", my_name), 1, true) then
		matss = string.match(text, u8:decode"(%d+)")
		ini2[GhettoMateMO].mats = ini2[GhettoMateMO].mats + matss
		ini2[GhettoMateMO].cars = ini2[GhettoMateMO].cars + 1
		inicfg.save(ini2, directIni2)
	end

	-- AUTOGETGUNS--

	if GetGuns and not paused then
		if string.find(text, u8:decode"открыл(а) склад с оружием", 1, true) then
			NickSklad = string.match(text, u8:decode"(%S+)")
			sampAddChatMessage(" " .. NickSklad .. u8:decode" открыл(а) склад с оружием", 0x00FF00)
			sampSendChat("/get guns")
		end
		if string.find(text, u8:decode"У вас 500/500 материалов с собой", 1, true) or string.find(text, u8:decode"У вас 600/600 материалов с собой", 1, true) or string.find(text, u8:decode"У вас 700/700 материалов с собой", 1, true) then
			if ini4[GhettoMateSettings].NotifyAutoGetGuns then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}AutoGetGuns: {00FF00}Успешно!", main_color)
			end
		end
		if string.find(text, u8:decode"Необходимо находиться на своей базе", 1, true) then
			if ini4[GhettoMateSettings].NotifyAutoGetGuns then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}AutoGetGuns: {FF0000}Неудача!", main_color)
			end
		end
	end

	--UGONYALA--

	if string.find(text, u8:decode"SMS: Слишком долго. Нам нужны хорошие автоугонщики, а не черепахи") then
		stopSearch()
	end

	if string.find(text, u8:decode"SMS: Ты меня огорчил!") then
		stopSearch()
	end

	if string.find(text, u8:decode" Отличная тачка. Будет нужна работа, приходи.") then
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF} Следующий угон доступен через {FFFF00}15 {FFFFFF}минут. Таймер активирован.", main_color)
		end
		stopSearch()
		ugontimer = os.clock() + 900
		imgui.Process = false
	end

	if string.find(text, u8:decode"Заказ можно брать раз в 15 минут. Осталось .+:.+") then
		minutes, seconds = string.match(text, u8:decode"Заказ можно брать раз в 15 минут. Осталось (.+):(.+)")
		ugontimer = tonumber(minutes) * 60 + tonumber(seconds) + os.clock()
	end

	if string.find(text, u8:decode"Пригони нам тачку марки .+, и мы тебе хорошо заплатим.") then
		carname = string.match(text, u8:decode"Пригони нам тачку марки (.+), и мы тебе хорошо заплатим.")
		sampSendChat("/fc " .. carname)
		imgui.Process = true
	end

	if string.find(text, u8:decode"SMS: Это то что нам нужно, гони её на склад.") then
		stopSearch()
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Метка установлена {FFFF00}" .. thiefPos, main_color)
		end
	end
	
	ini4 = inicfg.load(GhettoMateSettings, directIni4)
	if ini4[GhettoMateSettings].AnimUgonyala then
		if string.find(text, u8:decode"SMS: Вот тачка которую мы заказывали.") then
			sampSendChat("/anim " .. ini4[GhettoMateSettings].IdAnimUgonyala)
		end
	end
	
	-- DRUGS --
	
	if ini4[GhettoMateSettings].NotifyDrugs then
		if string.find(text, u8:decode"(( Здоровье пополнено до: .+ ))") or string.find(text, u8:decode"(( Остаток: .+ грамм ))") then
			Use = false
			DrugsWait:run()
		end
	end
	if string.find(text, u8:decode"Недостаточно наркотиков") and ini.GhettoMateConfig.my_drugs > 0 then
		--DrugsCount = DrugsCount - 1
		--UseDrugsWait:run(DrugsCount)
		UseDrugsTimer:run(ini.GhettoMateConfig.my_drugs)
	elseif string.find(text, u8:decode"Недостаточно наркотиков") and ini.GhettoMateConfig.my_drugs == 0 then
		ini.GhettoMateConfig.my_drugs = 0 
		inicfg.save(ini, directIni)
	end

	if string.find(text,  u8:decode" Остаток: .+ грамм") then
		ini.GhettoMateConfig.my_drugs = string.match(text, u8:decode" Остаток: (.+) грамм")
		UseDrugsTimer = os.clock() + 60
		inicfg.save(ini, directIni)
	end
	if string.find(text, u8:decode"Остаток: .+ материалов") then
		ini.GhettoMateConfig.my_mats = string.match(text, u8:decode"Остаток: (.+) материалов")
		inicfg.save(ini, directIni)
	end
	if string.find(text, u8:decode"У вас 500/500 материалов с собой") then
		ini.GhettoMateConfig.my_mats = 500
		inicfg.save(ini, directIni)
	end
	if string.find(text, u8:decode"У вас 600/600 материалов с собой") then
		ini.GhettoMateConfig.my_mats = 600
		inicfg.save(ini, directIni)
	end
	if string.find(text, u8:decode"У вас 800/800 материалов с собой") then
		ini.GhettoMateConfig.my_mats = 800
		inicfg.save(ini, directIni)
	end
	if string.find(text, u8:decode"Вы купили .+ грамм за .+ вирт") then
		ini.GhettoMateConfig.my_drugs = string.match(text, u8:decode"У вас есть (.+) грамм")
		inicfg.save(ini, directIni)
	end
	
	if string.find(text, u8:decode"На вашу территорию напали") or string.find(text, u8:decode"Ваша банда напала на территорию") then
		ini2[GhettoMateCapture].CaptureKill = 0
		ini2[GhettoMateCapture].CaptureDeath = 0
		inicfg.save(ini2, directIni2)
	end
end

function sampev.onDisplayGameText(style, time, text)
	if Magaz1 or Magaz2 or Magaz3 or Magaz4 or Magaz5 or Magaz6 or Magaz7 or Magaz8 or Magaz9 or Magaz10 or Magaz11 or Magaz12 or Magaz13 or Magaz14 or Magaz15 or Magaz16 then
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
			ini[GhettoMateConfig].timeCalibration = true
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
		sampAddChatMessage(" [GhettoMate] {FFFFFF}AutoGetGuns: {FF0000}off", main_color)
	end
end

--SUCHER--

function cmd_sucher(arg)
	Find = not Find
	Found = false
	NotFound = false
	WasFound = false
	TargetDead = false
	TargetId = arg
	TargetLeave = false
	if sampIsPlayerConnected(TargetId) then
		playerNickname = sampGetPlayerNickname(TargetId)
		if tonumber(arg) == tonumber(my_id) then
			if ini4[GhettoMateSettings].NotifyFind then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Не имеет смысла", main_color)
				if ini4[GhettoMateSettings].Sounds then
					soundManager.playSound("message_sms")
				end
			end
			Find = false
		end
		if not Find then
			if ini4[GhettoMateSettings].NotifyFind then
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Поиск прекращен", main_color)
				if ini4[GhettoMateSettings].Sounds then
					soundManager.playSound("message_sms")
				end
			end
			deleteCheckpoint(checkpoint)
			removeBlip(blip)
		end
	else
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Игрок не на сервере", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_sms")
		end
		Find = false
	end
end

function Suchen()
	if sampIsPlayerConnected(TargetId) then
		result, ped = sampGetCharHandleBySampPlayerId(TargetId)
		if result then
			if not TargetDead then
				if isCharDead(ped) then
					TargetDead = true
					Find = false
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} ликвидирована!", main_color)
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_sms")
					end
					deleteCheckpoint(checkpoint)
					removeBlip(blip)
				end
			end
			local posX, posY, posZ = getCharCoordinates(ped)
			health = sampGetPlayerHealth(TargetId)
			armor = sampGetPlayerArmor(TargetId)
			deleteCheckpoint(checkpoint)
			removeBlip(blip)
			checkpoint = createCheckpoint(1, posX, posY, posZ, posX, posY, posZ, 1)
			blip = addSpriteBlipForCoord(posX, posY, posZ, 3)
			if Found == false then
				if ini4[GhettoMateSettings].NotifyFind then
					AfkStatus = sampIsPlayerPaused(TargetId)
					if AfkStatus then
						sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Цель{FF0000} %s {FFFFFF}обнаружена! {FF0000}%s {DCDCDC}%s{FFFFFF} AFK", playerNickname, health, armor), main_color)
					else
						sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Цель{FF0000} %s {FFFFFF}обнаружена! {FF0000}%s {DCDCDC}%s{FFFFFF} ", playerNickname, health, armor), main_color)
					end
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_sms")
					end
				end
				Found = true
				NotFound = false
				WasFound = true
			end
		else
			if NotFound == false and WasFound == false then
				if ini4[GhettoMateSettings].NotifyFind then
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} не обнаружена!", main_color)
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_sms")
					end
				end
				NotFound = true
				Found = false
			end
			if NotFound == false and WasFound == true then
				if ini4[GhettoMateSettings].NotifyFind then
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} пропала!", main_color)
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_sms")
					end
				end
				NotFound = true
				Found = false
			end
		end
	else
		Find = false
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Цель {FF0000}" .. playerNickname .. u8:decode"{FFFFFF} вышла с сервера!", main_color)
		if ini4[GhettoMateSettings].Sounds then
			soundManager.playSound("message_sms")
		end
		deleteCheckpoint(checkpoint)
		removeBlip(blip)
	end
end

--UGONYALA by 21se--

function sampev.onSendCommand(cmd)
	local args = {}

	for arg in cmd:gmatch("%S+") do
		table.insert(args, arg)
	end

	if args[1] == '/fc' then
		if args[2] then
			imgui.Process = true
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
					sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Поиск {FF0000}\"%s\" {FFFFFF}активирован", carname), main_color)
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_tip")
					end
				end
				search = true
				removeMarks()
				for i, veh in ipairs(vehlist) do
					if string.lower(carname) == string.lower(veh[1]) then
						table.insert(marks, addSpriteBlipForCoord(veh[2], veh[3], veh[4], 55))
						table.insert(ugcheckpoints, createCheckpoint(1, veh[2], veh[3], veh[4], veh[2], veh[3], veh[4], 1))
						local _thiefZone = ''
						local _minDist = 100000
						for k,v in pairs(zone) do
							local dist = getDistanceBetweenCoords3d(veh[2], veh[3], v.z, v.x, v.y, v.z)
							if dist < _minDist then
								_minDist = dist
								_thiefZone = k
							end
						end
						if ini4[GhettoMateSettings].NotifyUgonyala then
							if veh[6] then
								sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FF0000}\"%s\"{FFFFFF} был обнаружен{FFFF00} %s {FFFFFF}минут назад, за рулем был: {FFFF00}%s{FFFFFF}. Около {FFFF00}%s", veh[1], math.floor((os.clock()-veh[7])/60), veh[6], _thiefZone), main_color)
							else
								sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FF0000}\"%s\"{FFFFFF} был обнаружен{FFFF00} %s {FFFFFF}минут назад. Около {FFFF00}%s", veh[1], math.floor((os.clock()-veh[7])/60), _thiefZone), main_color)
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
			if ugtimer > 0 then
				if math.floor(ugtimer%60) >= 10 then
					if ini4[GhettoMateSettings].NotifyUgonyala then
						sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Угон доступен через: {FFFF00}%s:%s",math.floor(ugtimer/60),math.floor(ugtimer%60)), main_color)
					end
				else
					if ini4[GhettoMateSettings].NotifyUgonyala then
						sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Угон доступен через: {FFFF00}%s:0%s",math.floor(ugtimer/60),math.floor(ugtimer%60)), main_color)
					end
				end
			else
				if ini4[GhettoMateSettings].NotifyUgonyala then
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Угон доступен", main_color)
					if ini4[GhettoMateSettings].Sounds then
						soundManager.playSound("message_tip")
					end
				end
			end
		end
	end

	if args[1] == '/autogetguns' then
		cmd_autogetguns()
	end

	if args[1] == '/l' then
		if args[2] == '1' then
			if ini3[GhettoMateTime].time1 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name1)
			else
				if ini3[GhettoMateSeconds].time1 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name1 .. " [" .. ini3[GhettoMateTime].time1 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name1 .. " [" .. ini3[GhettoMateTime].time1 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '2' then
			if ini3[GhettoMateTime].time2 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name2)
			else
				if ini3[GhettoMateSeconds].time2 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name2 .. " [" .. ini3[GhettoMateTime].time2 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name2 .. " [" .. ini3[GhettoMateTime].time2 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '3' then
			if ini3[GhettoMateTime].time3 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name3)
			else
				if ini3[GhettoMateSeconds].time3 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name3 .. " [" .. ini3[GhettoMateTime].time3 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name3 .. " [" .. ini3[GhettoMateTime].time3 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '4' then
			if ini3[GhettoMateTime].time4 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name4)
			else
				if ini3[GhettoMateSeconds].time4 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name4 .. " [" .. ini3[GhettoMateTime].time4 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name4 .. " [" .. ini3[GhettoMateTime].time4 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '5' then
			if ini3[GhettoMateTime].time5 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name5)
			else
				if ini3[GhettoMateSeconds].time5 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name5 .. " [" .. ini3[GhettoMateTime].time5 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name5 .. " [" .. ini3[GhettoMateTime].time5 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '6' then
			if ini3[GhettoMateTime].time6 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name6)
			else
				if ini3[GhettoMateSeconds].time6 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name6 .. " [" .. ini3[GhettoMateTime].time6 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name6 .. " [" .. ini3[GhettoMateTime].time6 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '7' then
			if ini3[GhettoMateTime].time7 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name7)
			else
				if ini3[GhettoMateSeconds].time7 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name7 .. " [" .. ini3[GhettoMateTime].time7 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name7 .. " [" .. ini3[GhettoMateTime].time7 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '8' then
			if ini3[GhettoMateTime].time8 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name8)
			else
				if ini3[GhettoMateSeconds].time8 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name8 .. " [" .. ini3[GhettoMateTime].time8 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name8 .. " [" .. ini3[GhettoMateTime].time8 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '9' then
			if ini3[GhettoMateTime].time9 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name9)
			else
				if ini3[GhettoMateSeconds].time9 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name9 .. " [" .. ini3[GhettoMateTime].time9 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name9 .. " [" .. ini3[GhettoMateTime].time9 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '10' then
			if ini3[GhettoMateTime].time10 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name10)
			else
				if ini3[GhettoMateSeconds].time10 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name10 .. " [" .. ini3[GhettoMateTime].time10 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name10 .. " [" .. ini3[GhettoMateTime].time10 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '11' then
			if ini3[GhettoMateTime].time11 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name11)
			else
				if ini3[GhettoMateSeconds].time11 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name11 .. " [" .. ini3[GhettoMateTime].time11 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name11 .. " [" .. ini3[GhettoMateTime].time11 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '12' then
			if ini3[GhettoMateTime].time12 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name12)
			else
				if ini3[GhettoMateSeconds].time12 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name12 .. " [" .. ini3[GhettoMateTime].time12 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name12 .. " [" .. ini3[GhettoMateTime].time12 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '13' then
			if ini3[GhettoMateTime].time13 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name13)
			else
				if ini3[GhettoMateSeconds].time13 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name13 .. " [" .. ini3[GhettoMateTime].time13 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name13 .. " [" .. ini3[GhettoMateTime].time13 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '14' then
			if ini3[GhettoMateTime].time14 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name14)
			else
				if ini3[GhettoMateSeconds].time14 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name14 .. " [" .. ini3[GhettoMateTime].time14 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name14 .. " [" .. ini3[GhettoMateTime].time14 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '15' then
			if ini3[GhettoMateTime].time15 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name15)
			else
				if ini3[GhettoMateSeconds].time15 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name15 .. " [" .. ini3[GhettoMateTime].time15 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name15 .. " [" .. ini3[GhettoMateTime].time15 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == '16' then
			if ini3[GhettoMateTime].time16 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name16)
			else
				if ini3[GhettoMateSeconds].time16 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name16 .. " [" .. ini3[GhettoMateTime].time16 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в ларёк " .. ini[GhettoMateName].Name16 .. " [" .. ini3[GhettoMateTime].time16 .. u8:decode" - Можно]")
				end
			end
		end
	end

	if args[1] == '/mo' then
		if args[2] == 'ls' then
			if ini3[TimeMO].time1 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в MO LS")
			else
				if ini3[SecondsMO].time1 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в MO LS" .. " [" .. ini3[TimeMO].time1 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в MO LS" .. " [" .. ini3[TimeMO].time1 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == 'sf' then
			if ini3[TimeMO].time2 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в MO SF")
			else
				if ini3[SecondsMO].time2 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в MO SF" .. " [" .. ini3[TimeMO].time2 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в MO SF" .. " [" .. ini3[TimeMO].time2 .. u8:decode" - Можно]")
				end
			end
		end
		if args[2] == 'lv' then
			if ini3[TimeMO].time3 == u8:decode"Неизвестно" then
				sampSendChat(u8:decode"Нам нужно ехать в MO LV")
			else
				if ini3[SecondsMO].time3 - totalSeconds > 0 then
					sampSendChat(u8:decode"Нам нужно ехать в MO LV" .. " [" .. ini3[TimeMO].time3 .. u8:decode" - Нельзя]")
				else
					sampSendChat(u8:decode"Нам нужно ехать в MO LV" .. " [" .. ini3[TimeMO].time3 .. u8:decode" - Можно]")
				end
			end
		end
	end

	if args[1] == '/sg' then -- command
		if args[2] == 'deagle' or args[2] == 'sdpistol' or args[2] == 'rifle' or args[2] == 'shotgun' or args[2] == 'smg' or args[2] == 'ak47' or args[2] == 'm4' then -- gun
			if args[3] ~= nil and args[3] ~= "" and tonumber(args[3]) > 0 and isNumber(args[3]) then -- pt
				if args[4] ~= nil and args[4] ~= "" and tonumber(args[4]) >= 0 and tonumber(args[4]) < 1000 then --id player
					if args[2] == 'deagle' then price_gun = ini.GhettoMateConfig.price_Deagle end
					if args[2] == 'm4' then price_gun = ini.GhettoMateConfig.price_M4 end
					if args[2] == 'sdpistol' then price_gun = ini.GhettoMateConfig.price_SDpistol end
					if args[2] == 'rifle' then price_gun = ini.GhettoMateConfig.price_Rifle end
					if args[2] == 'shotgun' then price_gun = ini.GhettoMateConfig.price_Shotgun end
					if args[2] == 'ak47' then price_gun = ini.GhettoMateConfig.price_AK47 end
					if args[2] == 'smg' then price_gun = ini.GhettoMateConfig.price_SMG end
					sampSendChat("/sellgun " .. args[2] .. " " .. args[3] .. " " .. tonumber(args[3]) * tonumber(price_gun) .. " " .. args[4])
				else
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
				end

			else
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Патронов должно быть больше нуля", main_color)
			end
		else
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Неверно выбрано оружие", main_color)
		end
	end

	if args[1] == '/sd' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > tonumber(0) then -- id
			if args[3] ~= nil and args[3] ~= "" and isNumber(args[3])  and tonumber(args[3]) >= 0 and tonumber(args[3]) < 1000 then -- count
				sampSendChat("/selldrugs " .. args[2] .. " " .. args[3] .. " " .. tonumber(args[3]) * tonumber(ini.GhettoMateConfig.price_Drugs))
			else
				sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Наркотиков должно быть больше нуля", main_color)
			end
		else
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}id должен быть от 0 до 999", main_color)
		end
	end

	if args[1] == '//gun' then
		GunWait:run(ini.GunList.gun1, ini.GunList.gun2, ini.GunList.gun3, ini.GunList.pt1, ini.GunList.pt2, ini.GunList.pt3)
	end
	
	if args[1] == '/deagle' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun deagle " .. args[2])
		end
	elseif args[1] == '/m4' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun m4 " .. args[2])
		end
	elseif args[1] == '/rifle' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun rifle " .. args[2])
		end
	elseif args[1] == '/shotgun' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun shotgun " .. args[2])
		end
	elseif args[1] == '/sdpistol' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun sdpistol " .. args[2])
		end
	elseif args[1] == '/ak47' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun ak47 " .. args[2])
		end
	elseif args[1] == '/smg' then
		if args[2] ~= nil and args[2] ~= "" and isNumber(args[2]) and tonumber(args[2]) > 0 then --pt
			sampSendChat("/gun smg " .. args[2])
		end
	end
		
end

function isNumber(n)
    return type(tonumber(n)) == "number"
end

function cmd_usedrugs()
	player_health = getCharHealth(PLAYER_PED)
	if player_health < ini4[GhettoMateSettings].Health then
		DrugsCount = math.ceil((ini4[GhettoMateSettings].Health - player_health) / 10)
		if ini4[GhettoMateSettings].Health == 120 then
			if DrugsCount >= 4 then DrugsCount = 3 end
			sampSendChat("/usedrugs " .. DrugsCount)
		end
		if ini4[GhettoMateSettings].Health == 130 then
			if DrugsCount >= 7 then DrugsCount = 6 end
			sampSendChat("/usedrugs " .. DrugsCount)
		end
		if ini4[GhettoMateSettings].Health == 140 then
			if DrugsCount >= 10 then DrugsCount = 9 end
			sampSendChat("/usedrugs " .. DrugsCount)
		end
		if ini4[GhettoMateSettings].Health == 150 then
			if DrugsCount >= 13 then DrugsCount = 12 end
			sampSendChat("/usedrugs " .. DrugsCount)
		end
		if ini4[GhettoMateSettings].Health == 160 then
			if DrugsCount >= 16 then DrugsCount = 15 end
			sampSendChat("/usedrugs " .. DrugsCount)
		end
		if ini4[GhettoMateSettings].NotifyDrugs then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Было использовано {FFFF00}" .. DrugsCount .. u8:decode" {FFFFFF}нарко", main_color)
		end
	end
end

function stopSearch()
	removeMarks()
	if search then
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Поиск {FF0000}\"%s\"{FFFFFF} прекращен", carname), main_color)
			if ini4[GhettoMateSettings].Sounds then
				soundManager.playSound("message_tip")
			end
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

soundManager = {}
soundManager.soundsList = {}

function soundManager.loadSound(soundName)
	soundManager.soundsList[soundName] = loadAudioStream(getWorkingDirectory()..'\\rsc\\'..soundName..'.mp3')
end

function soundManager.playSound(soundName)
	if soundManager.soundsList[soundName] then
		setAudioStreamVolume(soundManager.soundsList[soundName], 50/100)
		setAudioStreamState(soundManager.soundsList[soundName], as_action.PLAY)
	end
end

function sampev.onSetRaceCheckpoint(type, position) --by Serhiy_Rubin
	for k,v in pairs(coord) do
		local dist = getDistanceBetweenCoords3d(position.x, position.y, position.z, v.x, v.y, v.z)
		if dist <= 3 then
			thiefPos = k
		end
	end
end

function sampev.onCreateGangZone(zoneId, squareStart, squareEnd, color) --by Serhiy_Rubin
	if HexColor(color) == '000000' then
		lua_thread.create(function()
			local _thiefZone = ''
			local _minDist = 100000
			local playerDist = 0
			for k,v in pairs(zone) do
				local dist = getDistanceBetweenCoords3d(squareStart.x, squareStart.y, v.z, v.x, v.y, v.z)
				if dist < _minDist then
					playerDist = getDistanceBetweenCoords3d(squareStart.x, squareStart.y, v.z, getCharCoordinates(PLAYER_PED))
					_minDist = dist
					_thiefZone = k
				end
			end
			thiefZone = { squareStart.x, squareStart.y, 0.0 }
			wait(200)
			if ini4[GhettoMateSettings].NotifyUgonyala then
				sampAddChatMessage(string.format(u8:decode' [GhettoMate] {FFFFFF}Выделен черный квадрат рядом с {FFFF00}"%s" (%d m).{FFFFFF} До квадрата: {FFFF00}%d {FFFFFF}метров.', _thiefZone, _minDist, playerDist), main_color)
			end
		end)
	end
end

function HexColor(CaptureColor) --by Serhiy_Rubin
	return ("%06x"):format(bit.band(CaptureColor, 0xFFFFFF))
end

function sampev.onPlayerDeathNotification(playerId, killerId, reason)
	if my_id == playerId then
		if reason == 0 then
			ini2[GhettoMateCapture].gun_fist = ini2[GhettoMateCapture].gun_fist + 1
		end
		if reason == 31 then
			ini2[GhettoMateCapture].gun_m4 = ini2[GhettoMateCapture].gun_m4 + 1
		end
		if reason == 24 then
			ini2[GhettoMateCapture].gun_deagle = ini2[GhettoMateCapture].gun_deagle + 1
		end
		if reason == 30 then
			ini2[GhettoMateCapture].gun_ak47 = ini2[GhettoMateCapture].gun_ak47 + 1
		end
		if reason == 23 then
			ini2[GhettoMateCapture].gun_sdpistol = ini2[GhettoMateCapture].gun_sdpistol + 1
		end
		if reason == 25 then
			ini2[GhettoMateCapture].gun_shotgun = ini2[GhettoMateCapture].gun_shotgun + 1
		end
		if reason == 33 then
			ini2[GhettoMateCapture].gun_rifle = ini2[GhettoMateCapture].gun_rifle + 1
		end
		if reason == 5 then
			ini2[GhettoMateCapture].gun_bat = ini2[GhettoMateCapture].gun_bat + 1
		end
		if reason ~= 0 and reason ~= 31 and reason ~= 24 and reason ~= 30 and reason ~= 23 and reason ~= 25 and reason ~= 33 and reason ~= 5 then
			ini2[GhettoMateCapture].gun_ost = ini2[GhettoMateCapture].gun_ost + 1
		end
		killer_name = sampGetPlayerNickname(killerId)
		CaptureColor = sampGetPlayerColor(killerId)
		CaptureColor = argb_to_rgb(CaptureColor)
		if tonumber(CaptureColor) == 631808 then
			ini2[GhettoMateCapture].grove_kill = ini2[GhettoMateCapture].grove_kill + 1
			inicfg.save(ini2, directIni2)
		end
		if tonumber(CaptureColor) == 912895 then
			ini2[GhettoMateCapture].aztecas_kill = ini2[GhettoMateCapture].aztecas_kill + 1
		end
		if tonumber(CaptureColor) == 16768548 then
			ini2[GhettoMateCapture].vagos_kill = ini2[GhettoMateCapture].vagos_kill + 1
		end
		if tonumber(CaptureColor) == 3055739 then
			ini2[GhettoMateCapture].rifa_kill = ini2[GhettoMateCapture].rifa_kill + 1
		end
		if tonumber(CaptureColor) == 12916223 then
			ini2[GhettoMateCapture].ballas_kill = ini2[GhettoMateCapture].ballas_kill + 1
		end
		if CaptureColor == nil then CaptureColor = 'FFFFFF' end
		CaptureColor = string.format("%06X",CaptureColor)
		if ini4[GhettoMateSettings].NotifyCapture then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Вы убили {"..CaptureColor.."}" .. killer_name .. u8:decode' {FFFFFF}с помощью ' .. getweaponname(reason), main_color)
		end
		ini2[GhettoMateCapture].kill = ini2[GhettoMateCapture].kill + 1
		ini2[GhettoMateCapture].CaptureKill = ini2[GhettoMateCapture].CaptureKill + 1
		inicfg.save(ini2, directIni2)
	end
	if my_id == killerId then
		killer_name = sampGetPlayerNickname(playerId)
		CaptureColor = sampGetPlayerColor(playerId)
		CaptureColor = argb_to_rgb(CaptureColor)
		if CaptureColor == nil then CaptureColor = 'FFFFFF' end
		CaptureColor = string.format("%06X",CaptureColor)
		if ini4[GhettoMateSettings].NotifyCapture then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Вас убил {"..CaptureColor.."}" .. killer_name .. u8:decode' {FFFFFF}с помощью ' .. getweaponname(reason), main_color)
		end
		ini2[GhettoMateCapture].death = ini2[GhettoMateCapture].death + 1
		ini2[GhettoMateCapture].CaptureDeath = ini2[GhettoMateCapture].CaptureDeath + 1
		inicfg.save(ini2, directIni2)
	end
end

function argb_to_rgb(argb) -- by Raymond
    return bit.band(argb, 0xFFFFFF)
end

function getweaponname(weapon) -- getweaponname by FYP
  local names = {
  [0] = u8:decode"Кулака",
  [1] = u8:decode"Кастета",
  [2] = u8:decode"Клюшки для гольфа",
  [3] = u8:decode"Полицейской дубинки",
  [4] = u8:decode"Ножа",
  [5] = u8:decode"Биты",
  [6] = u8:decode"Лопаты",
  [7] = u8:decode"Кия",
  [8] = u8:decode"Катаны",
  [9] = u8:decode"Бензопилы",
  [10] = u8:decode"Розового дилдо",
  [11] = u8:decode"Дилдо",
  [12] = u8:decode"Вибратора",
  [13] = u8:decode"Серебрянного вибратора",
  [14] = u8:decode"Цветов",
  [15] = u8:decode"Трости",
  [16] = u8:decode"Гранаты",
  [17] = u8:decode"Слезоточивого газа",
  [18] = u8:decode"Коктейля молотова",
  [22] = u8:decode"Пистолета",
  [23] = u8:decode"Пистолета с глушителем",
  [24] = u8:decode"Дигла",
  [25] = u8:decode"Дробовика",
  [26] = u8:decode"Обреза",
  [27] = u8:decode"Боевого дробовика",
  [28] = u8:decode"Micro SMG/Uzi",
  [29] = u8:decode"MP5",
  [30] = u8:decode"AK-47",
  [31] = u8:decode"M4",
  [32] = u8:decode"Tec-9",
  [33] = u8:decode"Винтовки",
  [34] = u8:decode"Снайперской винтовки",
  [35] = u8:decode"РПГ",
  [36] = u8:decode"HS Rocket",
  [37] = u8:decode"Огнемёта",
  [38] = u8:decode"Минигана",
  [39] = u8:decode"Satchel Charge",
  [40] = u8:decode"Detonator",
  [41] = u8:decode"Газового балончика",
  [42] = u8:decode"Огнетушителя",
  [43] = u8:decode"Camera",
  [44] = u8:decode"Night Vis Goggles",
  [45] = u8:decode"Thermal Goggles",
  [46] = u8:decode"Parachute" }
  return names[weapon]
end

function AfterDeathReload()
	if isPlayerDead(playerHandle) then
		Magaz1  = false
		Magaz2  = false
		Magaz3  = false
		Magaz4  = false
		Magaz5  = false
		Magaz6  = false
		Magaz7  = false
		Magaz8  = false
		Magaz9  = false
		Magaz10 = false
		Magaz11 = false
		Magaz12 = false
		Magaz13 = false
		Magaz14 = false
		Magaz15 = false
		Magaz16 = false
		MOLS    = false
		MOSF    = false
		MOLV    = false
		Use     = true
		DrugsWait:terminate()
	end
end

function toScreenY(gY)
    local x, y = convertGameScreenCoordsToWindowScreenCoords(0, gY)
    return y
end

function toScreenX(gX)
    local x, y = convertGameScreenCoordsToWindowScreenCoords(gX, 0)
    return x
end

function toScreen(gX, gY)
    local s = {}
    s.x, s.y = convertGameScreenCoordsToWindowScreenCoords(gX, gY)
    return s
end

function vec(gX, gY)
    return imgui.ImVec2(convertGameScreenCoordsToWindowScreenCoords(gX, gY))
end

function LarekChecker()
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
end

function MOChecker()
	if ini3[TimeMO].time1 == u8:decode"Неизвестно" then
		colorMO[1] = "{808080}"
	else
		if timerMO[1] == 1 then
			colorMO[1] = "{d10000}"
		else
			colorMO[1] = "{06940f}"
		end
	end
	if ini3[TimeMO].time2 == u8:decode"Неизвестно" then
		colorMO[2] = "{808080}"
	else
		if timerMO[2] == 1 then
			colorMO[2] = "{d10000}"
		else
			colorMO[2] = "{06940f}"
		end
	end
	if ini3[TimeMO].time3 == u8:decode"Неизвестно" then
		colorMO[3] = "{808080}"
	else
		if timerMO[3] == 1 then
			colorMO[3] = "{d10000}"
		else
			colorMO[3] = "{06940f}"
		end
	end
end
