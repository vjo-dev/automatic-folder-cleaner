#cls

$clean_folder = "Z:\VJO\Cleaner"
$cleaned_folder = "Z:\VJO\Cleaned"
#$loop = 0

while (1)
{
    $items= (Get-ChildItem $clean_folder -recurse)

    if ($items.Length -ge 1)
    {


        foreach ($item in $items)
        {
            if (($item -is [System.IO.DirectoryInfo]))
            {
            #write-host "directory"
            $folder = $item
             $folder_content = (Get-ChildItem $folder.fullname -recurse)
             if ($folder_content.Length -eq 0)
             { #folder empty - remove it
             rm $folder.fullname
             }
             else #folder not empty - leave it to be sorted
             { 
             }
            }
            else #is a file therefore we manage it
            {
                $file = $item
                $name = $file.Name
                $extension = $file.extension
                $year = ($file.LastWriteTime).year
                $month = ($file.LastWriteTime).month
                #$day = ($file.LastWriteTime).day

                if ($extension -eq ".xlsm" -or $extension -eq ".xlsx" -or $extension -eq ".xlsx"){$extension_clean = "Excel"}
                elseif($extension-eq ".jpg" -or $extension -eq ".bmp" -or $extension -eq ".gif" -or $extension -eq ".tif" -or $extension -eq ".png"){$extension_clean = "Images"}
                elseif($extension-eq ".mov" -or $extension -eq ".wmv"){$extension_clean = "Videos"}
                elseif($extension-eq ".doc" -or $extension -eq ".docx"){$extension_clean = "Word"}
                elseif($extension-eq ".ps1"){$extension_clean = "Powershell"}
                elseif($extension-eq ".ppt" -or $extension -eq ".pptx"){$extension_clean = "PowerPoint"}
                elseif($extension-eq ".txt"){$extension_clean = "Textes"}
                elseif($extension-eq ".lnk"){$extension_clean = "Raccourcis"}
                else{$extension_clean = $extension}
        
                if ($extension_clean -eq $extension){$destination_path = $cleaned_folder + "\Autres\" + $extension +"\"}
                elseif ($extension_clean -eq "Images"){$destination_path = $cleaned_folder + "\" + $extension_clean +"\" + $year + "\" + $month + "\"}
                else {$destination_path = $cleaned_folder + "\" + $extension_clean +"\"}
                #$destination_path = $cleaned_folder + "\" + $extension_clean +"\" + $year + "\" + $month + "\" + $day + "\"

                if ((Test-Path $destination_path) -eq $false) {New-Item $destination_path -ItemType directory}

                $from = $file.FullName 
                $to = $destination_path + $name


                if ((Test-Path $to) -eq $true) #fichier non doublon
                {
                    $to = $file.fullname.Replace($extension, ("_COPIE" + $extension))
                }
            
                #write-host ""
                #$from
                #$to
                Move-Item -Path $from -Destination $to
            
                #write-host $name, $extension, $year, $month
            }

        }

    }
    else
    {
    #write-host "folder empty"
    }
    #LOOP THE PROGRAM
    #write-host "loop", $loop  
    #$loop = $loop + 1

    exit
    Start-Sleep 10
}          