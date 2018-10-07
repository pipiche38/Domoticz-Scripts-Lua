
-- Variables to customize ------------------------------------------------
local DEBUG = 0             -- 0 , 1

-- Below , edit at your own risk ------------------------------------------

local PresenceAnnieClaude = '/'
local PresencePatrick = '/'
local PresencePipiche = '/'
local PresenceNicolas = '/'
local newPresence = 0
local prevPresence = 0

function timedifference(s)
   year = string.sub(s, 1, 4)
   month = string.sub(s, 6, 7)
   day = string.sub(s, 9, 10)
   hour = string.sub(s, 12, 13)
   minutes = string.sub(s, 15, 16)
   seconds = string.sub(s, 18, 19)
   t1 = os.time()
   t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
   difference = os.difftime (t1, t2)
   return difference  --le résultat retourné est en secondes
end
--[[ usage :
        DATE = "2018-04-29 16:57:18"
        print(timedifference(DATE))
--]]
--
-- Main Programme
--

commandArray = {}

	if ( DEBUG == 1 ) then print ('Starting script_time_Presence.lua ') end
	if (uservariables['PresenceAtHome'] == nil) then print("Error : Did you create the Uservariable PresenceAtHome ?") end

	-- Previous presence
	prevPresence = uservariables['PresenceAtHome'] 
	if ( DEBUG == 1 ) then print('Past presence was      - ' .. prevPresence ) end

	if timedifference(otherdevices_lastupdate['Pipiche iPhoneX']) > 300  then
		if ( DEBUG == 1 ) then print('Last status for Pipiche iPhoneX is > 300; Presence is valid' ) end
		PresencePipiche = otherdevices['Pipiche iPhoneX'] 
	end
	if timedifference(otherdevices_lastupdate['Patrick iPhone6']) > 300  then
		if ( DEBUG == 1 ) then print('Last status for Patrick iPhone6 is > 300; Presence is valid' ) end
		PresencePatrick = otherdevices['Patrick iPhone6'] 
	end

	if timedifference(otherdevices_lastupdate['Annie-Claude iPhone6']) > 300  then
		if ( DEBUG == 1 ) then print('Last status for Annie-Claude iPhone6 is > 300; Presence is valid' ) end
		PresenceAnnieClaude = otherdevices['Annie-Claude iPhone6']
	end

	if timedifference(otherdevices_lastupdate['Nicolas iPhone6S']) > 300  then
		if ( DEBUG == 1 ) then print('Last status for Nicolas iPhone6S is > 300; Presence is valid' ) end
		PresenceNicolas = otherdevices['Nicolas iPhone6S']
	end

	-- Updating Presence

	if ( PresencePatrick == 'On' ) then newPresence = newPresence + 1 end
	if ( PresenceAnnieClaude == 'On' ) then newPresence = newPresence + 1 end
	if ( PresenceNicolas == 'On' ) then newPresence = newPresence + 1 end
	if ( PresencePipiche == 'On' ) then newPresence = newPresence + 1 end

	if ( PresencePatrick == 'Off' and PresenceAnnieClaude == 'Off' and PresenceNicolas == 'Off') then newPresence = 0 end

	if ( DEBUG == 1 ) then
                print('Status Patrick iPhone6      - ' .. PresencePatrick )
                print('Status Annie-Claude iPhone6 - ' .. PresenceAnnieClaude )
                print('Status Nicolas iPhone6S - ' .. PresenceNicolas )
                print('Status Pipiche iPhoneX - ' .. PresencePipiche )
		print('Status prevPresence             - ' .. prevPresence )
		print('Status newPresence             - ' .. newPresence )
	end

	if (uservariables["PresenceAtHome"] ~= newPresence) then 
		print('Presence update from ' .. prevPresence  .. ' to ' .. newPresence )
		commandArray['Variable:PresenceAtHome'] = tostring(newPresence)   
	end

return commandArray
