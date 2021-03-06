#!/usr/bin/lua
------------------------------------------------
-- This file is converter ip to country iso code
-- @author Jerryk <jerrykuku@qq.com>
------------------------------------------------

local _M = {}

-- Get country iso code with remark or host
-- Return String:iso_code
function _M.get_flag(remark, host)
    local nixio = require 'nixio'
    local json = require('cjson')
    local json_string =
        '[{"code":"AC","regx":["ð¦ð¨","AC","Ascension Island"]},{"code":"AD","regx":["å®éå°","ð¦ð©","AD","Andorra"]},{"code":"AE","regx":["é¿èé","ð¦ðª","AE","United Arab Emirates"]},{"code":"AF","regx":["é¿å¯æ±","ð¦ð«","AF","Afghanistan"]},{"code":"AG","regx":["å®æçåå·´å¸è¾¾","ð¦ð¬","AG","Antigua & Barbuda"]},{"code":"AI","regx":["å®å­æ","ð¦ð®","AI","Anguilla"]},{"code":"AL","regx":["é¿å°å·´å°¼äº","ð¦ð±","AL","Albania"]},{"code":"AM","regx":["äºç¾å°¼äº","ð¦ð²","AM","Armenia"]},{"code":"AO","regx":["å®å¥æ","ð¦ð´","AO","Angola"]},{"code":"AQ","regx":["åææ´²","ð¦ð¶","AQ","Antarctica"]},{"code":"AR","regx":["é¿æ ¹å»·","ð¦ð·","AR","Argentina"]},{"code":"AS","regx":["ç¾å±è¨æ©äº","ð¦ð¸","AS","American Samoa"]},{"code":"AT","regx":["å¥¥å°å©","ð¦ð¹","AT","Austria"]},{"code":"AU","regx":["æ¾³å¤§å©äº","ð¦ðº","AU","Australia"]},{"code":"AW","regx":["é¿é²å·´","ð¦ð¼","AW","Aruba"]},{"code":"AX","regx":["å¥¥å°ç¾¤å²","ð¦ð½","AX","Ãland Islands"]},{"code":"AZ","regx":["é¿å¡æç","ð¦ð¿","AZ","Azerbaijan"]},{"code":"BA","regx":["æ³¢é»","ð§ð¦","BA","Bosnia & Herzegovina"]},{"code":"BB","regx":["å·´å·´å¤æ¯","ð§ð§","BB","Barbados"]},{"code":"BD","regx":["å­å æå½","ð§ð©","BD","Bangladesh"]},{"code":"BE","regx":["æ¯å©æ¶","ð§ðª","BE","Belgium"]},{"code":"BF","regx":["å¸åºçº³æ³ç´¢","ð§ð«","BF","Burkina Faso"]},{"code":"BG","regx":["ä¿å å©äº","ð§ð¬","BG","Bulgaria"]},{"code":"BH","regx":["å·´æ","ð§ð­","BH","Bahrain"]},{"code":"BI","regx":["å¸éè¿ª","ð§ð®","BI","Burundi"]},{"code":"BJ","regx":["è´å®","ð§ð¯","BJ","Benin"]},{"code":"BL","regx":["å£å·´æ³°åç±³å²","ð§ð±","BL","St. BarthÃ©lemy"]},{"code":"BM","regx":["ç¾æå¤§","ð§ð²","BM","Bermuda"]},{"code":"BN","regx":["æè±","ð§ð³","BN","Brunei"]},{"code":"BO","regx":["ç»å©ç»´äº","ð§ð´","BO","Bolivia"]},{"code":"BQ","regx":["è·å°å åæ¯åº","ð§ð¶","BQ","Caribbean Netherlands"]},{"code":"BR","regx":["å·´è¥¿","ð§ð·","BR","Brazil"]},{"code":"BS","regx":["å·´åé©¬","ð§ð¸","BS","Bahamas"]},{"code":"BT","regx":["ä¸ä¸¹","ð§ð¹","BT","Bhutan"]},{"code":"BV","regx":["å¸é¦å²","ð§ð»","BV","Bouvet Island"]},{"code":"BW","regx":["åè¨ç¦çº³","ð§ð¼","BW","Botswana"]},{"code":"BY","regx":["ç½ä¿ç½æ¯","ð§ð¾","BY","Belarus"]},{"code":"BZ","regx":["ä¼¯å©å¹","ð§ð¿","BZ","Belize"]},{"code":"CA","regx":["å æ¿å¤§","ð¨ð¦","CA","Canada"]},{"code":"CC","regx":["ç§ç§æ¯ç¾¤å²","ð¨ð¨","CC","Cocos (Keeling) Islands"]},{"code":"CD","regx":["åæï¼éï¼","ð¨ð©","CD","Congo - Kinshasa"]},{"code":"CF","regx":["ä¸­é","ð¨ð«","CF","Central African Republic"]},{"code":"CG","regx":["åæï¼å¸ï¼","ð¨ð¬","CG","Congo - Brazzaville"]},{"code":"CH","regx":["çå£«","ð¨ð­","CH","Switzerland"]},{"code":"CI","regx":["ç§ç¹è¿ªç¦","ð¨ð®","CI","CÃ´te dâIvoire"]},{"code":"CK","regx":["åºåç¾¤å²","ð¨ð°","CK","Cook Islands"]},{"code":"CL","regx":["æºå©","ð¨ð±","CL","Chile"]},{"code":"CM","regx":["åéº¦é","ð¨ð²","CM","Cameroon"]},{"code":"CN","regx":["ä¸­å½ï¼\r\nå§å°","ð¨ð³","CN","China"]},{"code":"CO","regx":["å¥ä¼¦æ¯äº","ð¨ð´","CO","Colombia"]},{"code":"CP","regx":["ð¨ðµ","CP","Clipperton Island"]},{"code":"CR","regx":["å¥æ¯è¾¾é»å ","ð¨ð·","CR","Costa Rica"]},{"code":"CU","regx":["å¤å·´","ð¨ðº","CU","Cuba"]},{"code":"CV","regx":["ä½å¾è§","ð¨ð»","CV","Cape Verde"]},{"code":"CW","regx":["åºæç´¢","ð¨ð¼","CW","CuraÃ§ao"]},{"code":"CX","regx":["å£è¯å²","ð¨ð½","CX","Christmas Island"]},{"code":"CY","regx":["å¡æµ¦è·¯æ¯","ð¨ð¾","CY","Cyprus"]},{"code":"CZ","regx":["æ·å","ð¨ð¿","CZ","Czechia"]},{"code":"DE","regx":["å¾·å½","ð©ðª","DE","Germany"]},{"code":"DG","regx":["ð©ð¬","DG","Diego Garcia"]},{"code":"DJ","regx":["åå¸æ","ð©ð¯","DJ","Djibouti"]},{"code":"DK","regx":["ä¸¹éº¦","ð©ð°","DK","Denmark"]},{"code":"DM","regx":["å¤ç±³å°¼å","ð©ð²","DM","Dominica"]},{"code":"DO","regx":["å¤ç±³å°¼å ","ð©ð´","DO","Dominican Republic"]},{"code":"DZ","regx":["é¿å°åå©äº","ð©ð¿","DZ","Algeria"]},{"code":"EA","regx":["ðªð¦","EA","Ceuta & Melilla"]},{"code":"EC","regx":["åçå¤å°","ðªð¨","EC","Ecuador"]},{"code":"EE","regx":["ç±æ²å°¼äº","ðªðª","EE","Estonia"]},{"code":"EG","regx":["åå","ðªð¬","EG","Egypt"]},{"code":"EH","regx":["è¥¿æåæ","ðªð­","EH","Western Sahara"]},{"code":"ER","regx":["åç«ç¹éäº","ðªð·","ER","Eritrea"]},{"code":"ES","regx":["è¥¿ç­ç","ðªð¸","ES","Spain"]},{"code":"ET","regx":["åå¡ä¿æ¯äº","ðªð¹","ET","Ethiopia"]},{"code":"EU","regx":["ðªðº","EU","European Union"]},{"code":"FI","regx":["è¬å°","ð«ð®","FI","Finland"]},{"code":"FJ","regx":["ææµç¾¤å²","ð«ð¯","FJ","Fiji"]},{"code":"FK","regx":["é©¬å°ç»´çº³æ¯ç¾¤å²ï¼ç¦åå°ï¼","ð«ð°","FK","Falkland Islands"]},{"code":"FM","regx":["å¯åç½å°¼è¥¿äºèé¦","ð«ð²","FM","Micronesia"]},{"code":"FO","regx":["æ³ç½ç¾¤å²","ð«ð´","FO","Faroe Islands"]},{"code":"FR","regx":["æ³å½","ð«ð·","FR","France"]},{"code":"GA","regx":["å è¬","ð¬ð¦","GA","Gabon"]},{"code":"GB","regx":["è±å½","ð¬ð§","GB","United Kingdom"]},{"code":"GD","regx":["æ ¼æçº³è¾¾","ð¬ð©","GD","Grenada"]},{"code":"GE","regx":["æ ¼é²åäº","ð¬ðª","GE","Georgia"]},{"code":"GF","regx":["æ³å±å­äºé£","ð¬ð«","GF","French Guiana"]},{"code":"GG","regx":["æ ¹è¥¿å²","ð¬ð¬","GG","Guernsey"]},{"code":"GH","regx":["å çº³","ð¬ð­","GH","Ghana"]},{"code":"GI","regx":["ç´å¸ç½é","ð¬ð®","GI","Gibraltar"]},{"code":"GL","regx":["æ ¼éµå°","ð¬ð±","GL","Greenland"]},{"code":"GM","regx":["åæ¯äº","ð¬ð²","GM","Gambia"]},{"code":"GN","regx":["å åäº","ð¬ð³","GN","Guinea"]},{"code":"GP","regx":["çå¾·ç½æ®","ð¬ðµ","GP","Guadeloupe"]},{"code":"GQ","regx":["èµ¤éå åäº","ð¬ð¶","GQ","Equatorial Guinea"]},{"code":"GR","regx":["å¸è","ð¬ð·","GR","Greece"]},{"code":"GS","regx":["åä¹æ²»äºå²ååæ¡å¨å¥ç¾¤å²","ð¬ð¸","GS","South Georgia & South Sandwich Islands"]},{"code":"GT","regx":["å±å°é©¬æ","ð¬ð¹","GT","Guatemala"]},{"code":"GU","regx":["å³å²","ð¬ðº","GU","Guam"]},{"code":"GW","regx":["å åäºæ¯ç»","ð¬ð¼","GW","Guinea-Bissau"]},{"code":"GY","regx":["å­äºé£","ð¬ð¾","GY","Guyana"]},{"code":"HK","regx":["é¦æ¸¯","ð­ð°","HK","Hong Kong SAR China"]},{"code":"HM","regx":["èµ«å¾·å²åéº¦ååçº³ç¾¤å²","ð­ð²","HM","Heard & McDonald Islands"]},{"code":"HN","regx":["æ´ªé½ææ¯","ð­ð³","HN","Honduras"]},{"code":"HR","regx":["åç½å°äº","ð­ð·","HR","Croatia"]},{"code":"HT","regx":["æµ·å°","ð­ð¹","HT","Haiti"]},{"code":"HU","regx":["åçå©","ð­ðº","HU","Hungary"]},{"code":"IC","regx":["ð®ð¨","IC","Canary Islands"]},{"code":"ID","regx":["å°å°¼","ð®ð©","ID","Indonesia"]},{"code":"IE","regx":["ç±å°å°","ð®ðª","IE","Ireland"]},{"code":"IL","regx":["ä»¥è²å","ð®ð±","IL","Israel"]},{"code":"IM","regx":["é©¬æ©å²","ð®ð²","IM","Isle of Man"]},{"code":"IN","regx":["å°åº¦","ð®ð³","IN","India"]},{"code":"IO","regx":["è±å±å°åº¦æ´é¢å°","ð®ð´","IO","British Indian Ocean Territory"]},{"code":"IQ","regx":["ä¼æå","ð®ð¶","IQ","Iraq"]},{"code":"IR","regx":["ä¼æ","ð®ð·","IR","Iran"]},{"code":"IS","regx":["å°å²","ð®ð¸","IS","Iceland"]},{"code":"IT","regx":["æå¤§å©","ð®ð¹","IT","Italy"]},{"code":"JE","regx":["æ³½è¥¿å²","ð¯ðª","JE","Jersey"]},{"code":"JM","regx":["çä¹°å ","ð¯ð²","JM","Jamaica"]},{"code":"JO","regx":["çº¦æ¦","ð¯ð´","JO","Jordan"]},{"code":"JP","regx":["æ¥æ¬","ð¯ðµ","JP","Japan"]},{"code":"KE","regx":["è¯å°¼äº","ð°ðª","KE","Kenya"]},{"code":"KG","regx":["åå°åæ¯æ¯å¦","ð°ð¬","KG","Kyrgyzstan"]},{"code":"KH","regx":["æ¬åå¯¨","ð°ð­","KH","Cambodia"]},{"code":"KI","regx":["åºéå·´æ¯","ð°ð®","KI","Kiribati"]},{"code":"KM","regx":["ç§æ©ç½","ð°ð²","KM","Comoros"]},{"code":"KN","regx":["å£åºè¨åå°¼ç»´æ¯","ð°ð³","KN","St. Kitts & Nevis"]},{"code":"KP","regx":["æé²ï¼\r\nåæé²","ð°ðµ","KP","North Korea"]},{"code":"KR","regx":["é©å½","ð°ð·","KR","South Korea"]},{"code":"KW","regx":["ç§å¨ç¹","ð°ð¼","KW","Kuwait"]},{"code":"KY","regx":["å¼æ¼ç¾¤å²","ð°ð¾","KY","Cayman Islands"]},{"code":"KZ","regx":["åè¨åæ¯å¦","ð°ð¿","KZ","Kazakhstan"]},{"code":"LA","regx":["èæ","ð±ð¦","LA","Laos"]},{"code":"LB","regx":["é»å·´å«©","ð±ð§","LB","Lebanon"]},{"code":"LC","regx":["å£å¢è¥¿äº","ð±ð¨","LC","St. Lucia"]},{"code":"LI","regx":["åæ¯æ¦å£«ç»","ð±ð®","LI","Liechtenstein"]},{"code":"LK","regx":["æ¯éå°å¡","ð±ð°","LK","Sri Lanka"]},{"code":"LR","regx":["å©æ¯éäº","ð±ð·","LR","Liberia"]},{"code":"LS","regx":["è±ç´¢æ","ð±ð¸","LS","Lesotho"]},{"code":"LT","regx":["ç«é¶å®","ð±ð¹","LT","Lithuania"]},{"code":"LU","regx":["å¢æ£®å ¡","ð±ðº","LU","Luxembourg"]},{"code":"LV","regx":["æè±ç»´äº","ð±ð»","LV","Latvia"]},{"code":"LY","regx":["å©æ¯äº","ð±ð¾","LY","Libya"]},{"code":"MA","regx":["æ©æ´å¥","ð²ð¦","MA","Morocco"]},{"code":"MC","regx":["æ©çº³å¥","ð²ð¨","MC","Monaco"]},{"code":"MD","regx":["æ©å°å¤ç¦","ð²ð©","MD","Moldova"]},{"code":"ME","regx":["é»å±±","ð²ðª","ME","Montenegro"]},{"code":"MF","regx":["æ³å±å£é©¬ä¸","ð²ð«","MF","St. Martin"]},{"code":"MG","regx":["é©¬è¾¾å æ¯å ","ð²ð¬","MG","Madagascar"]},{"code":"MH","regx":["é©¬ç»å°ç¾¤å²","ð²ð­","MH","Marshall Islands"]},{"code":"MK","regx":["é©¬å¶é¡¿","ð²ð°","MK","Macedonia"]},{"code":"ML","regx":["é©¬é","ð²ð±","ML","Mali"]},{"code":"MM","regx":["ç¼ç¸","ð²ð²","MM","Myanmar (Burma)"]},{"code":"MN","regx":["èå¤å½ï¼èå¤","ð²ð³","MN","Mongolia"]},{"code":"MO","regx":["æ¾³é¨","ð²ð´","MO","Macau SAR China"]},{"code":"MP","regx":["åé©¬éäºçº³ç¾¤å²","ð²ðµ","MP","Northern Mariana Islands"]},{"code":"MQ","regx":["é©¬æå°¼å","ð²ð¶","MQ","Martinique"]},{"code":"MR","regx":["æ¯éå¡å°¼äº","ð²ð·","MR","Mauritania"]},{"code":"MS","regx":["èå¡æç¹å²","ð²ð¸","MS","Montserrat"]},{"code":"MT","regx":["é©¬è³ä»","ð²ð¹","MT","Malta"]},{"code":"MU","regx":["æ¯éæ±æ¯","ð²ðº","MU","Mauritius"]},{"code":"MV","regx":["é©¬å°ä»£å¤«","ð²ð»","MV","Maldives"]},{"code":"MW","regx":["é©¬æç»´","ð²ð¼","MW","Malawi"]},{"code":"MX","regx":["å¢¨è¥¿å¥","ð²ð½","MX","Mexico"]},{"code":"MY","regx":["é©¬æ¥è¥¿äº","ð²ð¾","MY","Malaysia"]},{"code":"MZ","regx":["è«æ¡æ¯å","ð²ð¿","MZ","Mozambique"]},{"code":"NA","regx":["çº³ç±³æ¯äº","ð³ð¦","NA","Namibia"]},{"code":"NC","regx":["æ°åéå¤å°¼äº","ð³ð¨","NC","New Caledonia"]},{"code":"NE","regx":["å°¼æ¥å°","ð³ðª","NE","Niger"]},{"code":"NF","regx":["è¯ºç¦åå²","ð³ð«","NF","Norfolk Island"]},{"code":"NG","regx":["å°¼æ¥å©äº","ð³ð¬","NG","Nigeria"]},{"code":"NI","regx":["å°¼å æç","ð³ð®","NI","Nicaragua"]},{"code":"NL","regx":["è·å°","ð³ð±","NL","Netherlands"]},{"code":"NO","regx":["æªå¨","ð³ð´","NO","Norway"]},{"code":"NP","regx":["å°¼æ³å°","ð³ðµ","NP","Nepal"]},{"code":"NR","regx":["çé²","ð³ð·","NR","Nauru"]},{"code":"NU","regx":["çº½å","ð³ðº","NU","Niue"]},{"code":"NZ","regx":["æ°è¥¿å°","ð³ð¿","NZ","New Zealand"]},{"code":"OM","regx":["é¿æ¼","ð´ð²","OM","Oman"]},{"code":"PA","regx":["å·´æ¿é©¬","ðµð¦","PA","Panama"]},{"code":"PE","regx":["ç§é²","ðµðª","PE","Peru"]},{"code":"PF","regx":["æ³å±æ³¢å©å°¼è¥¿äº","ðµð«","PF","French Polynesia"]},{"code":"PG","regx":["å·´å¸äºæ°å åäº","ðµð¬","PG","Papua New Guinea"]},{"code":"PH","regx":["è²å¾å®¾","ðµð­","PH","Philippines"]},{"code":"PK","regx":["å·´åºæ¯å¦","ðµð°","PK","Pakistan"]},{"code":"PL","regx":["æ³¢å°","ðµð±","PL","Poland"]},{"code":"PM","regx":["å£ç®åå°åå¯åé","ðµð²","PM","St. Pierre & Miquelon"]},{"code":"PN","regx":["ç®ç¹å¯æ©ç¾¤å²","ðµð³","PN","Pitcairn Islands"]},{"code":"PR","regx":["æ³¢å¤é»å","ðµð·","PR","Puerto Rico"]},{"code":"PS","regx":["å·´åæ¯å¦","ðµð¸","PS","Palestinian Territories"]},{"code":"PT","regx":["è¡èç","ðµð¹","PT","Portugal"]},{"code":"PW","regx":["å¸å³","ðµð¼","PW","Palau"]},{"code":"PY","regx":["å·´æå­","ðµð¾","PY","Paraguay"]},{"code":"QA","regx":["å¡å¡å°","ð¶ð¦","QA","Qatar"]},{"code":"RE","regx":["çå°¼æ±ª","ð·ðª","RE","RÃ©union"]},{"code":"RO","regx":["ç½é©¬å°¼äº","ð·ð´","RO","Romania"]},{"code":"RS","regx":["å¡å°ç»´äº","ð·ð¸","RS","Serbia"]},{"code":"RU","regx":["ä¿ç½æ¯","ð·ðº","RU","Russia"]},{"code":"RW","regx":["å¢æºè¾¾","ð·ð¼","RW","Rwanda"]},{"code":"SA","regx":["æ²ç¹é¿æä¼¯","ð¸ð¦","SA","Saudi Arabia"]},{"code":"SB","regx":["æç½é¨ç¾¤å²","ð¸ð§","SB","Solomon Islands"]},{"code":"SC","regx":["å¡èå°","ð¸ð¨","SC","Seychelles"]},{"code":"SD","regx":["èä¸¹","ð¸ð©","SD","Sudan"]},{"code":"SE","regx":["çå¸","ð¸ðª","SE","Sweden"]},{"code":"SG","regx":["æ°å å¡","ð¸ð¬","SG","Singapore"]},{"code":"SH","regx":["å£èµ«åæ¿","ð¸ð­","SH","St. Helena"]},{"code":"SI","regx":["æ¯æ´æå°¼äº","ð¸ð®","SI","Slovenia"]},{"code":"SJ","regx":["æ¯ç¦å°å·´ç¾¤å²åæ¬é©¬å»¶å²","ð¸ð¯","SJ","Svalbard & Jan Mayen"]},{"code":"SK","regx":["æ¯æ´ä¼å","ð¸ð°","SK","Slovakia"]},{"code":"SL","regx":["å¡æå©æ","ð¸ð±","SL","Sierra Leone"]},{"code":"SM","regx":["å£é©¬åè¯º","ð¸ð²","SM","San Marino"]},{"code":"SN","regx":["å¡åå å°","ð¸ð³","SN","Senegal"]},{"code":"SO","regx":["ç´¢é©¬é","ð¸ð´","SO","Somalia"]},{"code":"SR","regx":["èéå","ð¸ð·","SR","Suriname"]},{"code":"SS","regx":["åèä¸¹","ð¸ð¸","SS","South Sudan"]},{"code":"ST","regx":["å£å¤ç¾åæ®æè¥¿æ¯","ð¸ð¹","ST","SÃ£o TomÃ© & PrÃ­ncipe"]},{"code":"SV","regx":["è¨å°ç¦å¤","ð¸ð»","SV","El Salvador"]},{"code":"SX","regx":["è·å±å£é©¬ä¸","ð¸ð½","SX","Sint Maarten"]},{"code":"SY","regx":["åå©äº","ð¸ð¾","SY","Syria"]},{"code":"SZ","regx":["æ¯å¨å£«å°","ð¸ð¿","SZ","Swaziland"]},{"code":"TA","regx":["ð¹ð¦","TA","Tristan da Cunha"]},{"code":"TC","regx":["ç¹åæ¯åå¯ç§æ¯ç¾¤å²","ð¹ð¨","TC","Turks & Caicos Islands"]},{"code":"TD","regx":["ä¹å¾","ð¹ð©","TD","Chad"]},{"code":"TF","regx":["æ³å±åé¨é¢å°","ð¹ð«","TF","French Southern Territories"]},{"code":"TG","regx":["å¤å¥","ð¹ð¬","TG","Togo"]},{"code":"TH","regx":["æ³°å½","ð¹ð­","TH","Thailand"]},{"code":"TJ","regx":["å¡ååæ¯å¦","ð¹ð¯","TJ","Tajikistan"]},{"code":"TK","regx":["æåå³","ð¹ð°","TK","Tokelau"]},{"code":"TL","regx":["ä¸å¸æ±¶","ð¹ð±","TL","Timor-Leste"]},{"code":"TM","regx":["ååºæ¼æ¯å¦","ð¹ð²","TM","Turkmenistan"]},{"code":"TN","regx":["çªå°¼æ¯","ð¹ð³","TN","Tunisia"]},{"code":"TO","regx":["æ±¤å ","ð¹ð´","TO","Tonga"]},{"code":"TR","regx":["åè³å¶","ð¹ð·","TR","Turkey"]},{"code":"TT","regx":["ç¹ç«å°¼è¾¾åå¤å·´å¥","ð¹ð¹","TT","Trinidad & Tobago"]},{"code":"TV","regx":["å¾ç¦å¢","ð¹ð»","TV","Tuvalu"]},{"code":"TW","regx":["å°æ¹¾","ð¹ð¼","TW","Taiwan"]},{"code":"TZ","regx":["å¦æ¡å°¼äº","ð¹ð¿","TZ","Tanzania"]},{"code":"UA","regx":["ä¹åå°","ðºð¦","UA","Ukraine"]},{"code":"UG","regx":["ä¹å¹²è¾¾","ðºð¬","UG","Uganda"]},{"code":"UM","regx":["ç¾å½æ¬åå¤å°å²å±¿","ðºð²","UM","U.S. Outlying Islands"]},{"code":"UN","regx":["ðºð³","UN","United Nations"]},{"code":"US","regx":["ç¾å½", "æ´æç¶","èå å¥","è¾¾ææ¯","ðºð¸","US","United States"]},{"code":"UY","regx":["ä¹æå­","ðºð¾","UY","Uruguay"]},{"code":"UZ","regx":["ä¹å¹å«åæ¯å¦","ðºð¿","UZ","Uzbekistan"]},{"code":"VA","regx":["æ¢µèå","ð»ð¦","VA","Vatican City"]},{"code":"VC","regx":["å£ææ£®ç¹åæ ¼æçº³ä¸æ¯","ð»ð¨","VC","St. Vincent & Grenadines"]},{"code":"VE","regx":["å§åçæ","ð»ðª","VE","Venezuela"]},{"code":"VG","regx":["è±å±ç»´å°äº¬ç¾¤å²","ð»ð¬","VG","British Virgin Islands"]},{"code":"VI","regx":["ç¾å±ç»´å°äº¬ç¾¤å²","ð»ð®","VI","U.S. Virgin Islands"]},{"code":"VN","regx":["è¶å","ð»ð³","VN","Vietnam"]},{"code":"VU","regx":["ç¦åªé¿å¾","ð»ðº","VU","Vanuatu"]},{"code":"WF","regx":["ç¦å©æ¯åå¯å¾çº³","ð¼ð«","WF","Wallis & Futuna"]},{"code":"WS","regx":["è¨æ©äº","ð¼ð¸","WS","Samoa"]},{"code":"XK","regx":["ð½ð°","XK","Kosovo"]},{"code":"YE","regx":["ä¹é¨","ð¾ðª","YE","Yemen"]},{"code":"YT","regx":["é©¬çº¦ç¹","ð¾ð¹","YT","Mayotte"]},{"code":"ZA","regx":["åé","ð¿ð¦","ZA","South Africa"]},{"code":"ZM","regx":["èµæ¯äº","ð¿ð²","ZM","Zambia"]},{"code":"ZW","regx":["æ´¥å·´å¸é¦","ð¿ð¼","ZW","Zimbabwe"]}]'

    local search_table = json.decode(json_string)

    local iso_code = nil
    local delete_table = {'%b[]', 'networks', 'test', 'game', 'gaming', 'tls', 'iepl', 'aead', 'hgc', 'hkbn', 'netflix', 'disney', 'hulu', 'hinet','Sb','az','aws','cn'}
    if (remark ~= nil) then
        -- è¿æ»¤
        remark = string.lower(remark)
        for i, v in pairs(delete_table) do
            remark = string.gsub(remark, v, '')
        end

        for i, v in pairs(search_table) do
            for s, t in pairs(v.regx) do
                if (string.find(remark, string.lower(t)) ~= nil) then
                    iso_code = string.lower(v.code)
                    break
                end
            end
        end
    end

    if (iso_code == nil) then
        if (host ~= '') then
            local ret = nixio.getaddrinfo(_M.trim(host), 'any')
            if (ret == nil) then
                iso_code = 'un'
            else
                local hostip = ret[1].address
                local status, code = pcall(_M.get_iso, hostip)
                if (status) then
                    iso_code = code
                else
                    iso_code = 'un'
                end
            end
        else
            iso_code = 'un'
        end
    end
    return string.gsub(iso_code, '\n', '')
end

function _M.get_iso(ip)
    local mm = require 'maxminddb'
    local db = mm.open('/usr/share/vssr/GeoLite2-Country.mmdb')
    local res = db:lookup(ip)
    return string.lower(res:get('country', 'iso_code'))
end

function _M.get_cname(ip)
    local mm = require 'maxminddb'
    local db = mm.open('/usr/share/vssr/GeoLite2-Country.mmdb')
    local res = db:lookup(ip)
    return string.lower(res:get('country', 'names', 'zh-CN'))
end

-- Get status of conncet to any site with host and port
-- Return String:true or nil
function _M.check_site(host, port)
    local nixio = require 'nixio'
    local socket = nixio.socket('inet', 'stream')
    socket:setopt('socket', 'rcvtimeo', 2)
    socket:setopt('socket', 'sndtimeo', 2)
    local ret = socket:connect(host, port)
    socket:close()
    return ret
end

function _M.trim(text)
    if not text or text == '' then
        return ''
    end
    return (string.gsub(text, '^%s*(.-)%s*$', '%1'))
end

function _M.wget(url)
    local sys = require 'luci.sys'
    local stdout =
        sys.exec(
        'wget-ssl -q --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36" --no-check-certificate -t 3 -T 10 -O- "' .. url .. '"'
    )
    return _M.trim(stdout)
end

return _M
