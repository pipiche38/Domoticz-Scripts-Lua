-- Variables to customize ------------------------------------------------
local DEBUG = 0         -- 0 , 1
local VACANCES = 0      -- Prendre l'information d'un switch ou d'une Variable

-- Below , edit at your own risk ------------------------------------------

--
-- Main Programme
--

commandArray = {}

	-- Create UserVariables if not existing
    	if(uservariables['stateClimSalon'] == nil) then
    		commandArray['OpenURL'] = 'http://127.0.0.1:8080/json.htm?type=command&param=saveuservariable&vname=stateClimSalon&vtype=2&vvalue=na'
	end
    	if(uservariables['stateClimChbrParent'] == nil) then
    		commandArray['OpenURL'] = 'http://127.0.0.1:8080/json.htm?type=command&param=saveuservariable&vname=stateClimChbrParent&vtype=2&vvalue=na'
	end
    	if(uservariables['stateClimBureau'] == nil) then
    		commandArray['OpenURL'] = 'http://127.0.0.1:8080/json.htm?type=command&param=saveuservariable&vname=stateClimBureau&vtype=2&vvalue=na'
	end
        if ( DEBUG == 1 ) then print ('Detection ouverture de portes fenetres ') end


	-- read the state of the Various Sensors
	pf_Bureau  = otherdevices['Detecteur Fenetre Bureau - Sensor']
	pf_Chambre = otherdevices['Detecteur Chambre Parent - Sensor']
	--pf_Salon
	--pf_SalleaManger

	-- Memorize the state of Clim and Heater
        commandArray['Variable:stateClimSalon'] =  otherdevices['Clim Salon Power']
        commandArray['Variable:stateClimChbrParent'] = otherdevices['Clim Chambre Power']

	if ( pf_Bureau == "On" ) then 
		if ( uservariables['stateClimBureau'] == 'On' ) then
			print('we need to Power off, as a door is open in Bureau')
        		commandArray['Variable:stateClimBureau'] = otherdevices['Clim Bureau Power']
			commandArray['Clim Bureau Power'] = 'Off'
		end
	else -- Porte fenetre fermée
		if (  uservariables['stateClimBureau'] == 'On' and  otherdevices['Clim Bureau Power'] == 'Off' ) then
			print('Door has been closed, we can Power on in Bureau')
			commandArray['Clim Bureau Power'] = 'Off'
		end
	end

	if ( pf_Chambre == "On" ) then 
		if ( uservariables['stateClimChbrParent'] == 'On' ) then
			print('we need to Power off, as a door is open in Chambre')
        		commandArray['Variable:stateClimChbrParent'] = otherdevices['Clim Chambre Power']
			commandArray['Clim Chambre Power'] = 'Off'
		end
	else -- Porte fenetre fermée
		if (  uservariables['stateClimChbrParent'] == 'On' and  otherdevices['Clim Chambre Power'] == 'Off' ) then
			print('Door has been closed, we can Power on in Chambre')
			commandArray['Clim Chambre Power'] = 'Off'
		end
	end
	
        if ( DEBUG == 1 ) then print ('Detection ouverture de portes fenetres completed') end

return commandArray
