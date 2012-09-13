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
	
	A simple page controller used to start the regenerating scheduled job.
	
	This is easier to use than having to use the developer console or setup menu in my opinion.
*/

public class ScheduledJobManagerController
{
    public static void startJob()
    {
        RegeneratingScheduledJobProcessor.scheduleNextRun();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Scheduled Update Job Started!'));
    }
}