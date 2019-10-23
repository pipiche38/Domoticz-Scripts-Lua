
-- Variables to customize ------------------------------------------------
local DEBUG = 2             -- 0 , 1

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

	if ( DEBUG == 2 ) then print ('Starting script_time_Yamaha.lua ') end

        -- get current time
        timenow = os.date("*t")
        minutesnow = timenow.min + timenow.hour * 60
        minutes = timenow.min
        hoursnow = timenow.hour

	if otherdevices['Mode Auto Ampli/Music'] == 'Off' then
		return
	end

	if ( IsWeekend() == "True" and hoursnow == 9 and minutes == 0 and otherdevices['Anyone@Home'] == 'On') then
		-- switch on Music
		commandArray['Yamaha - Main']='On'
		commandArray['Yamaha - Volume Main']='Set Level 30'
		print('Switch On Music because ' .. otherdevices['Anyone@Home'] )
	end
	if ( IsWeekend() == "False" ) then 
		if ( hoursnow == 8 and minutes == 0 and otherdevices['Anyone@Home'] == 'On' )  then
			-- switch on Music
			commandArray['Yamaha - Main']='On'
			commandArray['Yamaha - Volume Main']='Set Level 30'
			print('Switch On Music because ' .. otherdevices['Anyone@Home'] )
		end
		if ( hoursnow == 18 and otherdevices['Anyone@Home'] == 'On' ) then
                        -- switch on Music
                        commandArray['Yamaha - Main']='On'
			commandArray['Yamaha - Volume Main']='Set Level 30'
			print('Switch On Music because ' .. otherdevices['Anyone@Home'] )
                end
	end
	if otherdevices['Anyone@Home'] == 'Off' then
		commandArray['Yamaha - Main']='Off'
                print('Switch Off Music as Anyone@Home is ' .. otherdevices['Anyone@Home'])
	end

return commandArray
