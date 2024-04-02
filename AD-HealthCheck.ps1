<#
.DESCRIPTION
    Script for health check domain controllers and domains.
.AUTHOR
    G0urmetD (403 - Forbidden)
#>
#Requires -RunAsAdministrator

function Check-Replication {
    # check the replication status of all the domain controllers
    Repadmin /replsummary
}

function Check-Services {
    # check several Active Directory services
    $Services = 'DNS','ADWS','DFSR','DHCP','NetLogon','GPSVC','KDC','MPSSVC','NTDS'
    ForEach ($Service in $Services) {
        Get-Service $Service | Select-Object Name,Status,DisplayName
    }
}

function Check-UnsecureLDAPBinds {
    # detect unsecure LDAP binds
    Get-WinEvent -FilterHashtable @{
                    LogName = 'Security'
                        ID = 2889
                    }
}

function Check-DomainControllerAndDNS {
    # test several aspects of a domain controller including DNS
    DCDiag /Test:DNS /e /v
}

# main script
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Domain Controller Health Check:"
Check-Replication
Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Domain Controller & DNS Test:"
Check-DomainControllerAndDNS
Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Find unsecure LDAP binds:"
Check-UnsecureLDAPBinds
Write-Output "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
Write-Host -ForegroundColor Blue "[*]" -NoNewline
Write-Host " Domain & Domain Controller Services:"
Check-Services
