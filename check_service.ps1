function FuncCheckService{
    param([string]$service)
    $GetService = Get-Service -Name $service
    $wayArchiveRun  = "C:\LOG\ServiceRun$service.txt"
	$wayArchiveStop = "C:\LOG\ServiceStop$service.txt"
    if ($GetService.Status -eq "Running"){ 
        if ( Test-Path $wayArchiveRun ){
        }else{
            archive -status run
        }
    }
    if ($GetService.Status -eq "Stopped"){ 
        if ( Test-Path $wayArchiveStop ){
        }else{
            archive -status stop
        }
    }
}

function archive{
    $date = (get-date).ToString('dd/MM/yyyy HH:mm:ss')
    param([string]$status)
    if($status -eq "run"){
        Write-Host "The service $service : $date : RUN"
        if ( Test-Path $wayArchiveStop ){
            $wayArchiveStop | del
        }
        $f = new-object System.IO.FileStream $wayArchiveRun, Create, ReadWrite
        $f.Close()
    }
    if($status -eq "stop"){
        Write-Host "The service $service : $date : STOP"
        if ( Test-Path $wayArchiveRun ){
            $wayArchiveRun | del
        }
        $f = new-object System.IO.FileStream $wayArchiveStop, Create, ReadWrite
        $f.Close()
    }
}

FuncCheckService -service Spooler
FuncCheckService -service Mysqld
