--
--
-- Main Programme
--
--

function IsWeekend()
     local dayNow = tonumber(os.date("%w"))
     local weekend
     if (dayNow == 0) or (dayNow == 6) then 
	     weekend = "True"
     else 
	     weekend = "False"
     end
     return weekend
end

	--[[
	- 78  - Salle de Bain
	- 160 - Chambre Parent
	- 358 - Cuisine
	- 344 - Entrée
	- 330 - Bureau
	- 594 - Salon
	- 387 - Salle à Manger 2 
	- 372 - Salle à Manger 1

	BT Cuisine - Temperature
	BT SM2 - Temperature
	BT SM1 - Temperature
	BT Salon - Temperature
	BT Cuisine - Temperature
	BT Entrée - Temperature
	BT Bureau - Temperature
	BT Chambre Parent - Temperature
	Clim Bureau - Temperature
	Clim Salon Temperature
	Clim Chambre Temperature
	Clim Bureau Temperature

        commandArray[#commandArray +1]={['SetSetPoint:428']='18'}

	]]--
	print ('Starting script_time_00_Chauffage.lua ')
	commandArray = {}

        -- get current time
        timenow = os.date("*t")
        minutesnow = timenow.min + timenow.hour * 60
        minutes = timenow.min
        hoursnow = timenow.hour

	print( otherdevices['@HOME Chauffage'] )
	if otherdevices['@HOME Chauffage'] == 'Off' then
		return
	end
	
	confortSetPoint = otherdevices_svalues['Confort']
	ecoSetPoint = otherdevices_svalues['Eco']

	if otherdevices['@HOME Chauffage'] == 'Régulé' then
		if IsWeekend() == "True" then
			print(" Régulé - Weekend")
			Confort1 = tostring( tonumber(confortSetPoint) + 0.00)
			Confort2 = tostring( tonumber(confortSetPoint) + 1.50)
			Heat = tostring( tonumber(confortSetPoint) + 3.00)
			sdbChaud = tostring( tonumber(confortSetPoint) +  3.50)
			SuperHeat = tostring( tonumber(confortSetPoint) + 6.00)

			EcoNuit = tostring( tonumber(ecoSetPoint) - 1.00)
			sdbEco = tostring( tonumber(ecoSetPoint) + 1.00)
			EcoJour = tostring( tonumber(ecoSetPoint) + 2.00)
		else
			print(" Régulé - semaine")
			Confort1 = tostring( tonumber(confortSetPoint) + 0.00)
			Confort2 = tostring( tonumber(confortSetPoint) + 1.00)
			Heat = tostring( tonumber(confortSetPoint) + 2.50)
			sdbChaud = tostring( tonumber(confortSetPoint) +  3.50)
			SuperHeat = tostring( tonumber(confortSetPoint) + 5.50)

			EcoNuit = tostring( tonumber(ecoSetPoint) - 1.00)
			sdbEco = tostring( tonumber(ecoSetPoint) - 1.00)
			EcoJour = tostring( tonumber(ecoSetPoint) + 0.00)
		end
	end
	if otherdevices['@HOME Chauffage'] == 'Confort' then
		print(" Confort")
		sdbChaud = '24.00'
		sdbEco = '18.00'
		EcoNuit = '21.00'
		EcoJour = '22.00'
		Confort1 = '23.00'
		Confort2 = '24.00'
		Heat = '24.00'
		SuperHeat = '24.00'
	end
	if otherdevices['@HOME Chauffage'] == 'Forcé' then
		print(" Forcé")
		sdbChaud = '26.00'
		sdbEco = '26.00'
		EcoNuit = '26.00'
		EcoJour = '26.00'
		Confort1 = '26.00'
		Confort2 = '26.00'
		Heat = '26.00'
		SuperHeat = '26.00'
	end
	if otherdevices['@HOME Chauffage'] == 'Vacances' then
		print(" Vacances")
		sdbChaud = '18.00'
		sdbEco = '18.00'
		EcoNuit = '18.00'
		EcoJour = '18.00'
		Confort1 = '18.00'
		Confort2 = '18.00'
		Heat = '18.00'
		SuperHeat = '18.00'
	end
	print("Weekend : " ..IsWeekend())
	print("confortSetPoint: " ..confortSetPoint)
	print("ecoSetPoint    : " ..ecoSetPoint)
	print("sdbChaud: " .. sdbChaud)
	print("sdbEco  : " .. sdbEco)
	print("EcoNuit : " .. EcoNuit)
	print("EcoJour : " .. EcoJour)
	print("Confort1: " .. Confort1)
	print("Confort2: " .. Confort2)
	print("Heat    : " .. Heat)
	print("SuperHeat: " .. SuperHeat)
		
	if ( hoursnow == 6 ) then
		bureau = EcoJour
		sdb = sdbEco
		cuisine = Confort1
		chbparent = EcoJour
		chbnicolas = EcoJour
		entree = EcoJour
		salon = EcoJour
		sm = EcoJour
	end
	if ( hoursnow > 6 and hoursnow < 9 ) then
		bureau = Confort2
		sdb = sdbChaud
		cuisine = Confort2
		entree = Confort1
		salon = EcoJour
		sm = EcoJour
	end
	if ( hoursnow > 7 and hoursnow < 8 ) then
		chbparent = Confort1
		chbnicolas = Confort1
	end

	if ( hoursnow >= 9 and hoursnow < 12 ) then
		bureau =  EcoJour
		if otherdevices['Anyone@Home'] == 'On' then
			bureau =  Confort2
			sdb = sdbEco
			cuisine = Confort1
			chbparent = EcoJour
			chbnicolas = EcoJour
			entree = EcoJour
			salon = EcoJour
			sm = EcoJour
		else
			bureau =  EcoJour
			sdb = sdbEco
			cuisine = EcoJour
			chbparent = EcoJour
			chbnicolas = EcoJour
			entree = EcoJour
			salon = EcoJour
			sm = EcoJour
		end
	end
	if ( hoursnow >= 12 and hoursnow < 14 ) then
		bureau =  Confort1
		sdb = sdbEco
		cuisine = Confort2
		chbparent = EcoNuit
		chbnicolas = EcoNuit
		entree = Confort1
		salon = Confort1
		sm = Confort1
	end
	if ( hoursnow >= 14 and hoursnow < 18) then
		if otherdevices['Anyone@Home'] == 'On' then
			bureau = Confort1
			sdb = sdbEco
			cuisine = EcoJour
			chbparent = EcoNuit
			chbnicolas = EcoNuit
			entree = EcoJour
			salon = EcoJour
			sm = EcoJour
		else
			bureau = Confort1
			sdb = sdbEco
			cuisine = EcoJour
			chbparent = EcoNuit
			chbnicolas = EcoNuit
			entree = EcoJour
			salon = EcoJour
			sm = EcoJour
		end
	end
	if ( hoursnow >= 18 and hoursnow < 20 ) then
		bureau = Confort1
		sdb = sdbEco
		cuisine =Confort2
		chbparent = EcoJour
		chbnicolas = EcoJour
		entree = Confort1
		salon = Confort1
		sm = Confort1
	end
	if ( hoursnow >= 20 and hoursnow < 21 ) then
		bureau = Confort1
		sdb = sdbEco
		cuisine = Confort1
		chbparent = EcoJour
		chbnicolas = EcoJour
		entree = Confort1
		salon = Confort2
		sm = Confort1
	end
	if ( hoursnow >= 21 and hoursnow < 22 ) then
		bureau = EcoNuit
		sdb = EcoNuit
		cuisine = EcoNuit
		chbparent = Confort1
		chbnicolas = Confort1
		entree = EcoNuit
		salon = Confort2
		sm = Confort2
	end
	if ( hoursnow >= 22 and hoursnow < 23 ) then
		bureau =  EcoNuit
		sdb = EcoNuit
		cuisine = EcoNuit
		chbparent = EcoNuit
		chbnicolas = EcoNuit
		entree = EcoNuit
		salon = Confort2
		sm = EcoNuit
	end
	if ( hoursnow == 23 ) then
		bureau = '18.00'
		sdb = '18.00'
		cuisine = '18.00'
		chbparent = '18.00'
		chbnicolas = '18.00'
		entree = '18.00'
		salon = '18.00'
		sm = '18.00'
		if otherdevices['@HOME Chauffage'] == 'Manuel' then
                	commandArray[#commandArray +1]={['@HOME Chauffage']='Set Level: 20'}
		end
	end
	if otherdevices['@HOME Chauffage'] == 'Manuel' then
		bureau = otherdevices_svalues['Consigne Bureau']
		sdb = otherdevices_svalues['Consigne Salle de Bains']
		cuisine = otherdevices_svalues['Consigne Cusine']
		chbparent = otherdevices_svalues['Consigne Chambre Parents']
		chbincolas = otherdevices_svalues['Consigne Chambre Nicolas']
		entree = otherdevices_svalues['Consigne Entrée']
		salon = otherdevices_svalues['Consigne Salon']
		sm = otherdevices_svalues['Consigne Salle à Manger']
	end

	outsideTemp = otherdevices_svalues['Outside Temperature']

	if otherdevices_svalues['Consigne Bureau'] ~= bureau then
		-- Bureau
		commandArray[#commandArray +1]={['SetSetPoint:751'] = bureau }
		print('Consigne Bureau : ' .. otherdevices_svalues['Consigne Bureau'] )
		print('SetPoint Bureau : ' .. otherdevices_svalues['BT Bureau - Heat'] )
	end
	if otherdevices_svalues['Consigne Salle de Bains'] ~= sdb then
		-- Salle de bain
		commandArray[#commandArray +1]={['SetSetPoint:752'] = sdb }
		print('Consigne Salle de Bain : ' .. otherdevices_svalues['Consigne Salle de Bains'] )
		print('SetPoint Salle de Bain : ' .. otherdevices_svalues['BT Salle de bain - Heat'] )
	end
	if otherdevices_svalues['Consigne Cusine'] ~= cuisine then
		-- Cuisine
		commandArray[#commandArray +1]={['SetSetPoint:753'] = cuisine }
		print('Consigne Cuisine : ' .. otherdevices_svalues['Consigne Cusine'] )
		print('SetPoint Cuisine : ' .. otherdevices_svalues['BT Cuisine - Heat'] )
	end
	if otherdevices_svalues['Consigne Chambre Nicolas'] ~= chbnicolas then
		-- Chambre
		commandArray[#commandArray +1]={['SetSetPoint:934'] = chbnicolas }
		print('Consigne Chambre Nicolas : ' .. otherdevices_svalues['Consigne Chambre Nicolas'] )
		print('SetPoint Chambre Nicolas : ' .. otherdevices_svalues['BT Nico Setpoint'] )
	end
	if otherdevices_svalues['Consigne Chambre Parents'] ~= chbparent then
		-- Chambre
		commandArray[#commandArray +1]={['SetSetPoint:756'] = chbparent }
		print('Consigne Chambre Parent : ' .. otherdevices_svalues['Consigne Chambre Parents'] )
		print('SetPoint Chambre Parent : ' .. otherdevices_svalues['BT Chambre Parent - Heat'] )
	end
	if otherdevices_svalues['Consigne Entrée'] ~= entree then
		-- Entrée
		commandArray[#commandArray +1]={['SetSetPoint:754'] = entree }
		print('Consigne Entrée : ' .. otherdevices_svalues['Consigne Entrée'] )
		print('SetPoint Entrée : ' .. otherdevices_svalues['BT Entrée - Heat'] )
	end
	if otherdevices_svalues['Consigne Salon'] ~= salon then
		-- Salon
		commandArray[#commandArray +1]={['SetSetPoint:750'] = salon }
		print('Consigne Salon : ' .. otherdevices_svalues['Consigne Salon'] )
		print('SetPoint Salon : ' .. otherdevices_svalues['BT Salon - Heat'] )
	end
	if otherdevices_svalues['Consigne Salle à Manger'] ~= sm then
		-- SM2
		commandArray[#commandArray +1]={['SetSetPoint:755'] = sm }
		print('Consigne Salle à Manger : ' .. otherdevices_svalues['Consigne Salle à Manger'] )
		print('SetPoint Salle à Manger 1 : ' .. otherdevices_svalues['BT SM1 - Heat'] )
		print('SetPoint Salle à Manger 2 : ' .. otherdevices_svalues['BT SM2 - Heat'] )
	end

	--
	print('### ++++++> Device Changes in commandArray: ' ..#commandArray )
	for i, v in pairs(commandArray) do
		if type(v) == "table" then
			for namedevice, t in pairs(v) do
		  		print('### '..i.."="..namedevice.."->".. v[namedevice])
	   		end
		else
			print('### '..i.."->".. v)
		end
	end

return commandArray
