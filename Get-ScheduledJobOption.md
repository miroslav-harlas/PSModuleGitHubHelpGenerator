[PSScheduledJob](../ReadMe.md) >> [PSScheduledJob Help](./PSScheduledJob_Help.md) >> Get-ScheduledJobOption

## Get-ScheduledJobOption ##



 --- 

 

 ### SYNOPSIS ### 

    Gets the job options of scheduled jobs.

 --- 

 

 ### SYNTAX ### 

    Get-ScheduledJobOption  [-Id] <Int32> [<CommonParameters>] 

    Get-ScheduledJobOption  [-InputObject] <ScheduledJobDefinition> [<CommonParameters>] 

    Get-ScheduledJobOption  [-Name] <String> [<CommonParameters>] 



 --- 

 


 ### DESCRIPTION ### 

    The Get-ScheduledJobOption cmdlet gets the job options of scheduled jobs. You can use this command to examine the job options or to pipe the job options to other cmdlets.

     Job options are not saved to disk independently; they are part of a scheduled job. To get the job options of a scheduled job, specify the scheduled job.

     Use the parameters of the Get-ScheduledJobOption cmdlet to identify the scheduled job. You can identify scheduled jobs by their names or identification numbers, or by entering or piping ScheduledJob objects, such as those that are returned by the Get-ScheduledJob cmdlet, to Get-ScheduledJobOption . Get-ScheduledJobOption is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

     For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see about_Scheduled_Jobs.

     This cmdlet was introduced in Windows PowerShell 3.0.

 --- 

 


 ### PARAMETERS ### 

 
  `-Id` <Int32> 

    Specifies the identification number of a scheduled job. Get-ScheduledJobOption gets the job options of the specified scheduled job.

     To get the identification numbers of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 


  `-InputObject` <ScheduledJobDefinition> 

    Specifies a scheduled job. Enter a variable that contains a ScheduledJob object or type a command or expression that gets a ScheduledJob object, such as a Get-ScheduledJob command. You can also pipe a ScheduledJob object to Get-ScheduledJobOption .

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : True (ByValue) 


  `-Name` <String> 

    Specifies the names of scheduled jobs. Get-ScheduledJobOption gets the job options of the specified scheduled job. Wildcards are supported.

     To get the names of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : True (ByPropertyName) 



 --- 

 


 ### EXAMPLES ### 

 *Example 1: Get job options*

```PowerShell
PS C:\>Get-ScheduledJobOption -Name "*Backup*"
StartIfOnBatteries     : False

StopIfGoingOnBatteries : True

WakeToRun              : False

StartIfNotIdle         : True

StopIfGoingOffIdle     : False

RestartOnIdleResume    : False

IdleDuration           : 00:10:00

IdleTimeout            : 01:00:00

ShowInTaskScheduler    : True

RunElevated            : True

RunWithoutNetwork      : True

DoNotAllowDemandStart  : False

MultipleInstancePolicy : Ignore

NewJobDefinition       : Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
```

This command gets the job options of scheduled jobs that have BackUp in their names. The results show the job options object that Get-ScheduledJobOption returned.

*Example 2: Get all job options*

```PowerShell
PS C:\>Get-ScheduledJob | Get-ScheduledJobOptions
```

This command gets the job options of all scheduled jobs on the local computer.
 It uses the Get-ScheduledJob cmdlet to get the scheduled jobs on the local computer. A pipeline operator (|) sends the scheduled jobs to the Get-ScheduledJobOptions cmdlet, which gets the job options of each scheduled job. 

*Example 3: Get selected job options*

```PowerShell
PS C:\>Get-ScheduledJob | Get-ScheduledJobOption | Where {$_.RunElevated -and !$_.WaketoRun}
StartIfOnBatteries     : False

StopIfGoingOnBatteries : True

WakeToRun              : True

StartIfNotIdle         : True

StopIfGoingOffIdle     : False

RestartOnIdleResume    : False

IdleDuration           : 00:10:00

IdleTimeout            : 01:00:00

ShowInTaskScheduler    : True

RunElevated            : True

RunWithoutNetwork      : True

DoNotAllowDemandStart  : False

MultipleInstancePolicy : Ignore

NewJobDefinition       : Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

The second command shows how to find to which scheduled job the job options belong. This command uses a pipeline operator (|) to send the selected job options to the ForEach-Object cmdlet, which gets the JobDefinition property of each options object. The JobDefinition property contains the originating job object. The results show that the selected options came from the DeployPkg scheduled job.
PS C:\>Get-ScheduledJob | Get-ScheduledJobOption | Where {$_.RunElevated -and !$_.WaketoRun} | ForEach-Object {$_.JobDefinition}
Id         Name            Triggers        Command                                  Enabled

--         ----            --------        -------                                  -------

2          DeployPkg         {1, 2}        DeployPackage.ps1                        True
```

This example shows how to find job options object with particular values.
 The first command gets job options in which the RunElevated property has a value of $True and the RunWithoutNetwork property has a value of $False. The output shows the JobOptions object that was selected. 

*Example 4: Use job options to create a new job*

```PowerShell
PS C:\>$Opts = Get-ScheduledJobOption -Name "BackupTestLogs"
PS C:\>Register-ScheduledJob -Name "Archive-Scripts" -FilePath "\\Srv01\Scripts\ArchiveScripts.ps1" -ScheduledJobOption $Opts
```

This example shows how to use the job options that Get-ScheduledJobOptions gets in a new scheduled job.
 The first command uses Get-ScheduledJobOptions to get the jobs options of the BackupTestLogs scheduled job. The command saves the options in the $Opts variable.
 The second command uses Register-ScheduledJob cmdlet to create a new scheduled job. The value of the ScheduledJobOption parameter is the options object in the $Opts variable. 

*Example 5: Get job options from a remote computer*

```PowerShell
PS C:\>$O = Invoke-Command -ComputerName "Srv01" -ScriptBlock {Get-ScheduledJob -Name "DataDemon" }
```

This command uses the Invoke-Command cmdlet to get the scheduled job options of the DataDemon job on the Srv01 computer. The command saves the options in the $O variable.



 --- 

 


 ### INPUTS ### 

     Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition 

    You can pipe a scheduled job from Get-ScheduledJob to Get-ScheduledJobOption . 



 --- 

 


 ### OUTPUTS ### 

     Microsoft.PowerShell.ScheduledJob.ScheduledJobOptions 

     



 --- 

 


 ### RELATED LINKS ### 

 http://go.microsoft.com/fwlink/?LinkId=821687  Online Version: 

  Add-JobTrigger 

  Disable-JobTrigger 

  Disable-ScheduledJob 

  Enable-JobTrigger 

  Enable-ScheduledJob 

  Get-JobTrigger 

  Get-ScheduledJob 

  Get-ScheduledJobOption 

  New-JobTrigger 

  New-ScheduledJobOption 

  Register-ScheduledJob 

  Remove-JobTrigger 

  Set-JobTrigger 

  Set-ScheduledJob 

  Set-ScheduledJobOption 

  Unregister-ScheduledJob 

