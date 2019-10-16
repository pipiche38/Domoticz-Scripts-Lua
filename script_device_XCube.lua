
commandArray = {}

XCube = 'XCube'
Target1 = 'Lampe Salon'
Target2 = 'Lampe Salle a Manger'

if (devicechanged[ XCube ])  then
    print( 'Date when update : ' .. otherdevices_lastupdate[ XCube ] )
    print( 'Action       : ' .. devicechanged[ XCube ] )
    print( 'Action Level : ' ..otherdevices_svalues[ XCube ] )
    if devicechanged[ XCube ] == 'Clock_Wise' then
	if otherdevices[ Target1 ] == 'Off' then
		commandArray[ Target1 ] = 'On'
	end
	if otherdevices[ Target1 ] == 'On' then
		commandArray[ Target1 ] = 'Off'
	end
    end
    if devicechanged[ XCube ] == 'Anti_Clock_Wise' then
	if otherdevices[ Target1 ] == 'Off' then
		commandArray[ Target1 ] = 'On'
	end
	if otherdevices[ Target1 ] == 'On' then
		commandArray[ Target1 ] = 'Off'
	end
    end
    if devicechanged[ XCube ] == 'Flip_90' then
	if otherdevices[ Target2 ] == 'On' then
		commandArray[ Target2 ] = 'Off'
	end
	if otherdevices[ Target2 ] == 'Off' then
		commandArray[ Target2 ] = 'On'
	end
    end
    if devicechanged[ XCube ] == 'Flip_180' then
	if otherdevices[ Target2 ] == 'On' then
		commandArray[ Target2 ] = 'Off'
	end
	if otherdevices[ Target2 ] == 'Off' then
		commandArray[ Target2 ] = 'On'
	end
    end
end

return commandArray
