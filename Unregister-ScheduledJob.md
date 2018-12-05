[PSScheduledJob](../ReadMe.md) >> [PSScheduledJob Help](./PSScheduledJob_Help.md) >> Unregister-ScheduledJob

## Unregister-ScheduledJob ##



 --- 

 

 ### SYNOPSIS ### 

    Deletes scheduled jobs on the local computer.

 --- 

 

 ### SYNTAX ### 

    Unregister-ScheduledJob  [-Id] <Int32[]> [-Confirm] [-Force] [-WhatIf] [<CommonParameters>] 

    Unregister-ScheduledJob  [-InputObject] <ScheduledJobDefinition[]> [-Confirm] [-Force] [-WhatIf] [<CommonParameters>] 

    Unregister-ScheduledJob  [-Name] <String[]> [-Confirm] [-Force] [-WhatIf] [<CommonParameters>] 



 --- 

 


 ### DESCRIPTION ### 

    The Unregister-ScheduledJob cmdlet deletes scheduled jobs from the local computer.

     When it deletes or unregisters a scheduled job, Unregister-ScheduledJob deletes the directory for the scheduled job (in the $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs directory), which contains the XML file that defines the scheduled job, the job execution history, and all job results. This action also deletes the job from Task Scheduler. Unregister-ScheduledJob deletes only the scheduled jobs that are created by using the Register-ScheduledJob cmdlet. It does not delete scheduled jobs that are created in Task Scheduler.

     You can use the parameters of Unregister-ScheduledJob to delete scheduled jobs by ID or name, or pipe scheduled jobs from Get-ScheduledJob to Unregister-ScheduledJob . Unregister-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

     For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see about_Scheduled_Jobs.

     This cmdlet was introduced in Windows PowerShell 3.0.

 --- 

 


 ### PARAMETERS ### 

 
  `-Confirm` <SwitchParameter> 

    Prompts you for confirmation before running the cmdlet.

         * Required? : false 
         * Position? : named 
         * Default value : False 
         * Accept pipeline input? : False 


  `-Force` <SwitchParameter> 

    Deletes the scheduled job even if an instance of the job is running. By default, Unregister-ScheduledJob does not interrupt running jobs.

         * Required? : false 
         * Position? : named 
         * Default value : False 
         * Accept pipeline input? : False 


  `-Id` <Int32[]> 

    Deletes the scheduled jobs with the specified identification numbers (ID). Enter the IDs of scheduled jobs on the computer.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 


  `-InputObject` <ScheduledJobDefinition[]> 

    Specifies a scheduled job. Enter a variable that contains ScheduledJob objects or type a command or expression that gets ScheduledJob objects, such as a Get-ScheduledJob command. You can also pipe ScheduledJob objects to Unregister-JobTrigger .

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : True (ByValue) 


  `-Name` <String[]> 

    Deletes the scheduled jobs with the specified names. Enter the names of one or more scheduled jobs on the computer. Wildcards are supported.

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : False 


  `-WhatIf` <SwitchParameter> 

    Shows what would happen if the cmdlet runs. The cmdlet is not run.

         * Required? : false 
         * Position? : named 
         * Default value : False 
         * Accept pipeline input? : False 



 --- 

 


 ### EXAMPLES ### 

 *Example 1: Delete a scheduled job*

```PowerShell
PS C:\>Unregister-ScheduledJob TestJob
```

This command deletes the TestJob scheduled job on the local computer.

*Example 2: Delete all scheduled jobs*

```PowerShell
PS C:\>Get-ScheduledJob | Unregister-ScheduledJob -Force
PS C:\>Unregistered-ScheduledJob -Name "*" -Force
```

This example shows two different commands that delete all scheduled jobs on the local computer.
 The first command uses the Get-ScheduledJob cmdlet to get all scheduled jobs on the local computer. A pipeline operator (|) sends the scheduled jobs to Unregister-ScheduleJob , which deletes them.
 The second command uses the Name parameter of Unregister-ScheduledJob with a value of all (*) to delete all scheduled jobs.
 Both commands use the Force parameter, which deletes a scheduled job even if an instance of the job is running. 

*Example 3: Delete a scheduled job on a remote computer*

```PowerShell
PS C:\>Invoke-Command -ComputerName "Server01" { Unregister-ScheduledJob -Name "Test*"}
```

This command deletes scheduled jobs with names that begin with Test on the Server01 remote computer. The command uses the Invoke-Command cmdlet to run the Unregister-ScheduledJob command on the Server02 computer.



 --- 

 


 ### INPUTS ### 

     Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition 

    You can pipe scheduled jobs to Unregister-ScheduledJob 



 --- 

 


 ### OUTPUTS ### 

     None 

    This cmdlet does not generate any output. 



 --- 

 


 ### RELATED LINKS ### 

 http://go.microsoft.com/fwlink/?LinkId=821707  Online Version: 

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

