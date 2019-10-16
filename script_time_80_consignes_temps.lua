--
--
-- Main Programme
--
--

commandArray = {}

	print('Starting script_time_consignes_temps.lua')
	print('Deteceur de porte')
	print('---> Bureau: ' ..otherdevices['Detecteur Fenetre Bureau - Sensor'])
	print('---> Chambre: ' ..otherdevices['Detecteur Chambre Parent - Sensor'])
	print('---> Salon: ' ..otherdevices['Detecteur Salon - Sensor'])
	print('---> Salle à Manger: ' ..otherdevices['Detecteur Salle à Manger - Sensor'])

	if otherdevices['Detecteur Fenetre Bureau - Sensor'] == 'Closed' then
		if otherdevices_svalues['BT Bureau - Heat'] ~= otherdevices_svalues['Consigne Bureau'] then
			print('--> Consigne Bureau : ' .. otherdevices_svalues['Consigne Bureau'] )
       			print('--> SetPoint Bureau : ' .. otherdevices_svalues['BT Bureau - Heat'] )
    			commandArray[#commandArray +1]={['SetSetPoint:330']= otherdevices_svalues['Consigne Bureau']}
    			commandArray[#commandArray +1]={['SetSetPoint:503']= otherdevices_svalues['Consigne Bureau']}
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:330']= '8'}
	end

	if otherdevices['Detecteur Chambre Parent - Sensor'] == 'Closed' then
		if otherdevices_svalues['BT Chambre Parent - Heat'] ~= otherdevices_svalues['Consigne Chambre Parents'] then
			print('--> Consigne Chambre Parent : ' .. otherdevices_svalues['Consigne Chambre Parents'] )
       			print('--> SetPoint Chambre Parent : ' .. otherdevices_svalues['BT Chambre Parent - Heat'] )
     			commandArray[#commandArray +1]={['SetSetPoint:160']= otherdevices_svalues['Consigne Chambre Parents']}
     			commandArray[#commandArray +1]={['SetSetPoint:428']= otherdevices_svalues['Consigne Chambre Parents']}
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:160']= '8'}
	end

	if otherdevices['Detecteur Salon - Sensor'] == 'Closed' then
		if otherdevices_svalues['Consigne Salon'] ~= otherdevices_svalues['BT Salon - Heat'] then
			print('--> Consigne Salon : ' .. otherdevices_svalues['Consigne Salon'] )
       			print('--> SetPoint Salon : ' .. otherdevices_svalues['BT Salon - Heat'] )
       			commandArray[#commandArray +1]={['SetSetPoint:923']= otherdevices_svalues['Consigne Salon'] }
       			-- commandArray[#commandArray +1]={['SetSetPoint:420']= otherdevices_svalues['Consigne Salon'] }
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:923']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:372']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:387']= '8'}
	end

	if otherdevices['Detecteur Salle à Manger - Sensor'] == 'Closed' then
		if otherdevices_svalues['Consigne Salle à Manger'] ~= otherdevices_svalues['BT SM1 - Heat'] then
			print('--> Consigne Salle à Manger : ' .. otherdevices_svalues['Consigne Salle à Manger'] )
       			print('--> SetPoint Salle à Manger 1 : ' .. otherdevices_svalues['BT SM1 - Heat'] )
       			commandArray[#commandArray +1]={['SetSetPoint:372']= otherdevices_svalues['Consigne Salle à Manger'] }
       			print('--> SetPoint Salle à Manger 2 : ' .. otherdevices_svalues['BT SM2 - Heat'] )
       			commandArray[#commandArray +1]={['SetSetPoint:387']= otherdevices_svalues['Consigne Salle à Manger'] }
		end
	else
  		commandArray[#commandArray +1]={['SetSetPoint:372']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:387']= '8'}
  		commandArray[#commandArray +1]={['SetSetPoint:902']= '8'}
	end

	if otherdevices_svalues['BT Entrée - Heat'] ~= otherdevices_svalues['Consigne Entrée'] then
		print('--> Consigne Entrée : ' .. otherdevices_svalues['Consigne Entrée'] )
       		print('--> SetPoint Entrée : ' .. otherdevices_svalues['BT Entrée - Heat'] )
       		commandArray[#commandArray +1]={['SetSetPoint:344']= otherdevices_svalues['Consigne Entrée'] }
	end

	if otherdevices_svalues['Consigne Cusine'] ~= otherdevices_svalues['BT Cuisine - Heat'] then
		print('--> Consigne Cuisine : ' .. otherdevices_svalues['Consigne Cusine'] )
       		print('--> SetPoint Cuisine : ' .. otherdevices_svalues['BT Cuisine - Heat'] )
    		commandArray[#commandArray +1]={['SetSetPoint:778']= otherdevices_svalues['Consigne Cusine']}
	end

	if otherdevices_svalues['Consigne Salle de Bains'] ~= otherdevices_svalues['BT Salle de bain - Heat'] then
		print('--> Consigne Salle de Bain : ' .. otherdevices_svalues['Consigne Salle de Bains'] )
       		print('--> SetPoint Salle de Bain : ' .. otherdevices_svalues['BT Salle de bain - Heat'] )
  		commandArray[#commandArray +1]={['SetSetPoint:78']= otherdevices_svalues['Consigne Salle de Bains'] }
	end

	if otherdevices_svalues['BT Nico Setpoint'] ~= otherdevices_svalues['Consigne Chambre Nicolas'] then
		print('--> Consigne Chambre Nicolas : ' .. otherdevices_svalues['Consigne Chambre Nicolas'] )
       		print('--> SetPoint Chambre Nicolas : ' .. otherdevices_svalues['BT Nico Setpoint'] )
     		commandArray[#commandArray +1]={['SetSetPoint:842']= otherdevices_svalues['Consigne Chambre Nicolas']}
	end

return commandArray
