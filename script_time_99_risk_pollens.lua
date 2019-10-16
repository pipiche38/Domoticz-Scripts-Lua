-- name : script_time_pollens.lua
-- auteur : Hawk
-- date de création : 07/04/2019
-- Date de mise à jour : --
-- Principe : Via l'api de pollens.fr, connaitre le niveau de risque et afficher les pollens à risque élevé
-- http://easydomoticz.com/forum/viewtopic.php?

--------------------------------------------
------------ Variables à éditer ------------
-------------------------------------------- 
local nom_script = "Pollens"
local version = "0.1"
local debugging = false			-- true pour voir les logs dans la console log Dz ou false pour ne pas les voir
local dev_indice_alert = "Alerte Pollens"		-- renseigner le nom du device alert pollution associé si souhaité, sinon nil (dummy - alert)
local dev_pollens_moyen = "Pollens risque moyen"    	-- renseigner le nom du device pollens risque moyen associé si souhaité, sinon nil (type text)
local dev_pollens_dominant = "Pollens risque élevé"		-- renseigner le nom du device pollens risque élevé associé si souhaité, sinon nil (type text)
local send_notification = 1		-- 0: aucune notification, 1: toutes, 2: (risque faible), 3: (risque moyen), 4: (risque élévé), 5: (risque très élevé)
local syst_notification = "telegram"

local departement = 38      		-- renseigner le numéro du département dont vous souhaitez remonter les informations de pollution
--------------------------------------------
----------- Fin variables à éditer ---------
-------------------------------------------- 

--------------------------------------------
---------------- Fonctions -----------------
-------------------------------------------- 
json = (loadfile "/var/lib/domoticz/scripts/lua/JSON.lua")()  -- For Linux
-- json = (loadfile "D:\\domoticz\\scripts\\lua\\json.lua")()  -- For Windows
function voir_les_logs (s, debugging) -- nécessite la variable local debugging
    if (debugging) then 
		if s ~= nil then
        print (s)
		else
		print ("aucune valeur affichable")
		end
    end
end
--------------------------------------------
-------------- Fin Fonctions ---------------
--------------------------------------------

commandArray = {}
time = os.date("*t")
if ((time.min-2) % 30) == 0 then -- toutes les xx minutes en commençant par xx:02
	voir_les_logs("=========== ".. nom_script .." (v".. version ..") ===========",debugging)    
    if dev_indice_alert then
        dz_indice_alert = otherdevices_idx[dev_indice_alert]
        if dz_indice_alert then voir_les_logs("--- --- --- ".. dev_indice_alert .." idx : ".. dz_indice_alert,debugging) end
    end
    if dev_pollens_dominant then
        dz_pollens_dominant = otherdevices_idx[dev_pollens_dominant]
        if dz_pollens_dominant then voir_les_logs("--- --- --- ".. dev_pollens_dominant .." idx : ".. dz_pollens_dominant,debugging) end
    end
    if dev_pollens_moyen then
        dz_pollens_moyen = otherdevices_idx[dev_pollens_moyen]
        if dz_pollens_moyen then voir_les_logs("--- --- --- ".. dev_pollens_moyen .." idx : ".. dz_pollens_moyen,debugging) end
    end
    voir_les_logs('--- --- --- /usr/bin/curl -m8 "https://www.pollens.fr/risks/thea/counties/'.. departement ..'"',debugging)
	local config=assert(io.popen('/usr/bin/curl -m8 "https://www.pollens.fr/risks/thea/counties/'.. departement ..'"'))
    local blocjson = config:read('*all')
	voir_les_logs(blocjson,debugging)
	config:close()

	local jsonValeur = json:decode(blocjson)
	
	if jsonValeur then
	    -- mise à jour device dev_pollens_dominant avec pollens concernés par risque élevé ou supérieur
	    local pollenHaut =""
	    local pollenMoyen =""
	    for i = 1 , 19 do 
	        risk = jsonValeur.risks[i]
	        voir_les_logs("##"..jsonValeur.risks[i].pollenName.."--->"..jsonValeur.risks[i].level,debugging)
	        if risk.level == 3 then 
	            pollenMoyen = risk.pollenName.." "..pollenMoyen 
	            elseif risk.level >= 4 then 
	                pollenHaut = risk.pollenName.." "..pollenHaut
	        end    
        end
        voir_les_logs("pollens risque élevé (>=4) : "..pollenHaut,debugging)
        voir_les_logs("pollens risque moyen (=3) : "..pollenMoyen,debugging)
        if pollenHaut =="" then pollenHaut = "aucun" end
        if pollenMoyen =="" then pollenMoyen = "aucun" end
        if dz_pollens_dominant ~= nil and otherdevices[dev_pollens_dominant] ~= pollenHaut then
            commandArray[#commandArray+1] = {['UpdateDevice'] = dz_pollens_dominant..'|0|'..pollenHaut}
        end
	    if dz_pollens_moyen ~= nil and otherdevices[dev_pollens_moyen] ~= pollenMoyen then
            commandArray[#commandArray+1] = {['UpdateDevice'] = dz_pollens_moyen..'|0|'..pollenMoyen}
        end
    else
        print('la requete Json ne retourne aucun résultat exploitable')
    end    
		
    --Mise à jour du device dev_indice_alerte si il existe	
		local riskLevel = jsonValeur.riskLevel
		if dz_indice_alert ~= nil then	
			if tonumber(riskLevel) == 0 and otherdevices[dev_indice_alert] ~= "Risque nul" then -- niveau 0
				commandArray[#commandArray+1] = {['UpdateDevice'] = dz_indice_alert..'|1|Risque nul'}
				if send_notification > 0 and send_notification < 2 then
			    	commandArray[#commandArray+1] = {['SendNotification'] = 'Alerte Pollens#Risque nul!####'..syst_notification..'' }
				end
				voir_les_logs("--- --- --- Risque nul --- --- ---",debugging)
				
			elseif tonumber(riskLevel) == 1 and otherdevices[dev_indice_alert] ~= "Risque très faible" then -- niveau 1
				commandArray[#commandArray+1] = {['UpdateDevice'] = dz_indice_alert..'|1|Risque très faible'}
				if send_notification > 0 and send_notification < 2 then
			    	commandArray[#commandArray+1] = {['SendNotification'] = 'Alerte Pollens#Pollens: Risque très faible!####'..syst_notification..'' }
				end
				voir_les_logs("--- --- --- Risque très faible --- --- ---",debugging)

		    elseif tonumber(riskLevel) == 2 and otherdevices[dev_indice_alert] ~= "Risque faible"  then -- niveau 2
				commandArray[#commandArray+1] = {['UpdateDevice'] = dz_indice_alert..'|2|Risque faible'}
				if send_notification > 0 and send_notification < 3 then
			    	commandArray[#commandArray+1] = {['SendNotification'] = 'Alerte Pollens#Pollens: Risque Faible!####'..syst_notification..'' }
				end
				voir_les_logs("--- --- --- Risque faible --- --- ---",debugging)   

			elseif tonumber(riskLevel) == 3 and otherdevices[dev_indice_alert] ~= "Risque moyen"  then -- niveau 3
				commandArray[#commandArray+1] = {['UpdateDevice'] = dz_indice_alert..'|3|Risque moyen'}
				if send_notification > 0 and send_notification < 4 then
			    	commandArray[#commandArray+1] = {['SendNotification'] = 'Alerte Pollens#Pollens: Risque moyen!####'..syst_notification..'' }
				end
				voir_les_logs("--- --- --- Risque moyen --- --- ---",debugging)      

			elseif tonumber(riskLevel) == 4 and otherdevices[dev_indice_alert] ~= "Risque élevé" then -- niveau 4
				commandArray[#commandArray+1] = {['UpdateDevice'] = dz_indice_alert..'|4|Risque élevé'}
				if send_notification > 0 and send_notification < 5 then
			    	commandArray[#commandArray+1] = {['SendNotification'] = 'Alerte Pollens#Pollens: Risque élevé!####'..syst_notification ..''}
				end
				voir_les_logs("--- --- --- Risque élevé --- --- ---",debugging)
			elseif tonumber(riskLevel) == 5 and otherdevices[dev_indice_alert] ~= "Risque très élevé" then -- niveau 5
				commandArray[#commandArray+1] = {['UpdateDevice'] = dz_indice_alert..'|4|Risque très élevé'}
				if send_notification > 0 and send_notification < 6 then
			    	commandArray[#commandArray+1] = {['SendNotification'] = 'Alerte Pollens#Pollens: Risque très élevé!####'..syst_notification ..''}
				end	
				voir_les_logs("--- --- --- Risque très élévé --- --- ---",debugging)
			else
				voir_les_logs("niveau non defini")
			end
		end	
	
	if debugging == true then --affichage des informations disponibles en mod debugging
    	countyName = jsonValeur.countyName
	    riskLevel = jsonValeur.riskLevel
	    if countyName then voir_les_logs("--- --- --- countyName : ".. countyName .." --- --- ---",debugging) end
	    if riskLevel then voir_les_logs("--- --- --- riskLevel : ".. riskLevel .." --- --- ---",debugging) end
	end --if debugging
	voir_les_logs("========= Fin ".. nom_script .." (v".. version ..") =========",debugging)
	 
end --if time

return commandArray
