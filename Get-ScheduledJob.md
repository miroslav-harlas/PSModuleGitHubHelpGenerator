[PSScheduledJob](../ReadMe.md) >> [PSScheduledJob Help](./PSScheduledJob_Help.md) >> Get-ScheduledJob

## Get-ScheduledJob ##



 --- 

 

 ### SYNOPSIS ### 

    Gets scheduled jobs on the local computer.

 --- 

 

 ### SYNTAX ### 

    Get-ScheduledJob  [[-Id] <Int32[]>] [<CommonParameters>] 

    Get-ScheduledJob  [-Name] <String[]> [<CommonParameters>] 



 --- 

 


 ### DESCRIPTION ### 

    The Get-ScheduledJob cmdlet gets scheduled jobs on the local computer. Get-ScheduledJob gets only scheduled jobs that are created by the current user using the Register-ScheduledJob cmdlet.

     Although jobs that are created by using the Register-ScheduledJob cmdlet appear in Task Scheduler, Get-ScheduledJob gets only scheduled jobs. It does not get scheduled tasks created in Task Scheduler.

     Without parameters, Get-ScheduledJob gets all scheduled jobs on the computer. You can use the parameters of Get-ScheduledJob to get scheduled jobs by ID or name and examine them or pipe them to other cmdlets. Get-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

     For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see about_Scheduled_Jobs.

     This cmdlet was introduced in Windows PowerShell 3.0.

 --- 

 


 ### PARAMETERS ### 

 
  `-Id` <Int32[]> 

    Gets only the scheduled jobs with the specified identification number (ID). Enter one or more IDs of scheduled jobs on the computer. By default, Get-ScheduledJob gets all scheduled jobs on the computer.

         * Required? : false 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 


  `-Name` <String[]> 

    Gets only the scheduled jobs with the specified names. Enter one or more names of scheduled jobs on the computer. Wildcards are supported. By default, Get-ScheduledJob gets all scheduled jobs on the computer.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 



 --- 

 


 ### EXAMPLES ### 

 *Example 1: Get all scheduled jobs*

```PowerShell
PS C:\>Get-ScheduledJob
```

This command gets all scheduled jobs on the local computer.

*Example 2: Get scheduled jobs by name*

```PowerShell
PS C:\>Get-ScheduledJob -Name *Backup*, *Archive*
```

This command gets all scheduled jobs on the computer that have names that include Backup or Archive. This command format lets you search for particular jobs.

*Example 3: Get scheduled jobs on remote computers*

```PowerShell
PS C:\>Invoke-Command -ComputerName (Get-Content Servers.txt) {Get-ScheduledJob}
```

This command gets all scheduled jobs on the computers that are listed in the Servers.txt file. The command uses the Invoke-Command cmdlet to run a Get-ScheduleJob command on each computer.

*Example 4: Pipe scheduled jobs to other cmdlets*

```PowerShell
PS C:\>Get-ScheduledJob DailyBackup, WeeklyBackup | Get-JobTrigger
```

This command gets the job triggers of the DailyBackup and WeeklyBackup scheduled jobs. It uses the Get-ScheduledJob cmdlet to get the scheduled jobs and the Get-JobTrigger cmdlet to get the job triggers of the scheduled jobs.



 --- 

 


 ### INPUTS ### 

     None 

    You cannot pipe input to Get-ScheduledJob . 



 --- 

 


 ### OUTPUTS ### 

     Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition 

     



 --- 

 


 ### RELATED LINKS ### 

 http://go.microsoft.com/fwlink/?LinkId=821686  Online Version: 

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

