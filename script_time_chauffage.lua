--
--
-- Main Programme
--

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

	Outside Temperature
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


	print ('Starting script_time_Clim.lua ')

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
	bureauClimtemp = otherdevices_svalues['Clim Bureau - Temperature']
	salonClimTemp = otherdevices_svalues['Clim Salon Temperature']
	chambreClimTemp = otherdevices_svalues['Clim Chambre Temperature']


	print('Temperatures : ' )
	print('   Entrée           : ' ..entreeTemp )
	print('   Salle à Manger 1 : ' ..sm1Temp )
	print('   Salle à Manger 2 : ' ..sm2Temp )
	print('   Salon            : ' ..salonTemp )
	print('   Cuisine          : ' ..cuisineTemp)
	print('   Chambre Parent   : ' ..chambreTemp)
	print('   Salle de Bain    : ' ..sldbTemp)


	if ( hoursnow == 6 and minutes == 0) then
		-- Salle de bain
        	commandArray[#commandArray +1]={['SetSetPoint:78']='30'}
		-- Cuisine
        	commandArray[#commandArray +1]={['SetSetPoint:358']='24'}
		-- Chambre
        	commandArray[#commandArray +1]={['SetSetPoint:160']='24'}
	end
	if ( hoursnow == 9 and minutes == 0 ) then
		-- Salle de bain
        	commandArray[#commandArray +1]={['SetSetPoint:78']='21'}
		-- Cuisine
        	commandArray[#commandArray +1]={['SetSetPoint:358']='21'}
		-- Chambre
        	commandArray[#commandArray +1]={['SetSetPoint:160']='21'}
	end
	if ( hoursnow == 12 and minutes == 0 ) then
		-- Cuisine
        	commandArray[#commandArray +1]={['SetSetPoint:358']='24'}
		-- Salon
        	commandArray[#commandArray +1]={['SetSetPoint:402']='24'}
		-- Entrée
        	commandArray[#commandArray +1]={['SetSetPoint:344']='24'}
	end
	if ( hoursnow == 18 and minutes == 0 ) then
		-- Cuisine
        	commandArray[#commandArray +1]={['SetSetPoint:358']='24'}
		-- Salla à Manger
        	commandArray[#commandArray +1]={['SetSetPoint:372']='24'}
        	commandArray[#commandArray +1]={['SetSetPoint:387']='24'}
		-- Salon
        	commandArray[#commandArray +1]={['SetSetPoint:402']='24'}
		-- Bureau
        	commandArray[#commandArray +1]={['SetSetPoint:330']='24'}
		-- Entrée
        	commandArray[#commandArray +1]={['SetSetPoint:344']='24'}
	end
	if ( hoursnow == 23 and minutes == 0 ) then
		-- Cuisine
        	commandArray[#commandArray +1]={['SetSetPoint:358']='19'}
		-- Salla à Manger
        	commandArray[#commandArray +1]={['SetSetPoint:372']='19'}
        	commandArray[#commandArray +1]={['SetSetPoint:387']='19'}
		-- Salon
        	commandArray[#commandArray +1]={['SetSetPoint:402']='19'}
		-- Bureau
        	commandArray[#commandArray +1]={['SetSetPoint:330']='19'}
		-- Entrée
        	commandArray[#commandArray +1]={['SetSetPoint:344']='19'}
	end
	if ( hoursnow == 21 ) then
		-- Cuisine
        	commandArray[#commandArray +1]={['SetSetPoint:358']='19'}
		-- Salla à Manger
        	commandArray[#commandArray +1]={['SetSetPoint:372']='24'}
        	commandArray[#commandArray +1]={['SetSetPoint:387']='24'}
		-- Salon
        	commandArray[#commandArray +1]={['SetSetPoint:402']='24'}
		-- Bureau
        	commandArray[#commandArray +1]={['SetSetPoint:330']='19'}
		-- Entrée
        	commandArray[#commandArray +1]={['SetSetPoint:344']='24'}
		-- Salle de bain
        	commandArray[#commandArray +1]={['SetSetPoint:78']='19'}
		-- Chambre
        	commandArray[#commandArray +1]={['SetSetPoint:160']='17'}
	end

return commandArray
