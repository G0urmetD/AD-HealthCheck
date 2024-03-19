![HealtCheckIcon](health-check.png)
# AD-HealthChek
This PowerShell script performs a comprehensive health check on both the domain and domain controllers, ensuring the overall stability and integrity of the network infrastructure. It examines various critical aspects such as connectivity, replication, and service status to provide a comprehensive overview of the system's health.

# Functionalities
- Domain Controller Health Check
- Domain & Domain Controller Services
  - Checks if all necessary services for a proper domain are running
- Domain Controller & DNS Test
- Find unsecure LDAP binds
- Checking Domain Controller Replication
  - Using Repadmin to identify domain controllers that are failing inbound/outbound replication [https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc835092(v=ws.11)]

# Usage
The script needs to run as Administrator on the Domain Controller.
```PowerShell
.\AD-HealtCheck.ps1
```
# Notes
- If bugs occur, please create an issue.
- For further functionalities/feature requests, please create an issues as enhacement
