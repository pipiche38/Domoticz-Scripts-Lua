-- Variables to customize ------------------------------------------------
local DEBUG = 0             -- 0 , 1
local CHATSMETSALON = 0          -- O Close the Volets, 1 leave it a bit open

-- Below , edit at your own risk ------------------------------------------


function GroupState(sArray)
        -- Checks the state of a group of swithces.
        -- USAGE   : GroupState({'Switch1','Switch2','Switch3','Switch4','Switch5',more switches})
        -- RETURNS : 'On'       if all switches are on.
        --         : 'Off'      if all switches are off.
        --         : 'Mixed"    if one or more, but not all switches are on.
        --
        local iOpen = 0  -- Number of device On
	local iOnOff = 0  -- Number of devices not fully open
        local iCount = 0  -- Number of devices to check
        local sState = '' -- Final state to return

        for i,switch in pairs(sArray) do
     	      --print('Status :' .. switch .. ' ' .. otherdevices[switch] .. ' ' .. otherdevices_svalues[switch] .. ' %')
                if ((otherdevices[switch] == 'Open') and (otherdevices_svalues[switch] ~= 'On') ) then
			iOnOff = iOnOff + 1
		end
                if ((otherdevices[switch] == 'Open') and (otherdevices_svalues[switch] == 'On' )) then
                        iOpen = iOpen + 1
                end
        	iCount = iCount + 1
        end

        if ((iOpen == 0) and (iOnOff == 0)) then sState = 'Off' end
        if (iOnOff > 0) or (iOpen > 0 ) then sState = 'Mixed' end
        if (iOpen == iCount) then sState = 'On' end

      --print("iCount   : " .. iCount)
      --print("iOnOff   : " .. iOnOff)
      --print("iOpen   : " .. iOpen)
      --print("sState   : " .. sState)
        return sState
end

function WhichSeason()
     local tNow = os.date("*t")
     local dayofyear = tNow.yday
     local season
     season = otherdevices_svalues['Saison']
	if season == "10" then return 'Hiver' end
	if season == "20" then return 'Printemps' end
	if season == "30" then return 'Ete' end
	if season == "40" then return 'Autonme' end
     
     return ''
end

function IsWeekend()
     local dayNow = tonumber(os.date("%w"))
     local weekend
     if (dayNow == 0) or (dayNow == 6) then weekend = "True"
     else weekend = "False"
     end 
     return weekend
end

function IsAdelia()
     local dayNow = tonumber(os.date("%w"))
     local adelia
     if (dayNow == 2) then adelia = "True"
     else adelia = "False"
     end 
     return adelia
end


--
-- Main Programme
--
--local OffCmd = 'Off RANDOM 3'
--local OnCmd = 'On RANDOM 3'
--local SetLevelCmd = ' RANDOM 3'
local OffCmd = 'Off'
local OnCmd = 'On'
local SetLevelCmd = ''

local AutoSalon = 'Off'
local AutoSM = 'Off'
local AutoChbParent = 'Off'
local AutoBureau = 'Off'
local AutoChbrPhilippe = 'Off'
local AutoChbrNico = 'Off'

VoletsNord  =  {'Volet Chambre Philippe','Volet Chambre Nico','Volet Cuisine'}
VoletsSud   =  {'Volet Bureau','Volet Chambre Parents','Volet Salon', 'Volet Salle a Manger'}


local hourOpeningMorningSejour = 7
local minutesOpeningMorningSejour = 0
local hourCloseEveningSejour = 23
local minutesCloseEveningSejour = 0

local hourOpeningMorningChbrs = 7
local minutesOpeningMorningChbrs = 30
local hourCloseEveningChbrs = 22
local minutesCloseEveningChbrs = 0
local Presence = 0

commandArray = {}

        if otherdevices['@HOME'] == 'On' then
                VACANCES = 0
        else
                VACANCES = 1
        end

	if ( VACANCES == 1 ) then
		OffCmd = 'Off RANDOM 30'
		OnCmd = 'On RANDOM 30'
		SetLevelCmd = ' RANDOM 30'
	end

	if ( IsWeekend() == 'True' ) then
		hourOpeningMorningSejour = 8
 		minutesOpeningMorningSejour = 30
 		hourCloseEveningSejour = 23
 		minutesCloseEveningSejour = 0

 		hourOpeningMorningChbrs = 9
 		minutesOpeningMorningChbrs = 0
		hourCloseEveningChbrs = 22
 		minutesCloseEveningChbrs = 0
	end

        if (uservariables['PresenceAtHome'] == nil) then print("Error : Did you create the Uservariable PresenceAtHome ?") end
        Presence = uservariables['PresenceAtHome']


	-- get current time
	timenow = os.date("*t")
	minutesnow = timenow.min + timenow.hour * 60
	minutes = timenow.min
	hoursnow = timenow.hour


	if ( DEBUG == 2 ) then 
		print ('Starting script_time_VoletsMgt.lua at ' .. hoursnow ..  ':' .. minutes .. ' (' .. minutesnow .. 'mins) - Sunrise: ' ..timeofday['SunriseInMinutes'].. ' Sunset: ' ..timeofday['SunsetInMinutes'] .. ' Pres(' .. Presence .. ')' ) 
	end

	AutoChbrParent = otherdevices['Mode Auto Chambre Parent']
	AutoChbrNico = otherdevices['Mode Auto Chambre Nico']
	AutoChbrPhilippe = otherdevices['Mode Auto Chambre Philippe']
	AutoCuisine = otherdevices['Mode Auto Cuisine']
	AutoBureau = otherdevices['Mode Auto Bureau']
	AutoSalon = otherdevices['Mode Auto Salon']
	AutoSM = otherdevices['Mode Auto Salle a Manger']

	if ( DEBUG == 2 ) then
		print('Auto Parent ' .. AutoChbrParent )
		print('Auto Nico ' .. AutoChbrNico)
		print('Auto Philippe '.. AutoChbrPhilippe)
		print('Auto Bureau ' .. AutoBureau)
		print('Auto Cuisine ' .. AutoCuisine)
		print('Auto Salon ' .. AutoSalon)
		print('Auto SM ' .. AutoSM )
	end

	-- Gestion SM
	if ( AutoSM == 'On' ) then
		if ((hoursnow == hourOpeningMorningSejour) and (minutes == minutesOpeningMorningSejour)) then
			commandArray[#commandArray +1]={['Volet Salle a Manger']=OnCmd}
			print('Ouvrir Volet SM')
		end
		if ((hoursnow == hourCloseEveningSejour) and (minutes == minutesCloseEveningSejour)) then
			if ( CHATSMETSALON == 1 ) then
				commandArray[#commandArray +1]={['Volet Salle a Manger']='Set Level: 25' .. SetLevelCmd}
			else
				commandArray[#commandArray +1]={['Volet Salle a Manger']=OffCmd}
			end
			print('Fermeture Volet SM')
		end
	end

	-- Gestion Salon
	if ( AutoSalon == 'On' ) then
		if ((hoursnow == hourOpeningMorningSejour) and (minutes == minutesOpeningMorningSejour)) then
			commandArray[#commandArray +1]={['Volet Salon']=OnCmd}
			print('Ouvrir Volet Salon')
		end
		if ((hoursnow == hourCloseEveningSejour) and (minutes == minutesCloseEveningSejour)) then
			if ( CHATSMETSALON == 1 ) then
				commandArray[#commandArray +1]={['Volet Salon']='Set Level: 25' .. SetLevelCmd}
			else
				commandArray[#commandArray +1]={['Volet Salon']=OffCmd}
			end
			print('Fermeture Volet Salon')
		end
	end

	-- Gestion Cuisine
	if ( AutoCuisine == 'On' ) then
		if (minutesnow == timeofday['SunriseInMinutes']) then
			print('Ouverture Volet Cuisine')
			commandArray[#commandArray +1]={['Volet Cuisine']=OnCmd}
		end
		if ( WhichSeason() == "Ete" and ((hoursnow == 9 ) and (minutes == 45))) then
			print('Ouverture Volet Cuisines à 25%')
			commandArray[#commandArray +1]={['Volet Cuisine']='Set Level: 25' .. SetLevelCmd}
		end
		if ((hoursnow == 22 ) and (minutes == 15)) then
			print('Fermeture Volet Cuisine')
			commandArray[#commandArray +1]={['Volet Cuisine']=OffCmd}
		end
	end

	-- Gestion Chambre Parent
	if ( AutoChbrParent == 'On' ) then
		if ( VACANCES == 1 and (minutesnow == timeofday['SunriseInMinutes']+50)) then
			print('Ouverture Volet Chambre Parent')
			commandArray[#commandArray +1]={['Volet Chambre Parent']='Set Level: 50' .. SetLevelCmd}
		end
		if ( VACANCES == 1 and (hoursnow == hourOpeningMorningChbrs ) and (minutes == minutesOpeningMorningChbrs)) then
			print('Ouverture Volet Chambre Parent à 100%')
			commandArray[#commandArray +1]={['Volet Chambre Parent']=OnCmd}
		end
		if (minutesnow == timeofday['SunsetInMinutes'] +30 ) then
			print('Fermeture Volet Chambre Parent')
			commandArray[#commandArray +1]={['Volet Chambre Parents']=OffCmd}
		end
	end

	-- Gestion Volet Bureau
	if ( AutoBureau == 'On' ) then
		if ((hoursnow == hourOpeningMorningChbrs ) and (minutes == minutesOpeningMorningChbrs)) then
			print('Ouverture Volet Bureau à 100%')
			commandArray[#commandArray +1]={['Volet Bureau']=OnCmd}
		end
		if (minutesnow == timeofday['SunsetInMinutes'] +30 ) then
			print('Fermeture Volet Bureau')
			commandArray[#commandArray +1]={['Volet Bureau']=OffCmd}
		end
	end

	-- Gestion Volet Chambre Philippe
	if ( AutoChbrPhilippe == 'On' ) then
		if ( WhichSeason() == "Ete" and (minutesnow == timeofday['SunriseInMinutes']+30)) then
			print('Ouverture Volet Chambre Philippe 50%')
			commandArray[#commandArray +1]={['Volet Chambre Philippe']='Set Level: 50' .. SetLevelCmd}
		end
		if ((hoursnow == hourOpeningMorningChbrs ) and (minutes == minutesOpeningMorningChbrs)) then
			print('Ouverture Volet Philippe à 100%')
			commandArray[#commandArray +1]={['Volet Chambre Philippe']=OnCmd}
		end
		if ( WhichSeason() == "Ete" and ((hoursnow == 9 ) and (minutes == 45))) then
			print('Ouverture Volet Philippe à 25%')
			commandArray[#commandArray +1]={['Volet Chambre Philippe']='Set Level: 25' .. SetLevelCmd}
		end
		if (minutesnow == timeofday['SunsetInMinutes'] +30 ) then
			print('Fermeture Volet Chambre Philippe')
			commandArray[#commandArray +1]={['Volet Chambre Philippe']=OffCmd}
		end
	end

	-- Gestion Volet Chambre Nico
	if ( AutoChbrNico == 'On' ) then
		if ( WhichSeason() == "Ete" and (minutesnow == timeofday['SunriseInMinutes']+30)) then
			print('Ouverture Volet Chambre Nico 50%')
			commandArray[#commandArray +1]={['Volet Chambre Nico']='Set Level: 50' .. SetLevelCmd}
		end
		if ((hoursnow == hourOpeningMorningChbrs ) and (minutes == minutesOpeningMorningChbrs)) then
			print('Ouverture Volet Nico à 100%')
			commandArray[#commandArray +1]={['Volet Chambre Nico']=OnCmd}
		end
		if ( WhichSeason() == "Ete" and ((hoursnow == 9 ) and (minutes == 45))) then
			print('Ouverture Volet Nico à 25%')
			commandArray[#commandArray +1]={['Volet Chambre Nico']='Set Level: 25' .. SetLevelCmd}
		end

		if (minutesnow == timeofday['SunsetInMinutes'] +30 ) then
			print('Fermeture Volet Chambre Nico')
			commandArray[#commandArray +1]={['Volet Chambre Nico']=OffCmd}
		end
	end


	-- Gestion du Soleil
	tempExt = otherdevices_svalues['Exterieur']
	lumino = otherdevices_svalues['Lux']
	nLumino = tonumber(lumino)
        sTempExt, sHumidityExt = tempExt:match("([^;]+);([^;]+)")
        nTempExt = tonumber(sTempExt)
        nHumidityExt = tonumber(sHumidityExt)
	if ( DEBUG == 2 ) then
        	print('Temp Ext: ' .. nTempExt)      -- print temperature
        	print('Humidity Ext: ' .. nHumidityExt)  -- print humidity
        	print('Luminosité Ext: ' .. nLumino)  -- print Luminosité
	end

	if  WhichSeason() == "Ete"  then
		if ( Presence == 1 or Presence == 0 ) and ( (hoursnow > 9 and hoursnow < 12 and minutes == 0 ) or ( hoursnow >= 14 and hoursnow < 19 and minutes == 0 )) then
			setLevelVolet='100'
			if nTempExt > 26 and nTempExt < 28 then setLevelVolet='50' end
			if nTempExt > 28 and nTempExt < 32 then setLevelVolet='30' end
			if nTempExt >= 32                  then setLevelVolet='0' end
	
			if (( nTempExt > 26 ) or ( nLumino > 35000 )) then
				if ( AutoChbrNico == 'On' ) then
					commandArray[#commandArray +1]={['Volet Chambre Nico']='Set Level: ' .. setLevelVolet .. SetLevelCmd}
				end
				if ( AutoChbrPhilippe == 'On' ) then
					commandArray[#commandArray +1]={['Volet Chambre Philippe']='Set Level: ' .. setLevelVolet .. SetLevelCmd}
				end
				if ( AutoCuisine == 'On' ) then
					commandArray[#commandArray +1]={['Volet Cuisine']='Set Level: ' .. setLevelVolet .. SetLevelCmd}
				end
				if ( AutoChbrParent == 'On' ) then
					commandArray[#commandArray +1]={['Volet Chambre Parents']='Set Level: ' .. setLevelVolet .. SetLevelCmd}
				end
				if ( AutoBureau == 'On'  and otherdevices['Patrick iPhone6'] == 'Off' ) then
					commandArray[#commandArray +1]={['Volet Bureau']='Set Level: ' .. setLevelVolet .. SetLevelCmd}
				end
				if (( IsWeekend() == "False" and IsAdelia() == "False") or ( VACANCES == 1 )) then
					if ( AutoSalon == 'On' ) then
						commandArray[#commandArray +1]={['Volet Salon']='Set Level: '.. setLevelVolet  .. SetLevelCmd}
					end
					if ( AutoSM == 'On' ) then
						commandArray[#commandArray +1]={['Volet Salle a Manger']='Set Level: ' .. setLevelVolet .. SetLevelCmd}
					end
				end -- IsWeekend
			end -- > 25° or Lux > 35K
		end -- Presence == 1 or Presence == 0 ) and ( hoursnow > 14 and hoursnow < 19 and minutes == 0
	end -- WhichSeason


	if ( DEBUG == 2 ) then
		print(' Status des Volets Nord : ' .. GroupState(VoletsNord)  )
		print(' Status des Volets Sud  : ' .. GroupState(VoletsSud)  )
		print(' SunriseInMinutes : ' ..  timeofday['SunriseInMinutes'] )
		print(' SunsetInMinutes  : ' ..  timeofday['SunsetInMinutes'] )
	end

return commandArray
