
commandArray = {}

if (devicechanged[ 'MS1 - Sensor' ])  then
    -- print( 'Date when update : ' .. otherdevices_lastupdate[ 'MS1 - Sensor' ] )
    -- print( 'Action       : ' .. devicechanged[ 'MS1 - Sensor' ] )
    -- print( 'Action Level : ' ..otherdevices_svalues[ 'MS1 - Sensor' ] )
    -- print( 'Ampoule Blanche: ' ..otherdevices[ 'Ampoule Blanche' ] )
    if devicechanged[ 'MS1 - Sensor' ] == 'On' and otherdevices['Ampoule Blanche'] == 'Off' then
    	commandArray[#commandArray +1]  = { [ 'Ampoule Blanche' ] = 'On FOR 1' }
    end
end

return commandArray
