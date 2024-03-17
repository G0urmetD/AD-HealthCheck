<#
.DESCRIPTION
    Script for health check domain controllers and domains.
.AUTHOR
    G0urmetD (403 - Forbidden)
#>
#Requires -RunAsAdministrator
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Domain Controller Health Check:"
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Domain & Domain Controller Services:"
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Domain Controller & DNS Test:"
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Find unsecure LDAP binds:"
Write-Output ""

Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Output "[*] Checking Domain Controller Replication:"
# check the replication status of all the domain controllers
Repadmin /replsummary

Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Output "[*] Checking Domain and Domain Controller Services:"
# check several Active Directory services
$Services = 'DNS','ADWS','DFSR','DHCP','NetLogon','GPSVC','KDC','MPSSVC','NTDS'
ForEach ($Service in $Services) {Get-Service $Service | Select-Object Name, Status,DisplayName}

Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Output "[*] Checking for unsecure LDAP binds:"
# detect unsecure LDAP binds
Get-WinEvent -FilterHashtable @{
                LogName = 'Security'
                    ID = 2889
                }

Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Output "[*] Domain Controller test including DNS:"
# test several aspects of a domain controller including DNS
DCDiag /Test:DNS /e /v
