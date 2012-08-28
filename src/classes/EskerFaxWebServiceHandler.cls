public class EskerFaxWebServiceHandler {

    // Esker Fax username and password.
    final String username = 'USERNAME';
    final String password = 'PASSWORD';
        
    String sessionID {get;set;}
    
    // Three web service binding stubs
    EskerFaxSessionService.SessionServiceSoap       sessionServiceSoap;
    EskerFaxSubmissionService.SubmissionServiceSoap submissionServiceSoap;
    EskerFaxQueryService.QueryServiceSoap           queryServiceSoap;

    // Constructor - initialise services
    public EskerFaxWebServiceHandler(Integer webServiceCallsRemaining){
        
        sessionServiceSoap = new EskerFaxSessionService.SessionServiceSoap();
        sessionServiceSoap.timeout_x = 30000;
        
        submissionServiceSoap = new EskerFaxSubmissionService.SubmissionServiceSoap();
        submissionServiceSoap.timeout_x = 30000;
    
        queryServiceSoap = new EskerFaxQueryService.QueryServiceSoap();
        queryServiceSoap.timeout_x = 30000;
    }

    // Helper method to allocate and fill in Variable objects.
    private static EskerFaxSubmissionService.Var CreateValue(String AttributeName, String AttributeValue)
    {
        EskerFaxSubmissionService.Var var = new EskerFaxSubmissionService.Var();
        var.attribute             = AttributeName;
        var.simpleValue           = AttributeValue;
        var.type_x                = 'TYPE_STRING';
        return var;
    }
    
    public static String convertToByteArray(String inputString)
    {
        if (inputString == null){
            return null;
        }
        
        Blob dataBlob = Blob.valueOf(inputString);
 
        String convertedString = EncodingUtil.base64Encode(dataBlob);
        
        return convertedString;
    }

	private Boolean webServiceCallAvailable()
	{
		return Limits.getCallouts() < Limits.getLimitCallouts();
	}

    /************************************************************
                            Get Bindings
    *************************************************************/

    // Make an initial call to the session soap web service to retrieve service bindings and assign them.
    public void GetBindings()
    {
        
        EskerFaxSessionService.BindingResult bindingResult = callGetBindingsWebService();
        
        handleGetBindingsResult(bindingResult);
    }

    // Call the get bindings web service
    private EskerFaxSessionService.BindingResult callGetBindingsWebService()
    {
        if (webServiceCallAvailable())
        {
            try{
                EskerFaxSessionService.BindingResult bindingResult = sessionServiceSoap.GetBindings(username);
                return bindingResult;
            }
            catch (System.Calloutexception e){
            	// TODO - put code to handle any kind of service failure here - email/task/chatter update
                System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
            }
        }
        
        return null;
    }   
    
    // Process a response from a call made to the esker fax get bindings web service.
    private void handleGetBindingsResult(EskerFaxSessionService.BindingResult bindingResult)
    {
        sessionServiceSoap.endpoint_x    = bindingResult.sessionServiceLocation;
        submissionServiceSoap.endpoint_x = bindingResult.submissionServiceLocation;
        queryServiceSoap.endpoint_x      = bindingResult.queryServiceLocation;

    }

    /************************************************************
                         Login Web Service
    ************************************************************/

    // Login to the Esker Fax web services
    public void Login()
    {
        EskerFaxSessionService.LoginResult LoginResult = callLoginWebService();
        
        handleLoginResult(loginResult);
    }
    
    // Call the esker fax login service with a provided username and password.
    private EskerFaxSessionService.LoginResult callLoginWebService(){
        
        if (webServiceCallAvailable())
        {
            try{
                EskerFaxSessionService.LoginResult loginResult = sessionServiceSoap.login(userName, password);
                return loginResult;
            }
            catch (System.Calloutexception e){
            	// TODO - put code to handle any kind of service failure here - email/task/chatter update
                System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
            }
        }

        return null;
    }
    
    // Process a response from a call made to the esker fax login web service.
    // If a sessionID has been returned then assign its value to the top level class sessionID variable.
    // Also Populate the three service headers based on this value.
    private void handleLoginResult(EskerFaxSessionService.LoginResult loginResult)
    {
        sessionID = loginResult.sessionID;
        
        EskerFaxSessionService.SessionHeader sessionServiceHeader = new EskerFaxSessionService.SessionHeader();
        sessionServiceHeader.sessionID                            = sessionID;
        sessionServiceSoap.SessionHeaderValue                     = sessionServiceHeader;
        
        EskerFaxSubmissionService.SessionHeader submissionServiceHeader = new EskerFaxSubmissionService.SessionHeader(); 
        submissionServiceHeader.sessionID                               = sessionID;
        submissionServiceSoap.SessionHeaderValue                        = submissionServiceHeader;
        
        EskerFaxQueryService.SessionHeader queryServiceHeader = new EskerFaxQueryService.SessionHeader();
        queryServiceHeader.sessionID                          = sessionID;
        queryServiceSoap.SessionHeaderValue                   = queryServiceHeader;
    }
    
    /************************************************************
                        Logout Web Service
    ************************************************************/    
    
    // Relase the current Esker fax session.
    public void Logout()
    { 
        // As soon as you call Logout(), the files allocated on the server during this session won't be available
        // any more, so keep in mind that former urls are now useless...
        System.debug('Releasing session and server files');

        Boolean success = callLogoutWebService();
    }
    
    // Call Esker fax logout web service
    private Boolean callLogoutWebService()
    {
        
        if (webServiceCallAvailable())
        {    
            try
            {
                sessionServiceSoap.logout();
                return true;
            }
            catch (System.Calloutexception e)
            {
            	// TODO - put code to handle any kind of service failure here - email/task/chatter update
                System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
            }
        }
        
        return false;
    }

    /************************************************************
                           Submit Transport
    ************************************************************/

    // Transmit a fax to the esker server to be resolved and sent onto a client.
    public Integer SubmitTransport(Account account){
        
        EskerFaxSubmissionService.Transport transport = generateSubmitTransportWebServiceInput(account);
        
        EskerFaxSubmissionService.SubmissionResult submissionResult = callSubmitTransportWebService(transport);
        
        return handleSubmitTransportResult(submissionResult);
        
    } 

    // Define the transport submission input, including cover file and 
    // country specific urgent pay formatted html attachment.
    private EskerFaxSubmissionService.Transport generateSubmitTransportWebServiceInput(Account account){
        
        EskerFaxSubmissionService.Transport transport = new EskerFaxSubmissionService.Transport();

        // Set transport variables
        transport.recipientType  = '';
        transport.transportIndex = '';
        transport.transportName  = 'Fax';
        
        // Specifies fax variables (see documentation for their definitions)
        List<EskerFaxSubmissionService.Var> vars = new List<EskerFaxSubmissionService.Var>{};
        vars.add(CreateValue('ToName'       , account.Name));
        vars.add(CreateValue('FromName'     , Userinfo.getOrganizationName() + ' - ' + Userinfo.getName()));
        vars.add(CreateValue('FromEmail'    , 'email address here'));
        vars.add(CreateValue('FromVoice'    , 'telephone number here'));
        vars.add(CreateValue('Message'      , ''));
        vars.add(CreateValue('Subject'      , 'Hello here is your fax'));
        vars.add(CreateValue('CoverTemplate', ''));
        vars.add(CreateValue('FaxNumber'    , account.Fax));
                
        transport.nVars    = vars.size();
        transport.vars     = new EskerFaxSubmissionService.vars_element();
        transport.vars.var = vars;

        // Add a urgent pay case html attachment.
        // First, define the source file content and format, then add that to the attachment collection for the transport.
        EskerFaxSubmissionService.WSFile urgentPayCaseFile = new EskerFaxSubmissionService.WSFile();
        
        String faxTemplateBody = 'Need to think about templating'; 
        
        urgentPayCaseFile.name      = 'attachment.html';
        urgentPayCaseFile.mode      = 'MODE_INLINED';
        urgentPayCaseFile.content   = convertToByteArray(faxTemplateBody);
        urgentPayCaseFile.url       = '';
        urgentPayCaseFile.storageID = '';

        EskerFaxSubmissionService.Attachment urgentPayCaseAttachment = new EskerFaxSubmissionService.Attachment();
        
        urgentPayCaseAttachment.sourceAttachment      = urgentPayCaseFile;
        urgentPayCaseAttachment.inputFormat           = '';
        urgentPayCaseAttachment.outputFormat          = '';
        urgentPayCaseAttachment.outputName            = 'attachment.html';
        urgentPayCaseAttachment.stylesheet            = '';
        urgentPayCaseAttachment.nConvertedAttachments = 0;

        transport.attachments = new EskerFaxSubmissionService.attachments_element();
        transport.attachments.Attachment = new List<EskerFaxSubmissionService.Attachment>{urgentPayCaseAttachment};
        
        return transport;
        
    }
           
    // Call the submit transmission service
    private EskerFaxSubmissionService.SubmissionResult callSubmitTransportWebService(EskerFaxSubmissionService.Transport transport){
        
        if (webServiceCallAvailable())
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
        }
        
        return null;
    }
    
    // Process a response from a call made to the Esker fax submit transport web service.
    // If the submission was successful, the new submissionID (JobID) should be returned by the function.
    private Integer handleSubmitTransportResult(EskerFaxSubmissionService.SubmissionResult submissionResult)
    {
        return submissionResult.transportID;
    }
    
    /************************************************************
                           Monitor Transport
    ************************************************************/ 

    // Monitor an existing fax transmission, to check that it has been successfully sent.
    public MonitorTransportResult monitorTransport(Integer jobId)
    {
        
        EskerFaxQueryService.QueryRequest queryRequest = generateMonitorTransportWebServiceInput(jobID);
        
        EskerFaxQueryService.QueryResult  queryResult  = callMonitorTransportWebService(queryRequest);
        
        return handleMonitorTransportResult(queryResult);
    }

    // Define the monitor submission input, including the esker fax unique identifier
    private EskerFaxQueryService.QueryRequest generateMonitorTransportWebServiceInput(Integer jobID)
    {
        
        EskerFaxQueryService.QueryRequest queryRequest = new EskerFaxQueryService.QueryRequest();
        
        queryRequest.filter     = '(&(msn=' + jobID + ')(TransportName=Fax))';
        queryRequest.sortOrder  = '';
        queryRequest.NItems     = 1;
        queryRequest.Attributes = 'State,ShortStatus,CompletionDateTime';
        
        return queryRequest;
        
    }

    // Call the monitor transmission service
    private EskerFaxQueryService.QueryResult callMonitorTransportWebService(EskerFaxQueryService.QueryRequest queryRequest)
    {
         if (webServiceCallAvailable())
         {   
            try
            {
                EskerFaxQueryService.QueryResult queryResult = queryServiceSoap.QueryFirst(queryRequest);
                return queryResult;
            }
            catch (System.Calloutexception e)
            {
            	// TODO - put code to handle any kind of service failure here - email/task/chatter update
                System.debug('*****************CALLOUT EXCEPTION*************** ' + e);
            }
        }
        
        return null;
    }   
    
    // Process a response from a call made to the Esker fax monitor transport web service.
    // If the transmission has been sent successfully, grab the fax contents from the Esker server and email to the urgent pay controller.
    private MonitorTransportResult handleMonitorTransportResult(EskerFaxQueryService.QueryResult queryResult)
    {
    
        MonitorTransportResult monitorTransportResult = new MonitorTransportResult();

        EskerFaxQueryService.Transport returnedTransport = queryResult.transports.Transport[0];
        
        for (EskerFaxQueryService.Var currentVar : returnedTransport.vars.Var)
        {
            
            system.debug('Var Name: ' + currentVar.attribute.toLowerCase() + ' , Var Value: ' + currentVar.simpleValue);
            
            if(currentVar.attribute.toLowerCase().equals('state')){
                monitorTransportResult.setStatusFromNumericCode(Integer.valueOf(currentVar.simpleValue));
            }
            else if(currentVar.attribute.toLowerCase().equals('shortstatus')){
                monitorTransportResult.errorMessage = currentVar.simpleValue;
            }
            else if(currentVar.attribute.toLowerCase().equals('completiondatetime')){
                monitorTransportResult.completiondate = currentVar.simpleValue;
            }
        }
            
        return monitorTransportResult;
    }
    
    public class MonitorTransportResult{
        
        public String status         {get;set;} 
        public String completiondate {get;set;}
        public String errorMessage   {get;set;}
        
        public void setStatusFromNumericCode(Integer statusCode){
            
                 if(statusCode == null) status = 'Failure - null status';
            else if(statusCode <  100 ) status = 'Pending';
            else if(statusCode == 100 ) status = 'Successful';
            else if(statusCode == 200 ) status = 'Failure';
            else if(statusCode == 300 ) status = 'Rejected';
            else if(statusCode == 400 ) status = 'Cancelled';
            else                        status = 'Failure - unrecognised status';
        }
        
    }
}