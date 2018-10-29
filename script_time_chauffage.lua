--
--
-- Main Programme
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
	- 402 - Salon
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

        -- get current time
        timenow = os.date("*t")
        minutesnow = timenow.min + timenow.hour * 60
        minutes = timenow.min
        hoursnow = timenow.hour

	outsideTemp = otherdevices_svalues['Outside Temperature']
	cuisineTemp = otherdevices_svalues['BT Cuisine - Temperature']
	sm1Temp = otherdevices_svalues['BT SM1 - Temperature']
	sm2Temp = otherdevices_svalues['BT SM2 - Temperature']
	salonTemp = otherdevices_svalues['BT Salon - Temperature']
	entreeTemp = otherdevices_svalues['BT Entrée - Temperature']
	bureauTemp = otherdevices_svalues['BT Bureau - Temperature']
	chambreTemp = otherdevices_svalues['BT Chambre Parent - Temperature']
	sldbTemp = otherdevices_svalues['BT Salle de bain - Temperature']
	bureauClimTemp = otherdevices_svalues['Clim Bureau Temperature']
	salonClimTemp = otherdevices_svalues['Clim Salon Temperature']
	chambreClimTemp = otherdevices_svalues['Clim Chambre Temperature']

	print ('Starting script_time_Chauffage.lua ')

	if minutes == 0 then
		print('Temperatures : ' )
		print('   Entrée           : ' ..entreeTemp )
		print('   Salle à Manger 1 : ' ..sm1Temp )
		print('   Salle à Manger 2 : ' ..sm2Temp )
		print('   Salon            : ' ..salonTemp )
		print('   Salon          C : ' ..salonClimTemp )
		print('   Cuisine          : ' ..cuisineTemp)
		print('   Chambre Parent   : ' ..chambreTemp)
		print('   Chambre Parent C : ' ..chambreClimTemp)
		print('   Salle de Bain    : ' ..sldbTemp)
		print('   Bureau           : ' ..bureauTemp)
		print('   Bureau         C : ' ..bureauClimTemp)
	end

	print('SetPoint Bureau : ' .. otherdevices_svalues['BT Bureau - Heat'] )
	print('SetPoint Chambre Parent : ' .. otherdevices_svalues['BT Chambre Parent - Heat'] )
	print('SetPoint Salon : ' .. otherdevices_svalues['BT Salon - Heat'] )
	print('SetPoint Salle à Manger 2 : ' .. otherdevices_svalues['BT SM2 - Heat'] )
	print('SetPoint Salle à Manger 1 : ' .. otherdevices_svalues['BT SM1 - Heat'] )
	print('SetPoint Entrée : ' .. otherdevices_svalues['BT Entrée - Heat'] )
	print('SetPoint Cuisine : ' .. otherdevices_svalues['BT Cuisine - Heat'] )
	print('SetPoint Salle de Bain : ' .. otherdevices_svalues['BT Salle de bain - Heat'] )

	if IsWeekend() then
		EcoNuit = '19'
		EcoJour = '22'
		Confort1 = '21'
		Confort2 = '22.5'
		Heat = '24'
	else
		EcoNuit = '19'
		EcoJour = '19'
		Confort1 = '21'
		Confort2 = '22.5'
		Heat = '24'
	end

	if ( hoursnow >= 6 and hoursnow < 9 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~= Heat then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']=Heat}
		end
		if otherdevices_svalues['BT Salle de bain - Heat'] ~='30' then
			-- Salle de bain
        		commandArray[#commandArray +1]={['SetSetPoint:78']='30'}
		end
		if otherdevices_svalues['BT Cuisine - Heat'] ~= Heat then
			-- Cuisine
        		commandArray[#commandArray +1]={['SetSetPoint:358']= Heat}
		end
		if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoNuit then
			-- Chambre
        		commandArray[#commandArray +1]={['SetSetPoint:160']= EcoNuit}
		end
		if otherdevices_svalues['BT Entrée - Heat'] ~= Heat then
			-- Entrée
        		commandArray[#commandArray +1]={['SetSetPoint:344']= Heat}
		end
                if otherdevices_svalues['BT Salon - Heat'] ~= Heat then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= Heat}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~='Heat' then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']='Heat'}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= Heat then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= Heat}
                end
	end
	if ( hoursnow >= 9 and hoursnow < 12 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~= EcoJour then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']= EcoJour}
		end
                if otherdevices_svalues['BT Salle de bain - Heat'] ~= Confort1 then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']= Confort1}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= EcoJour then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= EcoJour}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoJour then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoJour}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= EcoJour then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= EcoJour}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= EcoJour then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= EcoJour}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~= '21' then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']= '21'}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= EcoJour then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= EcoJour}
                end
	end
	if ( hoursnow >= 12 and hoursnow < 14 ) then
                if otherdevices_svalues['BT Salle de bain - Heat'] ~='18' then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']='18'}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= Confort2 then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= Confort2}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoNuit then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoNuit}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= Confort1 then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= Confort1}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= Confort2 then
			-- Salon
        		commandArray[#commandArray +1]={['SetSetPoint:402']= Confort2}
		end
                if otherdevices_svalues['BT SM1 - Heat'] ~='22' then
			-- SM1
        		commandArray[#commandArray +1]={['SetSetPoint:372']='22'}
		end
                if otherdevices_svalues['BT SM2 - Heat'] ~= Confort1 then
			-- SM2
        		commandArray[#commandArray +1]={['SetSetPoint:387']= Confort1}
		end
	end
	if ( hoursnow >= 14 and hoursnow < 18) then
                if otherdevices_svalues['BT Salle de bain - Heat'] ~='18' then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']='18'}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= Confort then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= EcoJour}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoJour then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoJour}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= EcoJour then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= EcoJour}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= EcoJour then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= EcoJour}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~= EcoJour then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']= EcoJour}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= EcoJour then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= EcoJour}
                end
	end
	if ( hoursnow >= 18 and hoursnow < 20 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~= Confort1 then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']= Confort1}
		end
                if otherdevices_svalues['BT Salle de bain - Heat'] ~= Confort1 then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']= Confort1}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= Confort2 then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= Confort2}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoNuit then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoNuit}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= Confort2 then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= Confort2}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= Confort2 then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= Confort2}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~= Confort1 then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']= Confort1}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= Confort2 then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= Confort2}
                end
	end

	if ( hoursnow >= 20 and hoursnow < 21 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~= EcoJour then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']= EcoJour}
		end
                if otherdevices_svalues['BT Salle de bain - Heat'] ~= EcoJour then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']= EcoJour}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= Confort1 then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= Confort1}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoNuit then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoNuit}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= EcoJour then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= EcoJour}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= Confort2 then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= Confort2}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~= Confort1 then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']= Confort1}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= Confort2 then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= Confort2}
                end
	end

	if ( hoursnow >= 21 and hoursnow < 22 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~= EcoNuit then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']= EcoNuit}
		end
                if otherdevices_svalues['BT Salle de bain - Heat'] ~= EcoNuit then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']= EcoNuit}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= EcoNuit then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= EcoNuit}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoNuit then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoNuit}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= EcoNuit then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= EcoNuit}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= Confort2 then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= Confort2}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~= EcoNuit then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']= EcoNuit}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= Confort1 then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= Confort1}
                end
	end

	if ( hoursnow >= 22 and hoursnow < 23 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~= EcoNuit then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']= EcoNuit}
		end
                if otherdevices_svalues['BT Salle de bain - Heat'] ~= EcoNuit then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']= EcoNuit}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~= EcoNuit then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']= EcoNuit}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~= EcoNuit then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']= EcoNuit}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~= EcoNuit then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']= EcoNuit}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~= Confort2 then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']= Confort2}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~= EcoNuit then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']= EcoNuit}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~= EcoNuit then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']= EcoNuit}
                end
	end
	if ( hoursnow == 23 ) then
		if otherdevices_svalues['BT Bureau - Heat'] ~='18' then
			-- Bureau
        		commandArray[#commandArray +1]={['SetSetPoint:330']='18'}
		end
                if otherdevices_svalues['BT Salle de bain - Heat'] ~='18' then
                        -- Salle de bain
                        commandArray[#commandArray +1]={['SetSetPoint:78']='18'}
                end
                if otherdevices_svalues['BT Cuisine - Heat'] ~='18' then
                        -- Cuisine
                        commandArray[#commandArray +1]={['SetSetPoint:358']='18'}
                end
                if otherdevices_svalues['BT Chambre Parent - Heat'] ~='18' then
                        -- Chambre
                        commandArray[#commandArray +1]={['SetSetPoint:160']='18'}
                end
                if otherdevices_svalues['BT Entrée - Heat'] ~='18' then
                        -- Entrée
                        commandArray[#commandArray +1]={['SetSetPoint:344']='18'}
                end
                if otherdevices_svalues['BT Salon - Heat'] ~='18' then
                        -- Salon
                        commandArray[#commandArray +1]={['SetSetPoint:402']='18'}
                end
                if otherdevices_svalues['BT SM1 - Heat'] ~='18' then
                        -- SM1
                        commandArray[#commandArray +1]={['SetSetPoint:372']='18'}
                end
                if otherdevices_svalues['BT SM2 - Heat'] ~='18' then
                        -- SM2
                        commandArray[#commandArray +1]={['SetSetPoint:387']='18'}
                end
	end

return commandArray
