function Get-Wifikey {
# -----------------------------------------------------------
# création d'un dossier wifi sous temp\wifi
# -----------------------------------------------------------
new-item -Path c:\temp -Name wifi -Force -ItemType directory

# -----------------------------------------------------------
#netsh permet d'exporter les connexions wifi
# -----------------------------------------------------------
netsh wlan export profile key=clear folder="c:\temp\wifi" | Out-Null
# -----------------------------------------------------------
#on liste ensuite les fichiers xml sous temp\wifi
# -----------------------------------------------------------
#pour chaque fichier trouvé, on retourne le nom de la connexion, la clé,et le cryptage
# -----------------------------------------------------------
get-childitem c:\temp\wifi\*.xml | %{
   $xml=[xml](get-content $_)
write-host "connexion : " -nonewline ; write-host "$($xml.wLANProfile.name)".PadRight(25," ") -f green -NoNewline
write-host "--> Clé : " -nonewline ; write-host "$($xml.WLANProfile.MSM.security.sharedKey.keyMaterial)".PadRight(30," ") -f red -b gray -NoNewline
write-host " cryptage " -NoNewline; write-host $xml.WLANProfile.MSM.security.authEncryption.encryption -f gray  
    }
# -----------------------------------------------------------
#on efface ensuite tous les fichiers sous temp\wifi
#remove-item C:\temp\wifi\* -Confirm:$false
# -----------------------------------------------------------
}
Get-Wifikey