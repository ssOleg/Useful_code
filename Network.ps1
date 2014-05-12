$ob = [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces()
#$ob | % {$_.Description, $_.OperationalStatus, $_.Name, $_.Id, '~~~~~~~~~~~~~';}

$os1 = $ob | % {$net=(Get-WmiObject -Query "Select Description, Index, InterfaceIndex, GUID from win32_NetworkAdapter where GUID = '$($_.Id)'"); $net.Description, $net.Index,'~~~~~~~~~~~~~~~~~' , $_.OperationalStatus, $_.Id, $_.Description, $_.Name, '************';}
$os1

$os2 = $ob | % {$netcon=(Get-WmiObject -Query "Select Caption, Index, InterfaceIndex from win32_NetworkAdapterConfiguration where SettingID = '$($_.Id)'"); $netcon.Caption, $netcon.Index, '~~~~~~~~~~~~~~~~~' , $_.OperationalStatus, $_.Id, $_.Description, $_.Name, '************';}
$os2


# $statistic = [System.Net.NetworkInformation.IPGlobalStatistics]
# Get-WmiObject Win32_NetworkAdapterConfiguration | Format-List *

$n = Get-WmiObject win32_NetworkAdapter
$nc = Get-WmiObject win32_NetworkAdapterConfiguration


## Get unique counters
#((Get-Counter '\Network Interface(*)\*').CounterSamples | gu)
$c = (((Get-Counter '\Network Interface(*)\*').CounterSamples | % {$_.InstanceName}) | gu)

[System.Diagnostics.PerformanceCounter]
[System.Diagnostics.PerformanceCounter].DeclaredMethods
[System.Diagnostics.PerformanceCounter] | gm -MemberType Method
[System.Diagnostics.PerformanceCounter] | gm -MemberType Property

Get-Counter -ListSet '*network*' | Sort-Object CounterSetName | Select-Object CounterSetName

Get-Counter -ListSet 'Network Interface' | Select-Object -ExpandProperty Counter

Get-Counter -ListSet 'Network Interface' | Select-Object -ExpandProperty PathsWithInstances

Get-WmiObject Win32_PerfRawData_Tcpip_NetworkInterface | Select-Object -Property Name

(Get-WmiObject Win32_PerfRawData_Tcpip_NetworkInterface | Select-Object Name) |%{$_.Name -like '*isatap.*'}

(Get-WmiObject -Query 'select * from Win32_PerfRawData_Tcpip_NetworkInterface where Name like "%isatap%"')



## Get all Win32_network counter types
Clear-Host 
$i=0 
$Type = "Win32_network" 
$WMI = Get-WmiObject -List | Where-Object {$_.name -Match $Type}
Foreach ($Class in $WMI) {$Class.name; $i++}
Write-Host 'There are' $i' types of '$Type





Get-WmiObject -Query "Select * from win32_NetworkAdapter" | Format-List GUID, Name, Description, Caption, DeviceID, Index, InterfaceIndex, ProductName, NetConnectionID

Get-WmiObject -Query "Select * from win32_NetworkAdapterConfiguration" |Format-List SettingID, Description, Caption, Index, InterfaceIndex, ServiceName



$a = (Get-WmiObject -Query "Select GUID, Name, Description, Caption, DeviceID, Index, InterfaceIndex, ProductName, NetConnectionID from win32_NetworkAdapter") 

$b = (Get-WmiObject -Query "Select SettingID, Description, Caption, Index, InterfaceIndex, ServiceName from win32_NetworkAdapterConfiguration")


## Get NetAdapter from register
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\" +
        "{4D36E972-E325-11CE-BFC1-08002BE10318}"
Get-Childitem $path -ErrorAction SilentlyContinue | Foreach {$_, '------------'}


get-childitem 'HKLM:\SYSTEM\CurrentControlSet\Services\Blfp\Parameters\Adapters'| foreach-object {get-itemproperty $_.pspath}