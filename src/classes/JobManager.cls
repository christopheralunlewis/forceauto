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
	
	This class is responsible for managing outstanding update jobs. These update jobs are defined in Job__c
	custom object records. These updates are usually in the form of an external web service call, and are 
	handled in order according to their priority.
*/

public class JobManager
{	
	// Private esker fax web service handler instance, not necessary if you are not using the fax integration.
    private EskerFaxWebServiceHandler efwsh
    {
        get 
        {
        	// If the Esker fax web service handler has not been defined, and enough web service calls remain,
        	// create a new instance of the Esker web service handler, starting a new session in the process.
            if (efwsh == null && webServiceCalloutsRemaining >= 3)
            {
                efwsh = EskerFaxWebServiceHandler.getInstance();
            }
            return efwsh;
        }
        set;
    } 
    
    // A simple variable that uses the limit class to determine how many more web service calls can be made.
    private static Integer webServiceCalloutsRemaining
    {
    	get
    	{
    		return Limits.getLimitCallouts() - Limits.getCallouts();
    	}
    }   
    
    // Execute a single batch of updates. This method is executed in a future context, so that web service callouts
    // can be made when it is called from a scheduled Apex method.     
    @future (callout=true)
    public static void processOutstandingJobs()
    {
    	JobManager jm = new JobManager();
        
        // Use a SOQL query to retrieve the unprocessed jobs based on priority. 
        // The number of records we retrieve should be restricted to the number of available callouts,
        // as this is the maximum number of updates we can potentially process.
        List<Job__c> outstandingJobs = [SELECT Type__c                      , Priority__c, 
                                               Opportunity__r.Account.Name  , Opportunity__r.Account.Fax,
                                               Opportunity__r.OrderNumber__c, Opportunity__r.Name, 
                                               Opportunity__r.Amount        , Opportunity__r.CloseDate, 
                                               Opportunity__r.Description
                                        FROM Job__c
                                        WHERE Time_Processed__c = null
                                        ORDER BY Priority__c
                                        LIMIT :webServiceCalloutsRemaining];
        
        // Iterate through the outstanding jobs. If a job is completed, 
        // mark the time processed field with the current date and time, so it never gets processed again.
        if (!outstandingJobs.isEmpty())
        {                               
            for (Job__c job : outstandingJobs)
            {
            	if (webServiceCalloutsRemaining >= 1)
                {
                	// If the outstanding job is a fax message, simply call the submit opportunity message method.
	               	if (job.Type__c == 'Fax message')
	                {
	                    if (jm.efwsh != null && jm.efwsh.submitOpportunityMessage(job.Opportunity__r))
	                    {
	                     	job.Time_Processed__c = system.now();	
	                    }
	                }
	                
	                // All other job types are here for illustrative purposes only.
	                
	                else if (job.Type__c == 'Email message')
	                {
	                	// We could send an email here.
	                    job.Time_Processed__c = system.now();
	                }
	                
	                else if (job.Type__c == 'Supplier Received')
	                {
	                	// Send a web service update back to an external system here
	                	job.Time_Processed__c = system.now();
	                }
	                
	                else if (job.Type__c == 'Supplier Paid')
	                {
	                	// Send a different web service update back to an external system here
	                	job.Time_Processed__c = system.now();
	                }
            	}
            }
            update outstandingJobs; 
        }
    }
}