[PSScheduledJob](../ReadMe.md) >> [PSScheduledJob Help](./PSScheduledJob_Help.md) >> Disable-JobTrigger

## Disable-JobTrigger ##



 --- 

 

 ### SYNOPSIS ### 

    Disables the job triggers of scheduled jobs.

 --- 

 

 ### SYNTAX ### 

    Disable-JobTrigger  [-InputObject] <ScheduledJobTrigger[]> [-Confirm] [-PassThru] [-WhatIf] [<CommonParameters>] 



 --- 

 


 ### DESCRIPTION ### 

    The Disable-JobTrigger cmdlet temporarily disables the job triggers of scheduled jobs. Disabling preserves all job trigger properties, but it prevents the job trigger from starting the scheduled job.

     To use this cmdlet, use the Get-JobTrigger cmdlet to get the job triggers. Then pipe the job triggers to Disable-JobTrigger or use its InputObject parameter.

     To disable a job trigger, the Disable-JobTrigger cmdlet sets the Enabled property of the job trigger to $False. To re-enable the job trigger, use the Enable-JobTrigger cmdlet, which sets the Enabled property of the job trigger to $True. Disabling a job trigger does not disable the scheduled job, such as is done by the Disable-ScheduledJob cmdlet, but if you disable all job triggers, the effect is the same as disabling the scheduled job.

     If you disable a scheduled job or disable all job triggers of a scheduled job, you can still start the job by using the Start-Job cmdlet or use the disabled scheduled job as a template. Disable-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

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


  `-InputObject` <ScheduledJobTrigger[]> 

    Specifies the job trigger to be disabled. Enter a variable that contains ScheduledJobTrigger objects or type a command or expression that gets ScheduledJobTriger objects, such as a Get-JobTrigger command. You can also pipe a ScheduledJobTrigger object to Disable-JobTrigger .

         * Required? : true 
         * Position? : 0 
         * Default value : None 
         * Accept pipeline input? : True (ByValue) 


  `-PassThru` <SwitchParameter> 

    Returns an object representing the item with which you are working. By default, this cmdlet does not generate any output.

         * Required? : false 
         * Position? : named 
         * Default value : False 
         * Accept pipeline input? : False 


  `-WhatIf` <SwitchParameter> 

    Shows what would happen if the cmdlet runs. The cmdlet is not run.

         * Required? : false 
         * Position? : named 
         * Default value : False 
         * Accept pipeline input? : False 



 --- 

 


 ### EXAMPLES ### 

 *Example 1: Disable a job trigger*

```PowerShell
PS C:\>Get-JobTrigger -Name "Backup-Archives" -TriggerID 1 | Disable-JobTrigger
```

This command disables the first trigger (ID=1) of the Backup-Archives scheduled job on the local computer.
 The command uses the Get-JobTrigger cmdlet to get the job trigger. A pipeline operator sends the job trigger to the Disable-JobTrigger cmdlet, which disables it. 

*Example 2: Disable all job triggers*

```PowerShell
The first command uses the Get-ScheduledJob cmdlet to get the Backup-Archives and Inventory scheduled jobs. A pipeline operator (|) sends the scheduled jobs to the Get-JobTrigger cmdlet, which gets all job triggers of the scheduled jobs. Another pipeline operator sends the job triggers to the **Disable-JobTrigger** cmdlet, which disables them.The first command uses the **Get-ScheduledJob** cmdlet to get the jobs, because its *Name* parameter takes multiple names.
PS C:\>Get-ScheduledJob -Name "Backup-Archives,Inventory" | Get-JobTrigger | Disable-JobTrigger

The second command displays the results. The command repeats the **Get-ScheduledJob** and **Get-JobTrigger** command. A pipeline operator sends the job triggers to the Format-Table cmdlet, which displays the job triggers in a table. The **Format-Table** command adds a JobName property that displays the value of the Name property of the scheduled job in the JobDefinition property of the job trigger object. 
PS C:\>Get-ScheduledJob -Name "Backup-Archives,Inventory" | Get-JobTrigger | Format-Table -Property ID, Frequency, At, DaysOfWeek, Enabled, @{Label="JobName";Expression={$_.JobDefinition.Name}} -AutoSize
Id Frequency At                     DaysOfWeek Enabled JobName
-- --------- --                     ---------- ------- ------- 
1  Weekly    9/28/2011 3:00:00 AM   {Monday}   False   Backup-Archive
2  Daily     9/29/2011 1:00:00 AM              False   Backup-Archive
1  Weekly    10/20/2011 11:00:00 PM {Friday}   False   Inventory
1  Weekly    11/2/2011 2:00:00 PM   {Monday}   False   Inventory
```

These commands disable all job triggers on two scheduled jobs and display the results.

*Example 3: Disable job trigger of a scheduled job on a remote computer*

```PowerShell
PS C:\>Invoke-Command -ComputerName Server01 {Get-JobTrigger -Name DeployPackage | Where-Object {$_.Frequency -eq "Daily"} | Disable-JobTrigger}
```

This command disables the daily job triggers on the DeployPackage scheduled job on the Server01 remote computer.
 The command uses the Invoke-Command cmdlet to run the commands on the Server01 computer. The remote command uses the Get-JobTrigger cmdlet to get the job triggers of the DeployPackage scheduled job. A pipeline operator sends the job triggers to the Where-Object cmdlet, which returns only daily job triggers. A pipeline operator sends the daily job triggers to the Disable-JobTrigger cmdlet, which disables them. 



 --- 

 


 ### INPUTS ### 

     Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger 

    You can pipe job triggers to Disable-JobTrigger . 



 --- 

 


 ### OUTPUTS ### 

     None 

    This cmdlet does not generate any output. 



 --- 

 


 ### RELATED LINKS ### 

 http://go.microsoft.com/fwlink/?LinkId=821681  Online Version: 

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

