--
--
-- Main Programme
--
--


DEBUG = 1

commandArray = {}
        if ( DEBUG == 2 ) then print ('Starting script_time_Clim.lua ') end

	if ( DEBUG == 1 ) then print('Starting script_time_consignes_temps.lua') end 
	if ( DEBUG == 1 ) then print('Detecteur de porte') end 
	if ( DEBUG == 1 ) then print('---> Bureau: ' ..otherdevices['Detecteur Fenetre Bureau - Sensor']) end 
	if ( DEBUG == 1 ) then print('---> Chambre: ' ..otherdevices['Detecteur Chambre Parent - Sensor']) end 
	if ( DEBUG == 1 ) then print('---> Salon: ' ..otherdevices['Detecteur Salon - Sensor']) end 
	if ( DEBUG == 1 ) then print('---> Salle à Manger: ' ..otherdevices['Detecteur Salle à Manger - Sensor']) end 

	if ( DEBUG == 2 ) then print('Existing status') end 
	if ( DEBUG == 2 ) then print('--> Consigne Bureau : ' .. otherdevices_svalues['Consigne Bureau'] ) end 
	if ( DEBUG == 2 ) then print('--> SetPoint Bureau  : ' .. otherdevices_svalues['BT Bureau - Heat'] ) end 
	if otherdevices['Detecteur Fenetre Bureau - Sensor'] == 'Closed' then
		if otherdevices_svalues['BT Bureau - Heat'] ~= otherdevices_svalues['Consigne Bureau'] then
       			if ( DEBUG == 1 ) then print('++> SetPoint Bureau : ' .. otherdevices_svalues['Consigne Bureau']) end
    			commandArray[#commandArray +1]={['SetSetPoint:330']= otherdevices_svalues['Consigne Bureau']}
    			commandArray[#commandArray +1]={['SetSetPoint:503']= otherdevices_svalues['Consigne Bureau']}
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:330']= '8'}
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Chambre Parent : ' .. otherdevices_svalues['Consigne Chambre Parents'] ) end
 	if ( DEBUG == 2 ) then print('--> SetPoint Chambre Parent : ' .. otherdevices_svalues['BT Chambre Parent - Heat'] ) end
	if otherdevices['Detecteur Chambre Parent - Sensor'] == 'Closed' then
		if otherdevices_svalues['BT Chambre Parent - Heat'] ~= otherdevices_svalues['Consigne Chambre Parents'] then
       			if ( DEBUG == 1 ) then print('++> SetPoint Chambre Parent : ' .. otherdevices_svalues['Consigne Chambre Parents']) end
     			commandArray[#commandArray +1]={['SetSetPoint:160']= otherdevices_svalues['Consigne Chambre Parents']}
     			commandArray[#commandArray +1]={['SetSetPoint:428']= otherdevices_svalues['Consigne Chambre Parents']}
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:160']= '8'}
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Salon : ' .. otherdevices_svalues['Consigne Salon'] ) end
  	if ( DEBUG == 2 ) then print('--> SetPoint Salon : ' .. otherdevices_svalues['BT Salon - Heat'] ) end
	if otherdevices['Detecteur Salon - Sensor'] == 'Closed' then
		if otherdevices_svalues['Consigne Salon'] ~= otherdevices_svalues['BT Salon - Heat'] then
       			if ( DEBUG == 1 ) then print('++> SetPoint Salon : ' .. otherdevices_svalues['Consigne Salon']) end
       			commandArray[#commandArray +1]={['SetSetPoint:923']= otherdevices_svalues['Consigne Salon'] }
       			-- commandArray[#commandArray +1]={['SetSetPoint:420']= otherdevices_svalues['Consigne Salon'] }
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:923']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:372']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:387']= '8'}
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Salle à Manger : ' .. otherdevices_svalues['Consigne Salle à Manger'] ) end
 	if ( DEBUG == 2 ) then print('--> SetPoint Salle à Manger 1 : ' .. otherdevices_svalues['BT SM1 - Heat'] ) end
    	if ( DEBUG == 2 ) then print('--> SetPoint Salle à Manger 2 : ' .. otherdevices_svalues['BT SM2 - Heat'] ) end
	if otherdevices['Detecteur Salle à Manger - Sensor'] == 'Closed' then
		if otherdevices_svalues['Consigne Salle à Manger'] ~= otherdevices_svalues['BT SM1 - Heat'] then
       			if ( DEBUG == 1 ) then print('++> SetPoint Salle à Manger 1 : ' .. otherdevices_svalues['Consigne Salle à Manger']) end
       			commandArray[#commandArray +1]={['SetSetPoint:372']= otherdevices_svalues['Consigne Salle à Manger'] }
       			if ( DEBUG == 1 ) then print('++> SetPoint Salle à Manger 2 : ' .. otherdevices_svalues['Consigne Salle à Manger']) end
       			commandArray[#commandArray +1]={['SetSetPoint:947']= otherdevices_svalues['Consigne Salle à Manger'] }
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:372']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:387']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:902']= '8'}
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Entrée : ' .. otherdevices_svalues['Consigne Entrée'] ) end
    	if ( DEBUG == 2 ) then print('--> SetPoint Entrée : ' .. otherdevices_svalues['BT Entrée - Heat'] ) end
	if otherdevices_svalues['BT Entrée - Heat'] ~= otherdevices_svalues['Consigne Entrée'] then
       		if ( DEBUG == 1 ) then print('++> SetPoint Entrée : ' .. otherdevices_svalues['Consigne Entrée']) end
       		commandArray[#commandArray +1]={['SetSetPoint:344']= otherdevices_svalues['Consigne Entrée'] }
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Cuisine : ' .. otherdevices_svalues['Consigne Cusine'] ) end
   	if ( DEBUG == 2 ) then print('--> SetPoint Cuisine : ' .. otherdevices_svalues['BT Cuisine - Heat'] ) end
	if otherdevices_svalues['Consigne Cusine'] ~= otherdevices_svalues['BT Cuisine - Heat'] then
       		if ( DEBUG == 1 ) then print('++> SetPoint Cuisine : ' .. otherdevices_svalues['Consigne Cusine'] ) end
    		commandArray[#commandArray +1]={['SetSetPoint:778']= otherdevices_svalues['Consigne Cusine']}
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Salle de Bain : ' .. otherdevices_svalues['Consigne Salle de Bains'] ) end
     	if ( DEBUG == 2 ) then print('--> SetPoint Salle de Bain : ' .. otherdevices_svalues['BT Salle de bain - Heat'] ) end
	if otherdevices_svalues['Consigne Salle de Bains'] ~= otherdevices_svalues['BT Salle de bain - Heat'] then
       		if ( DEBUG == 1 ) then print('++> SetPoint Salle de Bain : ' .. otherdevices_svalues['Consigne Salle de Bains']) end
  		commandArray[#commandArray +1]={['SetSetPoint:78']= otherdevices_svalues['Consigne Salle de Bains'] }
	end

	if ( DEBUG == 2 ) then print('Existing status') end
	if ( DEBUG == 2 ) then print('--> Consigne Chambre Nicolas : ' .. otherdevices_svalues['Consigne Chambre Nicolas'] ) end
     	if ( DEBUG == 2 ) then print('--> SetPoint Chambre Nicolas : ' .. otherdevices_svalues['BT Nico Setpoint'] ) end
	if otherdevices_svalues['BT Nico Setpoint'] ~= otherdevices_svalues['Consigne Chambre Nicolas'] then
       		if ( DEBUG == 1 ) then print('++> SetPoint Chambre Nicolas : ' .. otherdevices_svalues['Consigne Chambre Nicolas']) end
     		commandArray[#commandArray +1]={['SetSetPoint:842']= otherdevices_svalues['Consigne Chambre Nicolas']}
	end


	if ( DEBUG == 1) then
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
	end
return commandArray
