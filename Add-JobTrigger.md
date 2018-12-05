[PSScheduledJob](../ReadMe.md) >> [PSScheduledJob Help](./PSScheduledJob_Help.md) >> Add-JobTrigger

## Add-JobTrigger ##



 --- 

 

 ### SYNOPSIS ### 

    Adds job triggers to scheduled jobs.

 --- 

 

 ### SYNTAX ### 

    Add-JobTrigger  [-Id] <Int32[]> [-Trigger] <ScheduledJobTrigger[]> [<CommonParameters>] 

    Add-JobTrigger  [-InputObject] <ScheduledJobDefinition[]> [-Trigger] <ScheduledJobTrigger[]> [<CommonParameters>] 

    Add-JobTrigger  [-Name] <String[]> [-Trigger] <ScheduledJobTrigger[]> [<CommonParameters>] 



 --- 

 


 ### DESCRIPTION ### 

    The Add-JobTrigger cmdlet adds job triggers to scheduled jobs. You can use it to add multiple triggers to multiple scheduled jobs.

     A job trigger starts a scheduled job on a one-time or recurring schedule or when an event occurs.

     Use the Trigger parameter of Add-JobTrigger to identify the job triggers to add. Use the Name , ID , or InputObject parameters of Add-JobTrigger to identify the scheduled job to which the triggers are added.

     To create job triggers for the value of the Trigger parameter, use the New-JobTrigger cmdlet or use a hash table to specify the job trigger. Add-JobTrigger is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

     For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see about_Scheduled_Jobs.

     This cmdlet was introduced in Windows PowerShell 3.0.

 --- 

 


 ### PARAMETERS ### 

 
  `-Id` <Int32[]> 

    Specifies the identification numbers of the scheduled jobs. Add-JobTrigger adds the job trigger to the specified scheduled jobs.

     To get the identification number of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 


  `-InputObject` <ScheduledJobDefinition[]> 

    Specifies the scheduled jobs. Enter a variable that contains ScheduledJob objects or type a command or expression that gets ScheduledJob objects, such as a Get-ScheduledJob command. You can also pipe ScheduledJob objects to Add-JobTrigger .

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : True (ByValue) 


  `-Name` <String[]> 

    Specifies the names of the scheduled jobs. Add-JobTrigger adds the job triggers to the specified scheduled jobs. Wildcards are supported.

     To get the names of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 


  `-Trigger` <ScheduledJobTrigger[]> 

    Specifies the job triggers to add. Enter a hash table that specifies job triggers or a variable that contains ScheduledJobTrigger objects, or type a command or expression that gets ScheduledJobTrigger objects, such as a Get-JobTrigger command. You can also pipe ScheduledJobTrigger objects to Add-JobTrigger .

         * Required? : true 
         * Position? : 1 
         * Default value : None 
         * Accept pipeline input? : True (ByValue) 



 --- 

 


 ### EXAMPLES ### 

 *Example 1: Add a job trigger to a scheduled job*

```PowerShell
PS C:\>$Daily = New-JobTrigger -Daily -At 3AMPS 
PS C:\>Add-JobTrigger -Trigger $Daily -Name "TestJob"
```

These commands add the Daily job trigger to the TestJob scheduled job.
 The first command uses the New-JobTrigger cmdlet to create a job trigger that starts a scheduled job every day at 3:00 a.m. The command saves the job trigger in the $Daily variable.
 The second command uses the Add-JobTrigger cmdlet to add the job trigger in the $Startup variable to the TestJob scheduled job. 

*Example 2: Add a job trigger to several scheduled jobs*

```PowerShell
PS C:\>Get-ScheduledJob | Add-JobTrigger -Trigger (New-JobTrigger -AtStartup)
```

This command adds an AtStartup job trigger to all scheduled jobs on the local computer. It uses the Get-ScheduledJob to get all of the scheduled jobs on the computer. It uses a pipeline operator (|) to send the jobs to the Add-JobTrigger cmdlet, which adds the job trigger to each of the scheduled jobs. The value of the Trigger parameter is a New-JobTrigger command that creates the AtStartup job trigger.

*Example 3: Copy a job trigger*

```PowerShell
PS C:\>$T = Get-JobTrigger -Name "BackupArchives"
PS C:\>Add-JobTrigger -Name "TestBackup,BackupLogs" -Trigger $T
```

These commands copy the job trigger from the BackupArchives scheduled job and add it to the TestBackup and BackupLogs scheduled jobs.
 The first command uses the Get-JobTrigger cmdlet to get the job trigger of the BackupArchives scheduled job. The command saves the trigger in the $t variable.
 The second command uses the Add-JobTrigger cmdlet to add the job trigger in $t to the TestBackup and BackupLogs scheduled jobs. 



 --- 

 


 ### INPUTS ### 

     Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger, Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition 

    You can pipe job triggers or scheduled jobs to Add-JobTrigger . 



 --- 

 


 ### OUTPUTS ### 

     None 

    This cmdlet does not return any output. 



 --- 

 


 ### RELATED LINKS ### 

 http://go.microsoft.com/fwlink/?LinkId=821680  Online Version: 

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

