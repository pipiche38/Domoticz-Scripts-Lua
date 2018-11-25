
-- Variables to customize ------------------------------------------------
local DEBUG = 0         -- 0 , 1

-- Below , edit at your own risk ------------------------------------------

function IsWeekend()
     local dayNow = tonumber(os.date("%w"))
     local weekend
     if (dayNow == 0) or (dayNow == 6) then weekend = "True"
     else weekend = "False"
     end
     return weekend
end

--
-- Main Programme
--

commandArray = {}

	if ( DEBUG == 2 ) then print ('Starting script_time_Clim.lua ') end

        if otherdevices['@HOME'] == 'On' then
                VACANCES = 0
        else
                VACANCES = 1
        end

	if ( VACANCES == 1 ) then
		-- do nothing
		return 
	end

	if ( 1 == 1 ) then
		-- do nothing
		return 
	end
	tempChbr = otherdevices_svalues['Temperature Chambre Parents']
        sTempChbr, sHumidityChbr = tempChbr:match("([^;]+);([^;]+)")
        nTempChbr = tonumber(sTempChbr)
        nHumidityChbr = tonumber(sHumidityChbr)
	if ( DEBUG == 2 ) then
		print('VACANCES: ' .. Vacances )
		print('Clim Chambre Temperature: ' .. otherdevices_svalues['Clim Chambre Temperature'] )
		print('Temp Chambre : ' .. tempChbr)
                print('Temp Chbr: ' .. nTempChbr)      -- print temperature
                print('Humidity Chbr: ' .. nHumidityChbr)  -- print humidity
	end

        -- get current time
        timenow = os.date("*t")
        minutesnow = timenow.min + timenow.hour * 60
        minutes = timenow.min
        hoursnow = timenow.hour

	-- at 21:00 let's switch on Ac if not yet done.
	if ( otherdevices['Clim Chambre Power'] == 'Off' and hoursnow == 21 ) then 
		--commandArray['Clim Chambre Power'] = 'On' end
                commandArray[#commandArray +1]={['Clim Chambre Power']='On'}
	 end
	
	--
	-- Enter in regulation Mode after 21 and until 8
	--
	if ( otherdevices['Clim Chambre Power'] == 'On' and ( hoursnow >= 21 or hoursnow <= 8 )) then
		if ( hoursnow == 21 ) then
			if ( otherdevices_svalues['Clim Chambre Mode'] ~= '30' ) then 
				print('21h Set Mode set to 30 (Cold) from ' .. otherdevices_svalues['Clim Chambre Mode'] )
				--commandArray['Clim Chambre Mode'] = 'Set Level: 30'  
                		commandArray[#commandArray +1]={['Clim Chambre Mode']='Set Level: 30'}
			end         -- Mode Clim/Cold
			if ( otherdevices_svalues['Clim Chambre Ventillation'] ~= '70' ) then 
				print('21h Set Mode Ventillation speed to 70 (Level5) from ' .. otherdevices_svalues['Clim Chambre Ventillation'] )
				--commandArray['Clim Chambre Ventillation'] = 'Set Level: 70'  -- Level 5
                		commandArray[#commandArray +1]={['Clim Chambre Ventillation']='Set Level: 70'}
			end -- Fan at Max
			--commandArray['SetSetPoint:428'] = '18' -- Set Temp to 18°
                	commandArray[#commandArray +1]={['SetSetPoint:428']='18'}
		end  -- 21h00 to 21h59

		if ( hoursnow == 22 and minutes <= 30 ) then
			if ( nTempChbr > 20 and nTempChbr <= 22 and otherdevices_svalues['Clim Chambre Ventillation'] == '70' ) then 
				print('22h30 Level Temp to 20, as we are at ' .. nTempChbr )
				commandArray['SetSetPoint:428'] = '20' -- Set Temp to 20°
				print('22h30 Set Mode Ventillation speed to 40 (Level3) ')
				--commandArray['Clim Chambre Ventillation'] = 'Set Level: 40'  -- Level 3
                		commandArray[#commandArray +1]={['Clim Chambre Ventillation']='Set Level: 40'}
			end -- Fan at Level3
		end -- 22h00 to 22h30
		
		if (((hoursnow == 22 and minutes > 30 ) or (hoursnow > 22)  or ( hoursnow < 7 )) and otherdevices_svalues['Clim Chambre Ventillation'] ~= '20' ) then
			print('22h31 Level to 20 and Temp to 21')
			--commandArray['SetSetPoint:428'] = '21' -- Temperature 21
                	commandArray[#commandArray +1]={['SetSetPoint:428']='21'}
			print('22h31 Set Mode Ventillation speed to 20 (Silence) ')
			--commandArray['Clim Chambre Ventillation'] = 'Set Level: 20'  -- Level Silence
               		commandArray[#commandArray +1]={['Clim Chambre Ventillation']='Set Level: 20'}
		end -- 22h30 to 6h59

		if ( ( minutes % 5 ) == 0 and hoursnow < 6 ) then
			if  nTempChbr < 21 and otherdevices['Clim Chambre Power'] == 'On' then
				print('nTempChbr ' .. nTempChbr .. ' < 21 lets Switch off ')
				--commandArray['Clim Chambre Power']='Off'
                		commandArray[#commandArray +1]={['Clim Chambre Power']='Off'}
			end
			if  nTempChbr >= 21 and otherdevices['Clim Chambre Power'] == 'Off' then
				print('nTempChbr ' .. nTempChbr .. ' > 21 lets Switch on ')
				--commandArray['Clim Chambre Power']='On'
                		commandArray[#commandArray +1]={['Clim Chambre Power']='On'}
			end
		end -- entre 0h00 et 6h50 si Temp < 21 Off, sinon On

		-- When to stop
		if ( hoursnow == 6 and IsWeekend() == 'False' ) or ( hoursnow == 7 and IsWeekend() == 'True' ) then
			if otherdevices['Clim Chambre Power'] == 'On' then
				print('Il est heure, switch off' )
                		--commandArray['Clim Chambre Power']='Off'
                		commandArray[#commandArray +1]={['Clim Chambre Power']='Off'}
			end
		end
        end -- Regulation entre 21h et 8h

	if ( DEBUG == 1 ) then print ('script_time_Clim.lua completed ...') end

return commandArray
