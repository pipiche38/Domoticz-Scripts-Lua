
commandArray = {}

if devicechanged['Zigate - Aqara-7b6a-01']  then
    print( 'Date when update : ' .. otherdevices_lastupdate['Zigate - Aqara-7b6a-01'] )
    print( 'Action       : ' .. devicechanged['Zigate - Aqara-7b6a-01'] )
    print( 'Action Level : ' ..otherdevices_svalues['Zigate - Aqara-7b6a-01'] )
end

return commandArray
