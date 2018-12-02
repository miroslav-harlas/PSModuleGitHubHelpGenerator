[CmdletBinding(SupportsShouldProcess=$true,
               ConfirmImpact='High')]
param
(
    [System.String]$ModuleName = 'PSScheduledJob',
    [system.Version]$ModuleVersion,
    [System.String]$Path = 'C:\Users\harlas\source\repos\PSModuleGitHubHelpGenerator\Help',
    [System.String]$ProjectName = "PSScheduledJob",
    [System.String]$ProjectDefaultPageInRoot = "ReadMe.md"
)

begin
{
    Write-Verbose "######################################################"
    Write-Verbose " Powershell Script: $($MyInvocation.MyCommand.Name)"
    Write-Verbose " Script started with a following parameters:"
    Write-Verbose " Target Module Name: $ModuleName"
    Write-Verbose " Target Module Version: $ModuleVersion"
    Write-Verbose " Path for exporting help files: $Path"
    Write-Verbose "######################################################"
    Write-Verbose ""
}
process
{
    
    $TargetModules = @()
    $TargetModule = $null

    Write-Verbose "Looking for available PowerShell modules with name '$ModuleName'."
    # Find module by name
    $TargetModules += Get-Module -ListAvailable -Name $ModuleName
    If($TargetModules -eq $null)
    {
        Write-Error "Cannot find PowerShell module with a name '$ModuleName'."
    }
    Else
    {
        # filter module based on version
        If($ModuleVersion -ne $null)
        {
            Write-Verbose "Checking if Powershell module '$ModuleName' is available in version '$ModuleVersion'."
            $TargetModule = $TargetModules | Where-Object Version -eq $ModuleVersion 
        }
        Else
        {
            $TargetModule = $TargetModules | Select -First 1
        }  
        If($TargetModule -eq $null)
        {
            Write-Error "Cannot find PowerShell module with a name '$ModuleName' and version '$ModuleVersion'."
        }
        Else
        {
            #Check for th epresence of the path
            Write-Verbose ""
            If(!(Test-Path -Path $Path -PathType Container))
            {
                #if path doesn't exist
                Write-Error "Path '$Path' doesn't exist."
            }
            Else
            {
                $HelpFolder = Get-Item -Path $Path
                # try to import module
                try
                {
                    Import-Module $TargetModule -ErrorAction Stop
                }
                catch
                {
                    Write-Error "Error occured when trying to import module '$TargetModule', version '$($TargetModule.version)'. Error details:`n$($_ | Select *)" -ErrorAction STOP
                }
                Write-Verbose ""
                Write-Verbose "######################################################"
                Write-Verbose " Powershell module found"
                Write-Verbose " Name: $($TargetModule.Name)"
                Write-Verbose " Version: $($TargetModule.Version)"
                Write-Verbose " Type: $($TargetModule.Moduletype)"
                Write-Verbose " Path: $($TargetModule.Path)"
                Write-Verbose "######################################################"
                Write-Verbose ""
                Write-Verbose "Checking for a presence of any '.txt' or '.md' files"
                $TxtOrMDFiles = Get-ChildItem -Path $Path | Where-Object {$_.name -like '*.txt' -or $_.name -like '*.md'}
                IF($TxtOrMDFiles -ne $null)
                {
                    if ($pscmdlet.ShouldProcess("multiple files with extension '*.txt' or 'md' which were found in folder '$Path'", "Delete"))
                    {
                        Write-Verbose "Deleting '*.txt' and '*.md' files from folder '$Path'"
                        ForEach($ThisFile in $TxtOrMDFiles)
                        {
                            Remove-Item -Path $Thisfile.FullName -Force -ErrorAction Continue
                        }
                    }                    
                }

                $PSModuleName = $TargetModule.name

                # Create Help for all commandlets in module
                Write-Verbose "Generating help files for Cmdlets"
                $AllCommands = Get-Command -Module $TargetModule
                ForEach($ThisCommand in $AllCommands)
                {
                    $ThisHelp = get-help $ThisCommand -Full  
                    $ThisHelpString = $ThisHelp | Out-String # convert from object model into string
                    New-Item -Name ($ThisCommand.Name + ".md") -Path $HelpFolder -Value $ThisHelpString -Force -ErrorAction Continue | Out-Null
                }

                # If any "about" topics available, copy them to folder and change the extension
                Write-Verbose "Searching for and copying 'about' help files."
                $CopiedFiles = @()
                $CopiedFiles += Get-Childitem -path $TargetModule.ModuleBase -Recurse -ErrorAction Continue |
                                    Where-Object {$_.name -like 'about_*' -and $_.name -like '*.txt'} |
                                        Copy-Item -Destination $HelpFolder -Force -PassThru -ErrorAction Continue
                Write-Verbose "Changing extension of 'about' files from '.txt' to '.md'"
                # Change the extension of the 'about_' file from '.txt' to '.md' 
                If($CopiedFiles.count -gt 0)
                {
                    ForEach($Thisfile in $CopiedFiles)
                    {
                        Rename-Item -Path $Thisfile.PSpath -NewName (($Thisfile.name).Replace('.txt','.md')) -Force -ErrorAction Continue
                    }
                }

                # Generating content for the main help file (insert links to all 'about' and 'cmdlet' help files)
                    # Define a link to the file in the root of the project
                
                $ProjectRootFileRelativePath = '../' + $ProjectDefaultPageInRoot
                $ProjectRootFileLink = "[$ProjectName]($ProjectRootFileRelativePath)"

                $MainHelpPageName = $PSModuleName + "_Help.md"
                $MainHelpTXTContent = "$ProjectRootFileLink >> $PSModuleName Help`n"
                Write-Verbose "Generating Main help page with a name '$MainHelpPageName'"
                $ListOfAllHelpFiles = Get-ChildItem -Path $HelpFolder | Where-Object Name -like '*.md'
                
                    # Links to about files
                $AboutFiles = $ListOfAllHelpFiles | Where-Object name -like 'about_*'
                If($AboutFiles -ne $null)
                {
                    $MainHelpTXTContent += "`n# $PSModuleName Help`n`n## About Help articles`n`n" 
                    ForEach($ThisAboutFile in $AboutFiles)
                    {
                        $DisplayString = (($ThisAboutFile.Name).Replace('.md','')).Replace('_',' ') # remove .txt and replace underscore with space
                        $FileRelativePath = './' + $ThisAboutFile.Name
                        $MainHelpTXTContent += "* [$DisplayString)]($FileRelativePath)`n"
                    }  
                }

                    # Links to cmdlet help files
                $CmdletFiles = $ListOfAllHelpFiles | Where-Object name -notlike 'about_*'
                If($CmdletFiles -ne $null)
                {
                    $MainHelpTXTContent += "`n## $PSModuleName Cmdlets`n`n" 
                    ForEach($ThisCmdletFile in $CmdletFiles)
                    {
                        $DisplayString = (($ThisCmdletFile.Name).Replace('.md','')).Replace('_',' ') # remove .txt and replace underscore with space
                        $FileRelativePath = './' + $ThisCmdletFile.Name
                        $MainHelpTXTContent += "* [$DisplayString)]($FileRelativePath)`n"
                    }  
                }
                
                New-Item -Path $HelpFolder -Name $MainHelpPageName -Value $MainHelpTXTContent -Force  -ErrorAction Continue | Out-Null


                # Modify the top of all help pages except Main Help page
                Write-Verbose "Modyfing Help pages - adding top navigation"
                $MainHelpPageRelativePath = './' + $MainHelpPageName
                $HelpPageTopBreadcrumbLine = $ProjectRootFileLink + " >> [$PSModuleName Help]($MainHelpPageRelativePath) >> "
                $ListOfAllHelpFiles = Get-ChildItem -Path $HelpFolder | Where-Object{$_.Name -like '*.md' -and $_.Name -ne $MainHelpPageName}
                ForEach($ThisHelpFile in $ListOfAllHelpFiles)
                {
                    $CurrentContent = Get-Content -Path $ThisHelpFile.FullName
                    $NewContent = $HelpPageTopBreadcrumbLine + ($ThisHelpFile.Name).Replace('.md','') + "`n`n## " + ($ThisHelpFile.Name).Replace('.md','') + "`n`n" + $CurrentContent
                    Set-Content -Path $ThisHelpFile.FullName -Value $NewContent -Force -ErrorAction Continue
                }


            }
        }
    }
}
end
{
}