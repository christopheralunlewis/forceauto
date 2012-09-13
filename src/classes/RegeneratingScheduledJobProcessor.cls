/**********************************************************************************************************
*	Dreamforce 2012 Session "Using Force.com to Automate Established Business Processes" sample code
*	by Christopher Alun Lewis (chris.lewis@desynit.com).
*
*	This code is intended for demonstration / educational / personal use. Live implemenation should 
*   not be attempted without creating appropriate test methods and proper understanding of the implications 
*   involved in deployment.
*
*   This code is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   This code implementation is not suppported or endorsed by Esker Fax.
**********************************************************************************************************/

/*  
	CLASS DESCRIPTION:

    A scheduable global Apex class that uses the job manager class to process system updates.   
    This scheduable job is engineered to provide rapid managed updates whilst staying within governor limits.     
    Every time the scheduled job runs, at the end of execution, it aborts itself, 
    before scheduling a new instance of the job to be run a short period afterwards. 
    
*/
global class RegeneratingScheduledJobProcessor implements Schedulable 
{      
    // This represents the time interval (in minutes) between one scheduled job ending and the next one beginning. 
    global static final Integer interval = 5;
     
    // Main execute method, called when the scheduled instance runs. 
    global void execute (SchedulableContext sc) 
    {       
        System.abortJob(sc.getTriggerId());
        JobManager.processOutstandingJobs();
        scheduleNextRun();
    }        
     
    // Schedule a future callout of the update job. 
    // The job name includes the scheduled date and time, to make it clearer exactly when the job is set to run.   
    public static void scheduleNextRun()
    {                                       
        DateTime nextScheduledTime = System.now().addMinutes(interval);                
        String scheduleString = nextScheduledTime.format('ss mm HH dd MM ? yyyy');         
        String jobName = 'Job Processor - '+ nextScheduledTime.format('dd/MM/yyyy - HH:mm:ss');              
        
        RegeneratingScheduledJobProcessor nextInstance = new RegeneratingScheduledJobProcessor();        
        System.schedule( jobName , scheduleString , nextInstance );
    }
}