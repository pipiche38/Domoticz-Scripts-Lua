
commandArray = {}

Monitored = 'Hue Lux'
Target1 = 'Volet Sud'

if (devicechanged[ Monitored ])  then
    print( 'Hue Lux - Date when update : ' .. otherdevices_lastupdate[ Monitored ] )
    print( '        - Action       : ' .. devicechanged[ Monitored ] )
    print( '        - Action Level : ' ..otherdevices_svalues[ Monitored ] )
end

lux = otherdevices_svalues[ Monitored ]
-- if lux  > '1400' then
--     commandArray[#commandArray +1]={['Volets Sud']='Set Level: 50'}
-- end

return commandArray
