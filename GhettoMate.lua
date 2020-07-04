script_name("GhettoMate")
script_author("Vlaek (Oleg_Cutov aka bier aka Vladanus)")
script_version('03/07/2020')
script_version_number(8.2)
script_url("https://vlaek.github.io/GhettoMate/")
script.update = false

local sampev, inicfg, imgui, encoding, keys = require 'lib.samp.events', require 'inicfg', require 'imgui', require 'encoding', require "vkeys"
local as_action = require 'moonloader'.audiostream_state

require "reload_all"
require "lib.sampfuncs"
require "lib.moonloader"
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
local secondary_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

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
local timerMO = {0, 0, 0}
local hourMO = {0, 0, 0}
local minuteMO = {0, 0, 0}
local secondsMO = {0, 0, 0}
local colorMO = {"{808080}", "{808080}", "{808080}"}
local MOTime = {false, false, false}
--UGONYALA--
local ugontimer = 0
local ugtimer = 0
local mark, ugcheckpoint = nil, nil
local marks, ugcheckpoints = {}, {}
local vehlist = {}
local spam = true
local notify = false
local search = false
local thiefPos = ""
--DRUGS
local DrugsCount = 0

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
	sampRegisterChatCommand("lhud", cmd_hud)
	sampRegisterChatCommand("mohud", cmd_MOhud)
	sampRegisterChatCommand("gfind", cmd_sucher)
	sampRegisterChatCommand("drugs", cmd_usedrugs)
	sampRegisterChatCommand('GhettoMate', function()
		ShowDialog(20)
	end)
	sampRegisterChatCommand('GM', function()
		ShowDialog(20)
	end)
	sampRegisterChatCommand('larek', function()
		ShowDialog(1)
	end)
	
	Wait = lua_thread.create_suspended(Waiting)
	MOWait = lua_thread.create_suspended(MOWaiting)
	Wait2 = lua_thread.create_suspended(Waiting2)
	MOWait2 = lua_thread.create_suspended(MOWaiting2)
	DrugsWait = lua_thread.create_suspended(DrugsWaiting)
	UseDrugsWait = lua_thread.create_suspended(UseDrugsWaiting)
	MONotifyWait = lua_thread.create_suspended(MONotifyWaiting)
	
	AdressConfig = string.format("%s\\moonloader\\config", getGameDirectory())
	AdressGhettoMate = string.format("%s\\moonloader\\config\\GhettoMate", getGameDirectory())
	if not doesDirectoryExist(AdressConfig) then createDirectory(AdressConfig) end
	if not doesDirectoryExist(AdressGhettoMate) then createDirectory(AdressGhettoMate) end
	
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
		sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Откалибруйте время в /GhettoMate", main_color)
		ini = inicfg.load({
			[GhettoMateConfig] = {
				time = tonumber(0),
				X = tonumber(0),
				Y = tonumber(0),
				X_MO =tonumber(0),
				Y_MO = tonumber(0)
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
	
	GhettoMateMO = string.format('GhettoMateMO-%s', my_name)
	if ini2[GhettoMateMO] == nil then
		ini2 = inicfg.load({
			[GhettoMateMO] = {
				mats  = tonumber(0),
				cars  = tonumber(0)
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
	
	TimeMO = string.format('TimeMO-Server-%s', server)
	if ini3[TimeMO] == nil then
		ini3 = inicfg.load({
			[TimeMO] = {
				time1  = u8:decode"Неизвестно",
				time2  = u8:decode"Неизвестно",
				time3  = u8:decode"Неизвестно"
			}
		}, directIni3)
		inicfg.save(ini3, directIni3)
	end
	
	SecondsMO = string.format('SecondsMO-Server-%s', server)
	if ini3[SecondsMO] == nil then
		ini3 = inicfg.load({
			[SecondsMO] = {
				time1  = tonumber(0),
				time2  = tonumber(0),
				time3  = tonumber(0)
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
				NotifyDrugs=true,
				NotifyAutoGetGuns=true,
				TimerNotifyMO=tonumber(15),
				NotifyMO=true,
				Health=120,
				Sounds=false
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
	imgui.Process = false
	
	while true do
		wait(250)
		
		paused = isGamePaused()
		imgui.ShowCursor = false
		
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
		
		if isKeyJustPressed(VK_MULTIPLY) then
			cmd_autogetguns()
		end
		
		if isKeyJustPressed(VK_ADD) then
			cmd_usedrugs()
		end
		
		local caption = sampGetDialogCaption()
		local result, button, list, input = sampHasDialogRespond(1000)
		if caption == u8:decode'GhettoMate: Список' then
			if result and button == 1 then
				if dialogLine[list + 1]     ==  u8:decode'  1. Larek\t' then
					ShowDialog(1)
				elseif dialogLine[list + 1] ==  u8:decode'  2. MO\t' then
					ShowDialog(170)
				elseif dialogLine[list + 1] ==  u8:decode'  3. AutoGetGuns\t' .. (GetGuns and '{06940f}ON' or '{d10000}OFF') then
					cmd_autogetguns()
					ShowDialog(20)
				elseif dialogLine[list + 1] ==  u8:decode'  4. Find\t'  .. (Find and '{06940f}ON' or '{d10000}OFF') then
					if Find == true then
						Find = false
						deleteCheckpoint(checkpoint)
						removeBlip(blip)
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Поиск прекращен", main_color)
						ShowDialog(20)
					else
						deleteCheckpoint(checkpoint)
						removeBlip(blip)
						ShowDialog(21)
					end
				elseif dialogLine[list + 1] ==  u8:decode'  5. Ugonyala\t' .. (search and '{06940f}ON' or '{d10000}OFF') then
					if search == true then
						sampSendChat("/fc")
					else
						ShowDialog(22)
					end
				elseif dialogLine[list + 1] ==  u8:decode'> Настройки\t' then
					ShowDialog(23)
				elseif dialogLine[list + 1] ==  u8:decode'> Помощь\t' then
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/larek {FFFFFF}- включить диалоговое окно Larek", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/lhud {FFFFFF}- включить Larek HUD", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/l (1,2, .. 16){FFFFFF} - указать в какой ларёк ехать + тайминг", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/mohud {FFFFFF}- включить MO HUD", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/mo (ls, sf и lv) {FFFFFF}- указать в какой МО ехать + тайминг", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/autogetguns {FFFFFF}- включить/выключить AutoGetGuns (* NumPad)", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/gfind (id){FFFFFF} - искать игрока по его id", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/fc (name) {FFFFFF}- искать машину по ее названию", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/fc {FFFFFF}- если без аргумента, то прекращает поиск", main_color)
					sampAddChatMessage(u8:decode" [GhettoMate] {FFFF00}/drugs {FFFFFF}- заюзать наркотики", main_color)
					ShowDialog(20)
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
					elseif dialogLine[list + 1] ==  u8:decode'  2. Таймер уведомлений от Larek\t' .. ini4[GhettoMateSettings].TimerNotifyLarek then
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
					elseif dialogLine[list + 1] ==  u8:decode'  7. Максимальное количество ХП\t' .. ini4[GhettoMateSettings].Health then
						ShowDialog(27)
						inicfg.save(ini4, directIni4)
					elseif dialogLine[list + 1] ==  u8:decode'  8. Уведомления от Drugs\t' .. (ini4[GhettoMateSettings].NotifyDrugs and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyDrugs = not ini4[GhettoMateSettings].NotifyDrugs
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode'  9. Уведомления от AutoGetGuns\t' .. (ini4[GhettoMateSettings].NotifyAutoGetGuns and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyAutoGetGuns = not ini4[GhettoMateSettings].NotifyAutoGetGuns
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode' 10. Уведомления от MO\t' .. (ini4[GhettoMateSettings].NotifyMO and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].NotifyMO = not ini4[GhettoMateSettings].NotifyMO
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					elseif dialogLine[list + 1] ==  u8:decode' 11. Таймер уведомлений от MO\t' .. ini4[GhettoMateSettings].TimerNotifyMO then
						ShowDialog(26)
						inicfg.save(ini4, directIni4)
					elseif dialogLine[list + 1] ==  u8:decode' 12. Звуки\t' .. (ini4[GhettoMateSettings].Sounds and '{06940f}ON' or '{d10000}OFF') then
						ini4[GhettoMateSettings].Sounds = not ini4[GhettoMateSettings].Sounds
						ShowDialog(23)
						inicfg.save(ini4, directIni4)
					elseif dialogLine[list + 1] == ' 13. ' .. (script.update and u8:decode'{d10000}Обновить скрипт' or u8:decode'{06940f}Актуальная версия') then
						if script.update then
							imgui.Process = false
							update()
						else
							sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Последняя версия уже установлена", main_color)
							ShowDialog(23)
						end
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
					elseif dialogLine[list + 1] == '> Larek HUD\t' .. (main_window_state.v and '{06940f}ON' or '{d10000}OFF') then
						cmd_hud()
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
		local result, button, list, input = sampHasDialogRespond(1700)
		if caption == u8:decode'MO: Список' then
			if result then
				if button == 1 then
					if dialogLine[list + 1]     ==  '  1. MO LS\t' .. colorMO[1]  .. ini3[TimeMO].time1 then
						if ini3[TimeMO].time1 == u8:decode"Неизвестно" then 
							sampSendChat(u8:decode"/fs Нам нужно ехать в MO LS")
						else
							if ini3[SecondsMO].time1 - totalSeconds > 0 then
								sampSendChat(u8:decode"/fs MO LS даёт в " .. ini3[TimeMO].time1 .. u8:decode" [Нельзя]")
							else
								sampSendChat(u8:decode"/fs MO LS даёт в " .. ini3[TimeMO].time1 .. u8:decode" [Можно]")
							end
						end
						ShowDialog(170)
					elseif dialogLine[list + 1] ==  '  2. MO SF\t' .. colorMO[2]  .. ini3[TimeMO].time2 then
						if ini3[TimeMO].time2 == u8:decode"Неизвестно" then 
							sampSendChat(u8:decode"/fs Нам нужно ехать в MO SF")
						else
							if ini3[SecondsMO].time2 - totalSeconds > 0 then
								sampSendChat(u8:decode"/fs MO SF даёт в " .. ini3[TimeMO].time2 .. u8:decode" [Нельзя]")
							else
								sampSendChat(u8:decode"/fs MO SF даёт в " .. ini3[TimeMO].time2 .. u8:decode" [Можно]")
							end
						end
						ShowDialog(170)
					elseif dialogLine[list + 1] ==  '  3. MO LV\t' .. colorMO[3]  .. ini3[TimeMO].time3 then
						if ini3[TimeMO].time3 == u8:decode"Неизвестно" then 
							sampSendChat(u8:decode"/fs Нам нужно ехать в MO LV")
						else
							if ini3[SecondsMO].time3 - totalSeconds > 0 then
								sampSendChat(u8:decode"/fs MO LV даёт в " .. ini3[TimeMO].time3 .. u8:decode" [Нельзя]")
							else
								sampSendChat(u8:decode"/fs MO LV даёт в " .. ini3[TimeMO].time3 .. u8:decode" [Можно]")
							end
						end
						ShowDialog(170)
					elseif dialogLine[list + 1] ==  '> MO HUD\t' .. (secondary_window_state.v and '{06940f}ON' or '{d10000}OFF') then
						cmd_MOhud()
						ShowDialog(170)
					elseif dialogLine[list + 1] == u8:decode'> Фиксация HUDa\t' .. (InterfacePositionMO and '{06940f}ON' or '{d10000}OFF') then
						InterfacePositionMO = not InterfacePositionMO
						inicfg.save(ini, directIni)
						ShowDialog(170)
					elseif dialogLine[list + 1] ==  u8:decode'> Сообщить о таймингах\t' then
						MONotifyWait:run()
						ShowDialog(170)
					elseif dialogLine[list + 1] == u8:decode'> Разница во времени с Samp-RP\t'  then
						Calibration()
						ShowDialog(170)
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Время успешно откалибровано", main_color)
					elseif dialogLine[list + 1] == u8:decode'> Статистика\t'  then
						ShowDialog(171)
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
					if tonumber(input) >= tonumber(1800) or tonumber(input) <= tonumber(0) then
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Невозможно. Диапозон от {FFFF00}1 {FFFFFF}до {FFFF00}1799", main_color)
						ShowDialog(23)
					else
						ini4[GhettoMateSettings].TimerNotifyLarek = input
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое время таймера составляет: {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyLarek .. u8:decode"{FFFFFF} секунд", main_color)
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					end
				else
					ShowDialog(23)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1005)
		if caption == u8:decode"Анимация" then
			if result then
				if button == 1 then
					if tonumber(input) > tonumber(45) or tonumber(input) < tonumber(0) then
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Невозможно. Диапозон от {FFFF00}0 {FFFFFF}до {FFFF00}45", main_color)
						ShowDialog(23)
					else
						ini4[GhettoMateSettings].IdAnimUgonyala = input
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новый id анимации: {FFFF00}" .. ini4[GhettoMateSettings].IdAnimUgonyala, main_color)
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					end
				else
					ShowDialog(23)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1006)
		if caption == u8:decode"Таймер" then
			if result then
				if button == 1 then
					if tonumber(input) >= tonumber(1800) or tonumber(input) <= tonumber(0) then
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Невозможно. Диапозон от {FFFF00}1 {FFFFFF}до {FFFF00}1799", main_color)
						ShowDialog(23)
					else
						ini4[GhettoMateSettings].TimerNotifyMO = input
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Новое время таймера составляет: {FFFF00}" .. ini4[GhettoMateSettings].TimerNotifyMO .. u8:decode"{FFFFFF} секунд", main_color)
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					end
				else
					ShowDialog(23)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1007)
		if caption == u8:decode"Количество ХП" then
			if result then
				if button == 1 then
					if tonumber(input) == tonumber(120) or tonumber(input) == tonumber(130) or tonumber(input) == tonumber(140) or tonumber(input) == tonumber(150) or tonumber(input) == tonumber(160) then
						ini4[GhettoMateSettings].Health = input
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Максимальное количество хп составляет: {FFFF00}" .. ini4[GhettoMateSettings].Health, main_color)
						inicfg.save(ini4, directIni4)
						ShowDialog(23)
					else
						sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Невозможно. Возможные значения: {FFFF00}120, 130, 140, 150 и 160", main_color)
						ShowDialog(23)
					end
				else
					ShowDialog(23)
				end
			end
		end
		local result, button, list, input = sampHasDialogRespond(1701)
		if caption == u8:decode"Статистика" then
			if result then
				if button == 1 then
					ShowDialog(171)
				else
					ShowDialog(170)
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
						if getCarDoorLockStatus(car) == 2 then
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
											ugcheckpoint = createCheckpoint(1, vehh[2],vehh[3],vehh[4],vehh[2],vehh[3],vehh[4], 1)
											search = true
											if ini4[GhettoMateSettings].NotifyUgonyala then
												if spam then
													if isDriver then
														sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Транспорт {FF0000}\"%s\" {FFFFFF}обнаружен! За рулем: {FF0000}%s", vehnames[modelid-399], driverNickname), main_color)
													else
														sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Транспорт {FF0000}\"%s\" {FFFFFF}обнаружен!", vehnames[modelid-399]), main_color)
													end
													if ini4[GhettoMateSettings].Sounds then
														soundManager.playSound("message_tip")
													end
													spam = false
												end
											end
											if marks then
												for i, mark in ipairs(marks) do
													removeBlip(mark)
												end
											end
											if ugcheckpoints then
												for i, ugcheckpoint in ipairs(ugcheckpoints) do
													deleteCheckpoint(ugcheckpoint)
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
									if spam then
										if notify then
											if isDriver then
												sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Новый транспорт {FF0000}\"%s\" {FFFFFF}обнаружен! За рулем: {FF0000}%s", vehnames[modelid-399], driverNickname), main_color)
											else
												sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Новый транспорт {FF0000}\"%s\" {FFFFFF}обнаружен!", vehnames[modelid-399]), main_color)
											end
											if ini4[GhettoMateSettings].Sounds then
												soundManager.playSound("message_tip")
											end
											spam = false
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
											ugcheckpoint = createCheckpoint(1, vehh[2],vehh[3],vehh[4],vehh[2],vehh[3],vehh[4], 1)
											if ini4[GhettoMateSettings].NotifyUgonyala then
												if spam then
													if isDriver then
														sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Открытый {FF0000}\"%s\" {FFFFFF}обнаружен! За рулем: {FF0000}%s", vehnames[modelid-399], driverNickname), main_color)
													else
														sampAddChatMessage(string.format(u8:decode" [GhettoMate] {FFFFFF}Открытый {FF0000}\"%s\" {FFFFFF}обнаружен!", vehnames[modelid-399]), main_color)
													end
													if ini4[GhettoMateSettings].Sounds then
														soundManager.playSound("message_tip")
													end
													spam = false
												end
											end
											if marks then
												for i, mark in ipairs(marks) do
													removeBlip(mark)
												end
											end
											if ugcheckpoints then
												for i, ugcheckpoint in ipairs(ugcheckpoints) do
													deleteCheckpoint(ugcheckpoint)
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
	main_window_state.v = not main_window_state.v
	if not main_window_state.v and not secondary_window_state.v then
		imgui.Process = false
	end
	if main_window_state.v then
		imgui.Process = true
	end
end

function cmd_MOhud(arg)
	secondary_window_state.v = not secondary_window_state.v
	if not main_window_state.v and not secondary_window_state.v then
		imgui.Process = false
	end
	if secondary_window_state.v then
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
function imgui.OnDrawFrame()
	if main_window_state.v then
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
	
	if secondary_window_state.v then
		if ini[GhettoMateConfig].X_MO == nil then
			ini[GhettoMateConfig].X_MO = 0
		end
		if ini[GhettoMateConfig].Y_MO == nil then
			ini[GhettoMateConfig].Y_MO = 0
		end
		if InterfacePositionMO == true then
			imgui.SetNextWindowPos(imgui.ImVec2(ini[GhettoMateConfig].X_MO, ini[GhettoMateConfig].Y_MO))
			inicfg.save(ini, directIni)
		end
		imgui.SetNextWindowSize(imgui.ImVec2(resX/8.5, resY/8.5))
		imgui.Begin("MO HUD", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
		local pos_MO = imgui.GetWindowPos()
		ini[GhettoMateConfig].X_MO = pos_MO.x
		ini[GhettoMateConfig].Y_MO = pos_MO.y
		inicfg.save(ini, directIni)
	
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
		
		imgui.TextColoredRGB(u8"1.  MO LS")
			imgui.SameLine((resX/5) / 3)
		imgui.TextColoredRGB(u8"" .. colorMO[1] .. ini3[TimeMO].time1)
		imgui.TextColoredRGB(u8"2.  MO SF")
			imgui.SameLine((resX/5) / 3)
		imgui.TextColoredRGB(u8""  .. colorMO[2] .. ini3[TimeMO].time2)	
		imgui.TextColoredRGB(u8"3.  MO LV")
			imgui.SameLine((resX/5) / 3)
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
end

function UseDrugsWaiting(DrugsCount)
	wait(1200)
	sampSendChat("/usedrugs " .. DrugsCount)
end

function MONotifyWaiting()
	if ini3[TimeMO].time1 ~= u8:decode"Неизвестно" then
		wait(1200)
		if ini3[SecondsMO].time1 - totalSeconds > 0 then
			sampSendChat(u8:decode"/fs MO LS даёт в " .. ini3[TimeMO].time1 .. u8:decode" [Нельзя]")
		else
			sampSendChat(u8:decode"/fs MO LS даёт в " .. ini3[TimeMO].time1 .. u8:decode" [Можно]")
		end
	end
	if ini3[TimeMO].time2 ~= u8:decode"Неизвестно" then
		wait(1200)
		if ini3[SecondsMO].time2 - totalSeconds > 0 then
			sampSendChat(u8:decode"/fs MO SF даёт в " .. ini3[TimeMO].time2 .. u8:decode" [Нельзя]")
		else
			sampSendChat(u8:decode"/fs MO SF даёт в " .. ini3[TimeMO].time2 .. u8:decode" [Можно]")
		end
	end
	if ini3[TimeMO].time3 ~= u8:decode"Неизвестно" then
		wait(1200)
		if ini3[SecondsMO].time3 - totalSeconds > 0 then
			sampSendChat(u8:decode"/fs MO LV даёт в " .. ini3[TimeMO].time3 .. u8:decode" [Нельзя]")
		else
			sampSendChat(u8:decode"/fs MO LV даёт в " .. ini3[TimeMO].time3 .. u8:decode" [Можно]")
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

function RefreshMO()
	if math.abs(totalSeconds - ini3[SecondsMO].time1) > oneHour then
		ini3[SecondsMO].time1 = 0
		ini3[TimeMO].time1 = u8:decode"Неизвестно"
		color[1] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[SecondsMO].time2) > oneHour then
		ini3[SecondsMO].time2 = 0
		ini3[TimeMO].time2 = u8:decode"Неизвестно"
		color[2] = "{808080}"
	end
	if math.abs(totalSeconds - ini3[SecondsMO].time3) > oneHour then
		ini3[SecondsMO].time3 = 0
		ini3[TimeMO].time3 = u8:decode"Неизвестно"
		color[3] = "{808080}"
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
	
	if int == 20 then 
		dialogLine, dialogTextToList = {}, {}
		dialogLine[#dialogLine + 1] = '  1. Larek\t'
		dialogLine[#dialogLine + 1] = '  2. MO\t'
		dialogLine[#dialogLine + 1] = '  3. AutoGetGuns\t' .. (GetGuns and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = '  4. Find\t' .. (Find and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = '  5. Ugonyala\t' .. (search and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'> Настройки\t'
		dialogLine[#dialogLine + 1] = u8:decode'> Помощь\t'
		
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
		dialogLine[#dialogLine + 1] = u8:decode'  2. Таймер уведомлений от Larek\t' .. ini4[GhettoMateSettings].TimerNotifyLarek
		dialogLine[#dialogLine + 1] = u8:decode'  3. Уведомления от Ugonyala\t' .. (ini4[GhettoMateSettings].NotifyUgonyala and '{06940f}ON' or '{d10000}OFF') 
		dialogLine[#dialogLine + 1] = u8:decode'  4. Анимация угона\t' .. (ini4[GhettoMateSettings].AnimUgonyala and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  5. Выбрать анимацию угона\t' .. ini4[GhettoMateSettings].IdAnimUgonyala
		dialogLine[#dialogLine + 1] = u8:decode'  6. Уведомления от Find\t' .. (ini4[GhettoMateSettings].NotifyFind and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  7. Максимальное количество ХП\t' .. ini4[GhettoMateSettings].Health
		dialogLine[#dialogLine + 1] = u8:decode'  8. Уведомления от Drugs\t' .. (ini4[GhettoMateSettings].NotifyDrugs and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'  9. Уведомления от AutoGetGuns\t' .. (ini4[GhettoMateSettings].NotifyAutoGetGuns and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode' 10. Уведомления от MO\t'  .. (ini4[GhettoMateSettings].NotifyMO and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode' 11. Таймер уведомлений от MO\t' .. ini4[GhettoMateSettings].TimerNotifyMO
		dialogLine[#dialogLine + 1] = u8:decode' 12. Звуки\t' .. (ini4[GhettoMateSettings].Sounds and '{06940f}ON' or '{d10000}OFF')				
		dialogLine[#dialogLine + 1] = ' 13. ' .. (script.update and u8:decode'{d10000}Обновить скрипт' or u8:decode'{06940f}Актуальная версия')
		
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
	
	if int == 26 then
		sampShowDialog(1006, u8:decode"Таймер", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
	end
	
	if int == 27 then
		sampShowDialog(1007, u8:decode"Количество ХП", dtext, u8:decode"Выбрать", u8:decode"Назад", 1)
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
		dialogLine[#dialogLine + 1] = u8:decode'> Larek HUD\t' .. (main_window_state.v and '{06940f}ON' or '{d10000}OFF')
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
	
	if int == 170 then
		dialogLine, dialogTextToList = {}, {}
		dialogLine[#dialogLine + 1] = '  1. MO LS\t' .. colorMO[1]  .. ini3[TimeMO].time1
		dialogLine[#dialogLine + 1] = '  2. MO SF\t' .. colorMO[2]  .. ini3[TimeMO].time2
		dialogLine[#dialogLine + 1] = '  3. MO LV\t' .. colorMO[3]  .. ini3[TimeMO].time3
		dialogLine[#dialogLine + 1] = '> MO HUD\t' .. (secondary_window_state.v and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'> Фиксация HUDa\t' .. (InterfacePositionMO and '{06940f}ON' or '{d10000}OFF')
		dialogLine[#dialogLine + 1] = u8:decode'> Сообщить о таймингах\t'
		dialogLine[#dialogLine + 1] = u8:decode'> Разница во времени с Samp-RP\t'
		dialogLine[#dialogLine + 1] = u8:decode'> Статистика\t'

		local text4 = ""
		for k,v in pairs(dialogLine) do
			text4 = text4..v.."\n"
		end
		sampShowDialog(1700, u8:decode'MO: Список', text4, u8:decode"Выбрать", u8:decode"Назад", 4)
	end
	
	if int == 171 then
		GhettoMateMO = string.format('GhettoMateMO-%s', my_name)
		ini2 = inicfg.load(GhettoMateMO, directIni2)
		sampShowDialog(1701, u8:decode'Статистика', u8:decode"Материалов привезено: \t" .. ini2[GhettoMateMO].mats .. u8:decode"\nФур украдено: \t" .. ini2[GhettoMateMO].cars, u8:decode"Выбрать", u8:decode"Выход", 4)
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
	
	if pickupId == 1818 then
		MOLS = true
	end
	if pickupId == 1817 or pickupId == 1820 or pickupID == 1822 or pickupId == 1029 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023  then
		MOLS = false
	end
	if pickupId == 1820 then
		MOSF = true
	end
	if pickupId == 1819 or pickupId == 1818 or pickupID == 1822 or pickupId == 1029 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023  then
		MOSF = false
	end
	if pickupId == 1822 then
		MOLV = true
	end
	if pickupId == 1821 or pickupId == 1820 or pickupID == 1818 or pickupId == 1029 or pickupId == 1039 or pickupId == 1037 or pickupId == 979 or pickupId == 977 or pickupId == 983 or pickupId == 1035 or pickupId == 987 or pickupId == 981 or pickupId == 985 or pickupId == 1033 or pickupId == 1031 or pickupId == 1019 or pickupId == 1025 or pickupId == 1021 or pickupId == 1023  then
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
				inicfg.save(ini3, directIni3)
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
	end

	if string.find(text, u8:decode"Заказ можно брать раз в 15 минут. Осталось .+:.+") then
		minutes, seconds = string.match(text, u8:decode"Заказ можно брать раз в 15 минут. Осталось (.+):(.+)")
		ugontimer = tonumber(minutes) * 60 + tonumber(seconds) + os.clock()
	end

	if string.find(text, u8:decode"Пригони нам тачку марки .+, и мы тебе хорошо заплатим.") then
		carname = string.match(text, u8:decode"Пригони нам тачку марки (.+), и мы тебе хорошо заплатим.")
		sampSendChat("/fc " .. carname)
	end

	if string.find(text, u8:decode"SMS: Это то что нам нужно, гони её на склад.") then
		stopSearch()
		if ini4[GhettoMateSettings].NotifyUgonyala then
			sampAddChatMessage(u8:decode" [GhettoMate] {FFFFFF}Метка установлена {FFFF00}" .. thiefPos, main_color)
		end
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
	if string.find(text, u8:decode"Недостаточно наркотиков") and DrugsCount > 0 then
		DrugsCount = DrugsCount - 1
		UseDrugsWait:run(DrugsCount)
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
			spam = true
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

function HexColor(color) --by Serhiy_Rubin
	return ("%06x"):format(bit.band(color, 0xFFFFFF))
end
