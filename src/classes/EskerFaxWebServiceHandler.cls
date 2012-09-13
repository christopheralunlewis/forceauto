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
	
	This class handles all communications between internal Salesforce methods and an external Esker fax on demand account.
	
	Three different web services can be called using this handler:
	
	1) Get Bindings     - to get the binding parameters for the login service 
	2) Login            - login to your esker fax on demand account
	3) Submit Transport - submit a fax transmission to the on demand server
	
	For more inforamation regarding the Esker fax session service methods, please visit: 
	http://doc.esker.com/eskerondemand/cv_ly/en/webservices/
*/	

public class EskerFaxWebServiceHandler {

    // Esker Fax username and password. IMPORTANT NOTE: You must have an Esker on demand account in order to populate these variables. 
    // Please contact an Esker represenative or visit www.Esker.com for more information. 
    final String username = 'username';
    final String password = 'password';
     
    // An internal variable to store the current Esker fax session.    
    String sessionID {get;set;}
    
    // Web service binding stubs
    EskerFaxSessionService.SessionServiceSoap       sessionServiceSoap;
    EskerFaxSubmissionService.SubmissionServiceSoap submissionServiceSoap;
    
    // The query services can be used to monitor fax transmissions, they are not used in this example
    //EskerFaxQueryService.QueryServiceSoap           queryServiceSoap;

    // Constructor - initialise service objects. This constructor is private, 
    // so that all instances of the object are created through the get instance method below.
    private EskerFaxWebServiceHandler()
    {
        
        sessionServiceSoap = new EskerFaxSessionService.SessionServiceSoap();
        sessionServiceSoap.timeout_x = 30000;
        
        submissionServiceSoap = new EskerFaxSubmissionService.SubmissionServiceSoap();
        submissionServiceSoap.timeout_x = 30000;
    
        //queryServiceSoap = new EskerFaxQueryService.QueryServiceSoap();
        //queryServiceSoap.timeout_x = 30000;
    }
    
    // A public method used to generate a new instance of the esker fax handler.
    // If we are able to get the service bindings and successfully login, 
    // return the instance of the EskerFaxWebServiceHandler, else return null.
    public static EskerFaxWebServiceHandler getInstance()
    {
    	EskerFaxWebServiceHandler efwsh = new EskerFaxWebServiceHandler();
     
        if (efwsh.getBindings() && efwsh.Login())
        {
        	return efwsh;
        }   	
        
        return null;
    }

    /***********************************************************************************
                                   Get Bindings Service
    ************************************************************************************/

    // Make an initial call to the session soap web service to retrieve service bindings and assign them.
    public Boolean getBindings()
    {
        EskerFaxSessionService.BindingResult bindingResult = callGetBindingsWebService();
        
        return handleGetBindingsResult(bindingResult);
    }

    // Call the get bindings web service
    private EskerFaxSessionService.BindingResult callGetBindingsWebService()
    {
        try
        {
           EskerFaxSessionService.BindingResult bindingResult = sessionServiceSoap.GetBindings(username);
           return bindingResult;
        }
        catch (System.Calloutexception e)
        {
            // Put code to handle any kind of service failure here - email/task/chatter update
            System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
        }
        
        return null;
    }   
    
    // Process a response from a call made to the esker fax get bindings web service.
    private Boolean handleGetBindingsResult(EskerFaxSessionService.BindingResult bindingResult)
    {
        if (bindingResult == null){
            return false;
        }
    
        sessionServiceSoap.endpoint_x    = bindingResult.sessionServiceLocation;
        submissionServiceSoap.endpoint_x = bindingResult.submissionServiceLocation;
        //queryServiceSoap.endpoint_x      = bindingResult.queryServiceLocation;
        
        return true;
    }

    /***********************************************************************************
                                   Login Web Service
    ************************************************************************************/

    // Login to the Esker Fax web services
    public Boolean Login()
    {
        EskerFaxSessionService.LoginResult LoginResult = callLoginWebService();
        
        return handleLoginResult(loginResult);
    }
    
    // Call the esker fax login service with a provided username and password.
    private EskerFaxSessionService.LoginResult callLoginWebService()
    {
        try
        {
            EskerFaxSessionService.LoginResult loginResult = sessionServiceSoap.login(userName, password);
            return loginResult;
        }
        catch (System.Calloutexception e)
        {
                // Put code to handle any kind of service failure here - email/task/chatter update
                System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
        }

        return null;
    }
    
    // Process a response from a call made to the esker fax login web service.
    // If a sessionID has been returned then assign its value to the top level class sessionID variable.
    // Also Populate the three service headers based on this value.
    private Boolean handleLoginResult(EskerFaxSessionService.LoginResult loginResult)
    {
        if (loginResult == null)
        {
            return false;
        }
    
        sessionID = loginResult.sessionID;
        
        EskerFaxSessionService.SessionHeader sessionServiceHeader = new EskerFaxSessionService.SessionHeader();
        sessionServiceHeader.sessionID                            = sessionID;
        sessionServiceSoap.SessionHeaderValue                     = sessionServiceHeader;
        
        EskerFaxSubmissionService.SessionHeader submissionServiceHeader = new EskerFaxSubmissionService.SessionHeader(); 
        submissionServiceHeader.sessionID                               = sessionID;
        submissionServiceSoap.SessionHeaderValue                        = submissionServiceHeader;
        
        /*EskerFaxQueryService.SessionHeader queryServiceHeader = new EskerFaxQueryService.SessionHeader();
        queryServiceHeader.sessionID                          = sessionID;
        queryServiceSoap.SessionHeaderValue                   = queryServiceHeader;
        */
        
        return true;
    }

    /***********************************************************************************
                                   Submit Transport Service
    ************************************************************************************/

    // Transmit a fax to the esker server to be resolved and sent onto a client.
    public Boolean submitOpportunityMessage(Opportunity opp)
    {
        
        EskerFaxSubmissionService.Transport transport = generateSubmitTransportWebServiceInput(opp);
        
        EskerFaxSubmissionService.SubmissionResult submissionResult = callSubmitTransportWebService(transport);
        
        return handleSubmitTransportResult(submissionResult);
        
    } 

    // Define the transport submission input, including cover file and 
    // country specific urgent pay formatted html attachment.
    private EskerFaxSubmissionService.Transport generateSubmitTransportWebServiceInput(Opportunity opp)
    {
    	
        EskerFaxSubmissionService.Transport transport = new EskerFaxSubmissionService.Transport();
        
        // Set transport variables
        transport.recipientType  = '';
        transport.transportIndex = '';
        transport.transportName  = 'Fax';
        
        // Specifies fax variables (see documentation for their definitions)
        List<EskerFaxSubmissionService.Var> vars = new List<EskerFaxSubmissionService.Var>{};
        vars.add(CreateValue('ToName'       , opp.Account.Name));
        vars.add(CreateValue('FromName'     , Userinfo.getOrganizationName() + ' - ' + Userinfo.getName()));
        vars.add(CreateValue('FaxNumber'    , opp.Account.Fax));
        vars.add(CreateValue('FromEmail'    , 'your email'));
        vars.add(CreateValue('FromVoice'    , 'your phone number'));
        vars.add(CreateValue('Subject'      , opp.OrderNumber__c));
        vars.add(CreateValue('ToUser1'      , opp.Name));
        vars.add(CreateValue('ToUser2'      , String.ValueOf(opp.Amount)));
        vars.add(CreateValue('ToUser3'      , String.ValueOf(opp.CloseDate)));
        vars.add(CreateValue('Message'      , opp.Description));
        
        // Customised cover templates are uploaded and controlled through your Esker fax login.
        // A sample cover is included in the git hub repository. 
        vars.add(CreateValue('CoverTemplate', 'SampleCover.rtf'));

        transport.nVars    = vars.size();
        transport.vars     = new EskerFaxSubmissionService.vars_element();
        transport.vars.var = vars;
       
        return transport;
        
    }
    
    // Helper method to allocate and assign values to variables passed in a transport.
    private static EskerFaxSubmissionService.Var CreateValue(String AttributeName, String AttributeValue)
    {
        EskerFaxSubmissionService.Var var = new EskerFaxSubmissionService.Var();
        var.attribute             = AttributeName;
        var.simpleValue           = AttributeValue;
        var.type_x                = 'TYPE_STRING';
        return var;
    }
           
    // Call the submit transmission service
    private EskerFaxSubmissionService.SubmissionResult callSubmitTransportWebService(EskerFaxSubmissionService.Transport transport)
    {
        try
        {
            EskerFaxSubmissionService.SubmissionResult submissionResult =  submissionServiceSoap.submitTransport(transport);
            return submissionResult;
        }
        catch (System.Calloutexception e)
        {
            // TODO - put code to handle any kind of service failure here - email/task/chatter update
            System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
        }
        
        return null;
    }
    
    // Process a response from a call made to the Esker fax submit transport web service.
    // If the submission was successful, the new submissionID (JobID) should be returned by the function.
    private Boolean handleSubmitTransportResult(EskerFaxSubmissionService.SubmissionResult submissionResult)
    {
        return (submissionResult != null && submissionResult.submissionID != null);
    }
}