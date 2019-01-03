--
--
-- Main Programme
--
--

function IsWeekend()
     local dayNow = tonumber(os.date("%w"))
     local weekend
     if (dayNow == 0) or (dayNow == 6) then weekend = "True"
     else weekend = "False"
     end
     return weekend
end

commandArray = {}
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
	print ('Starting script_time_Chauffage.lua ')

        -- get current time
        timenow = os.date("*t")
        minutesnow = timenow.min + timenow.hour * 60
        minutes = timenow.min
        hoursnow = timenow.hour

	--print( otherdevices['@HOME Chauffage'] )
	if otherdevices['@HOME Chauffage'] == 'Off' then
		return
	end

	if otherdevices['@HOME Chauffage'] == 'Régulé' then
		if IsWeekend() then
			EcoNuit = '18'
			EcoJour = '21'
			Confort1 = '22'
			Confort2 = '23'
			Heat = '24'
			SuperHeat = '26'
		else
			EcoNuit = '18'
			EcoJour = '19'
			Confort1 = '21'
			Confort2 = '22.5'
			Heat = '24'
			SuperHeat = '26'
		end
	end
	if otherdevices['@HOME Chauffage'] == 'Confort' then
		EcoNuit = '21'
		EcoJour = '22'
		Confort1 = '23'
		Confort2 = '24'
		Heat = '24'
		SuperHeat = '24'
	end
	if otherdevices['@HOME Chauffage'] == 'Forcé' then
		EcoNuit = '24'
		EcoJour = '24'
		Confort1 = '24'
		Confort2 = '24'
		Heat = '24'
		SuperHeat = '24'
	end
	if otherdevices['@HOME Chauffage'] == 'Vacances' then
		EcoNuit = '17'
		EcoJour = '17'
		Confort1 = '17'
		Confort2 = '17'
		Heat = '17'
		SuperHeat = '17'
	end
	if ( hoursnow == 6 ) then
		bureau = EcoJour
		sdb = Confort2
		cuisine = Confort2
		chbparent = EcoNuit
		entree = Confort1
		salon = Confort1
		sm = Confort1
	end
	if ( hoursnow > 6 and hoursnow < 9 ) then
		bureau = Confort2
		sdb = Confort2
		cuisine = Confort2
		chbparent = EcoNuit
		entree = Confort2
		salon = EcoJour
		sm = EcoJour
	end
	if ( hoursnow >= 9 and hoursnow < 12 ) then
		bureau =  EcoJour
		sdb = EcoJour
		cuisine = EcoJour
		chbparent = EcoNuit
		entree = Confort1
		salon = EcoJour
		sm = EcoJour
	end
	if ( hoursnow >= 12 and hoursnow < 14 ) then
		bureau =  Confort1
		sdb = EcoJour
		cuisine = Confort1
		chbparent = EcoNuit
		entree = Confort1
		salon = Confort1
		sm = Confort1
	end
	if ( hoursnow >= 14 and hoursnow < 18) then
		bureau = EcoJour
		sdb = EcoJour
		cuisine = EcoJour
		chbparent = EcoNuit
		entree = EcoJour
		salon = EcoJour
		sm = EcoJour
	end
	if ( hoursnow >= 18 and hoursnow < 20 ) then
		bureau = Confort1
		sdb = Confort1
		cuisine =Confort1
		chbparent = EcoNuit
		entree = Confort1
		salon = Confort1
		sm = Confort1
	end
	if ( hoursnow >= 20 and hoursnow < 21 ) then
		bureau = Confort1
		sdb = Confort1
		cuisine = Confort1
		chbparent = EcoNuit
		entree = Confort2
		salon = Confort2
		sm = Confort1
	end
	if ( hoursnow >= 21 and hoursnow < 22 ) then
		bureau = EcoNuit
		sdb = EcoNuit
		cuisine = EcoNuit
		chbparent = EcoNuit
		entree = EcoNuit
		salon = Confort2
		sm = Confort2
	end
	if ( hoursnow >= 22 and hoursnow < 23 ) then
		bureau =  EcoNuit
		sdb = EcoNuit
		cuisine = EcoNuit
		chbparent = EcoNuit
		entree = EcoNuit
		salon = Confort2
		sm = Confort1
	end
	if ( hoursnow == 23 ) then
		bureau = '17'
		sdb = '17'
		cuisine = '17'
		chbparent = '17'
		entree = '17'
		salon = '17'
		sm = '17'
                commandArray[#commandArray +1]={['@HOME Chauffage']='Set Level: 20'}
	end
	if otherdevices['@HOME Chauffage'] == 'Manuel' then
		bureau = otherdevices_svalues['Consigne Bureau']
		sdb = otherdevices_svalues['Consigne Salle de Bains']
		cuisine = otherdevices_svalues['Consigne Cusine']
		chbparent = otherdevices_svalues['Consigne Chambre Parents']
		entree = otherdevices_svalues['Consigne Entrée']
		salon = otherdevices_svalues['Consigne Salon']
		sm = otherdevices_svalues['Consigne Salle à Manger']
	end

	outsideTemp = otherdevices_svalues['Outside Temperature']

	--[[
        - 755 Consigne Salle à Manger
        - 754 Consigne Entrée
        - 753 Consigne Cusine
        - 752 Consigne Salle de Bains
        - 751 Consigne Bureau
        - 750 Consigne Salon
        - 756 Consigne Chambre Parents
	--]]

	if otherdevices_svalues['Consigne Bureau'] ~= bureau then
		-- Bureau
		commandArray[#commandArray +1]={['SetSetPoint:751'] = bureau }
	end
	if otherdevices_svalues['Consigne Salle de Bains'] ~= sdb then
		-- Salle de bain
		commandArray[#commandArray +1]={['SetSetPoint:752'] = sdb }
	end
	if otherdevices_svalues['Consigne Cusine'] ~= cuisine then
		-- Cuisine
		commandArray[#commandArray +1]={['SetSetPoint:753'] = cuisine }
	end
	if otherdevices_svalues['Consigne Chambre Parents'] ~= chbparent then
		-- Chambre
		commandArray[#commandArray +1]={['SetSetPoint:756'] = chbparent }
	end
	if otherdevices_svalues['Consigne Entrée'] ~= entree then
		-- Entrée
		commandArray[#commandArray +1]={['SetSetPoint:754'] = entree }
	end
	if otherdevices_svalues['Consigne Salon'] ~= salon then
		-- Salon
		commandArray[#commandArray +1]={['SetSetPoint:750'] = salon }
	end
	if otherdevices_svalues['Consigne Salle à Manger'] ~= sm then
		-- SM2
		commandArray[#commandArray +1]={['SetSetPoint:755'] = sm }
	end

	--print('Consigne Bureau : ' .. otherdevices_svalues['Consigne Bureau'] )
	--print('SetPoint Bureau : ' .. otherdevices_svalues['BT Bureau - Heat'] )
	--print('Consigne Chambre Parent : ' .. otherdevices_svalues['Consigne Chambre Parents'] )
	--print('SetPoint Chambre Parent : ' .. otherdevices_svalues['BT Chambre Parent - Heat'] )
	--print('Consigne Salon : ' .. otherdevices_svalues['Consigne Salon'] )
	--print('SetPoint Salon : ' .. otherdevices_svalues['BT Salon - Heat'] )
	--print('Consigne Salle à Manger : ' .. otherdevices_svalues['Consigne Salle à Manger'] )
	--print('SetPoint Salle à Manger 1 : ' .. otherdevices_svalues['BT SM1 - Heat'] )
	--print('SetPoint Salle à Manger 2 : ' .. otherdevices_svalues['BT SM2 - Heat'] )
	--print('Consigne Entrée : ' .. otherdevices_svalues['Consigne Entrée'] )
	--print('SetPoint Entrée : ' .. otherdevices_svalues['BT Entrée - Heat'] )
	--print('Consigne Cuisine : ' .. otherdevices_svalues['Consigne Cusine'] )
	--print('SetPoint Cuisine : ' .. otherdevices_svalues['BT Cuisine - Heat'] )
	--print('Consigne Salle de Bain : ' .. otherdevices_svalues['Consigne Salle de Bains'] )
	--print('SetPoint Salle de Bain : ' .. otherdevices_svalues['BT Salle de bain - Heat'] )

return commandArray
