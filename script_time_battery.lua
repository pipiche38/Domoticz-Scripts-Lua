-- =========================================
-- Check battery level for all used devices
-- =========================================

-- User Configuration
BatteryThreshold = 40
WeeklySummary = true
SummaryDay = 1 -- Sunday is 1
EmailTo = "support@pichon.me"
ReportHour = 9
ReportMinute = 01
Domoticz = "localhost"
DomoticzPort = "8080"
Message = ''

json = (loadfile "/var/lib/domoticz/scripts/lua/JSON.lua")()  -- For Linux

commandArray = {}

time = os.date("*t")

-- Weekly Device Battery Summary
if WeeklySummary == true and time.wday == SummaryDay and time.hour == ReportHour and time.min == ReportMinute then
 
    -- Get a list of all devices
    handle = io.popen("curl 'http://" .. Domoticz .. ":" .. DomoticzPort .. "/json.htm?type=devices&order=name'")
    devicesJson = handle:read('*all')
    handle:close()
    devices = json:decode(devicesJson)
    BattToReplace = false
    for i,device in ipairs(devices.result) do
        if device.BatteryLevel <= 100 and device.Used == 1 then
            Message = Message .. device.Name .. ' battery level is ' .. device.BatteryLevel .. '%<br>'
            print(device.Name .. ' battery level is ' .. device.BatteryLevel .. '%')
        end
    end
    commandArray['SendEmail']='Domoticz Battery Levels#'.. Message .. '#' .. EmailTo

-- Daily Low Battery Report
elseif time.hour == ReportHour and time.min == ReportMinute then
 
    -- Get a list of all devices
    handle = io.popen("curl 'http://" .. Domoticz .. ":" .. DomoticzPort .. "/json.htm?type=devices&order=name'")
    devicesJson = handle:read('*all')
    handle:close()
    devices = json:decode(devicesJson)
    BattToReplace = false
    for i,device in ipairs(devices.result) do
        if device.BatteryLevel < BatteryThreshold and device.Used == 1 then
            Message = Message .. device.Name .. ' battery level is ' .. device.BatteryLevel .. '%<br>'
            print(device.Name .. ' battery level is ' .. device.BatteryLevel .. '%')
        end
    end
    commandArray['SendEmail']='Domoticz Battery Levels#'.. Message .. '#' .. EmailTo
 
end

return commandArray
