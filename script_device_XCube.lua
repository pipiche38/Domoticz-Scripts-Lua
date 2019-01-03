
commandArray = {}

XCube = 'ZigateWifi - XCube'
Target1 = 'ZigateWifi - Sapin'
Target2 = 'Zigate - Lampes Salon'
Target3 = 'Yamaha - Main'

if (devicechanged[ XCube ])  then
    print( 'Date when update : ' .. otherdevices_lastupdate[ XCube ] )
    print( 'Action       : ' .. devicechanged[ XCube ] )
    print( 'Action Level : ' ..otherdevices_svalues[ XCube ] )
    if devicechanged[ XCube ] == 'Clock_Wise' then
    	commandArray[ Target1 ] = 'On'
    end
    if devicechanged[ XCube ] == 'Anti_Clock_Wise' then
    	commandArray[ Target1 ] = 'Off'
    end
    if devicechanged[ XCube ] == 'Tap' then
    	commandArray[ Target2 ] = 'On'
    end
    if devicechanged[ XCube ] == 'Move' then
    	commandArray[ Target2 ] = 'Off'
    end
    if devicechanged[ XCube ] == 'Free_Fall' then
    	commandArray[ Target3 ] = 'On'
    end
    if devicechanged[ XCube ] == 'Shake' then
    	commandArray[ Target3 ] = 'Off'
    end
end

return commandArray
