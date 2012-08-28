/*  
    A scheduable job class that manages a batch run of web service update calls to the System I and Esker Fax   
    This scheduable job is engineered to be run more than once an hour.     
    Every time the job runs, at the end of execution, it aborts itself.    
    It may also, depending on logic, add a new instance of the job to run in the future.
*/
global class RegeneratingScheduledJobProcessor implements Schedulable 
{      
     
    global Integer getInterval()
    {
        return 1;
    }
     
    global void execute (SchedulableContext sc) 
    {   
        system.debug('sc ' + sc);     
        System.abortJob(sc.getTriggerId());
        processOutstandingTasks();
        scheduleNextRun();
        
    }        
     
    // Execute a single batch of updates    
    public static void processOutstandingTasks()
    {
        Account testAccount = new Account (Name = 'Test Account2');
        insert testAccount;
    }        
     
    // Schedule a future callout of the iSeries update job.    
    public static void scheduleNextRun()
    {                                       
        DateTime nextScheduledTime = System.now().addMinutes(1);                
        String scheduleString = nextScheduledTime.format('ss mm HH dd MM ? yyyy');         
        String jobName = 'Job Processor - '+ nextScheduledTime.format('dd/MM/yyyy - HH:mm:ss');              
        
        RegeneratingScheduledJobProcessor nextInstance = new RegeneratingScheduledJobProcessor();        
        System.schedule( jobName , scheduleString , nextInstance );
    }
}