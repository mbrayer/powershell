$servName = Read-Host "Veuillez saisir le nom du service"
#test
Write-Host "Voici les services trouvés : "
$services = Get-Service "*$servName*"
if ($services.Count -gt 0)
{
    $count = 0;
    # Affichage des services trouvés
    foreach($serv in $services)
    {
        $count++
        Write-Host -foregroundcolor Red [$count] $serv.DisplayName - $serv.Name
        Write-Host -foregroundcolor Red "   " Status : $serv.Status
    }
   
    # Récupération de l'élément
    $servNum = Read-Host "Veuillez saisir le numéro du service  "
    $selectedService = $services[$servNum-1]
    if ($selectedService)
    {
        Write-Host -foregroundcolor Green Service sélectionné : $selectedService.Name
        # Selon l'état du service, proposer l'arrêt ou le démarrage
        switch ($selectedService.Status)
        {
            "Running" {
                $stopIt = Read-Host "Souhaitez-vous arrêter le service ? [O/N] : "
                if ($stopIt -like "o")
                {
                    Write-Host Arrêt du service
                    Stop-Service $selectedService.Name
                }
                else {
                    Write-Host Commande annulée
                }
            }
            "Stopped" {
                $startIt = Read-Host "Souhaitez-vous démarrer le service ? [O/N] : "
                if ($startIt -like "o")
                {
                    Write-Host Démarrage du service
                    Start-Service $selectedService.Name
                }
                else {
                    Write-Host Commande annulée
                }
            }
            default
            {
                Write-Host Le service ne peut pas être démarré ou arrêté
            }
        }
    }
    else
    {
        Write-Host Le numéro ne correspond pas à un des services listés
    }
}
else
{
    Write-Host Aucun service trouvé
}
