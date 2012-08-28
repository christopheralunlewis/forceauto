@isTest
private class testEskerFaxWebServiceHandler
{  

    /*************************************************************************
                                       TESTING
    *************************************************************************
    
    // Verify that the constructor method for the Esker Fax Web Service Handler 
    // correctly sets the controller variables to their default values.
    static testmethod void testEskerFaxWebServiceHandlerConstructor(){
    
        EskerFaxWebServiceHandler testEFWSH;
    
        Test.startTest();
        
            // Preparation - set the esker fax username and password urgent pay global settings to sample values.
            Urgent_Pay_Global_Settings__c testUrgentPayGlobalSettings = UrgentPayGlobalSettingsController.getInstance();
       
            testUrgentPayGlobalSettings.Esker_Fax_Username__c = 'test Esker username';
            testUrgentPayGlobalSettings.Esker_Fax_Password__c = 'test Esker password';
            
            update testUrgentPayGlobalSettings;

            // 1 - Null test
            // Ensure that passing a null value to the constructor does not break the method.
            // The number of remaining web service calls remaining should be set at 0.
            testEFWSH = new EskerFaxWebServiceHandler(null);
            
            system.assertEquals   ('test Esker username', testEFWSH.m_Username                     );
            system.assertEquals   ('test Esker password', testEFWSH.m_Password                     );
            system.assertNotEquals(null                 , testEFWSH.sessionServiceSoap             );
            system.assertEquals   (30000                , testEFWSH.sessionServiceSoap.timeout_x   );
            system.assertNotEquals(null                 , testEFWSH.submissionServiceSoap          );
            system.assertEquals   (30000                , testEFWSH.submissionServiceSoap.timeout_x);
            system.assertNotEquals(null                 , testEFWSH.queryServiceSoap               );
            system.assertEquals   (30000                , testEFWSH.queryServiceSoap.timeout_x     );
            system.assertEquals   (0                    , testEFWSH.webServiceCallsRemaining       );
                    
            // 2 - Basic test
            // Pass a valid integer as an argument to the constructor.
            // All variables should be initialised, 
            // and the number of web service calls remaining should equal the argument passed   
        
            testEFWSH = new EskerFaxWebServiceHandler(10);
        
            system.assertEquals   ('test Esker username', testEFWSH.m_Username                     );
            system.assertEquals   ('test Esker password', testEFWSH.m_Password                     );
            system.assertNotEquals(null                 , testEFWSH.sessionServiceSoap             );
            system.assertEquals   (30000                , testEFWSH.sessionServiceSoap.timeout_x   );
            system.assertNotEquals(null                 , testEFWSH.submissionServiceSoap          );
            system.assertEquals   (30000                , testEFWSH.submissionServiceSoap.timeout_x);
            system.assertNotEquals(null                 , testEFWSH.queryServiceSoap               );
            system.assertEquals   (30000                , testEFWSH.queryServiceSoap.timeout_x     );
            system.assertEquals   (10                   , testEFWSH.webServiceCallsRemaining       );   
        
        Test.stopTest();
        
    }
    
    static testmethod void testCreateValue(){
           
        // 1 - Submission var creation test
        // Pass a series of different arguments to the create value method.
        // The attribute name and attribute arguments should be encapsulated in a new var object instance. 
        // All submission var objects created by this method should be of type string.
        
        EskerFaxSubmissionService.Var testSubmissionVar;
        
        testSubmissionVar = CreateValue('test name 1','test value 1');
        
        system.assertEquals('test name 1' , testSubmissionVar.attribute  );
        system.assertEquals('test value 1', testSubmissionVar.simpleValue);
        system.assertEquals('TYPE_STRING' , testSubmissionVar.type_x     );

        testSubmissionVar = CreateValue('test name 2','test value 2');
        
        system.assertEquals('test name 2' , testSubmissionVar.attribute  );
        system.assertEquals('test value 2', testSubmissionVar.simpleValue);
        system.assertEquals('TYPE_STRING' , testSubmissionVar.type_x     );
        
        testSubmissionVar = CreateValue('', null);
        
        system.assertEquals(''            , testSubmissionVar.attribute  );
        system.assertEquals(null          , testSubmissionVar.simpleValue);
        system.assertEquals('TYPE_STRING' , testSubmissionVar.type_x     );
    
    }
    
    static testmethod void testConvertToByteArray(){
        
        // 1 - Null / Empty string
        //     If a null string value is converted to a byte array, a null value should be returned
        system.assertEquals(null, convertToByteArray(null));
        system.assertEquals(''  , convertToByteArray(''  ));
        
        // 2 - Simple string conversion
        
        system.assertEquals('dGVzdCBzdHJpbmcgMTIz'                                                    , convertToByteArray('test string 123'                                     ));
        system.assertEquals('YW5vdGhlciBURVNUIFN0cmluZw=='                                            , convertToByteArray('another TEST String'                                 ));
        system.assertEquals('aGVyZSBpcyBhbm90aGVyIHNhbXBsZSBzdHJpbmcsIGl0cyBzbGlnaHRseSBsb25nZXIhIQ==', convertToByteArray('here is another sample string, its slightly longer!!'));

        // 3 - Long string conversion
        String testInputString = 'For fields that contain strings, behavior is different beginning with API version 15.0. In API versions previous to 15.0, if you specify a value '
                               + 'for a field, and that value is too large, the value is truncated. For API version 15.0 and later, if a value is specified that is too large, the '
                               + 'operation fails and the fault code STRING_TOO_LONG is returned. AllowFieldTruncationHeader allows you to specify that the previous behavior, '
                               + 'truncation, be used instead of the new behavior in API versions 15.0 and later. This header has no effect in versions 14.0 and earlier. The '
                               + 'affected fields are: anyType, email, encryptedstring, multipicklist, phone, picklist, string, and textarea.';
        
        String testOutputString = 'Rm9yIGZpZWxkcyB0aGF0IGNvbnRhaW4gc3RyaW5ncywgYmVoYXZpb3IgaXMgZGlmZmVyZW50IGJlZ2lubmluZyB3aXRoIEFQSSB2ZXJzaW9uIDE1LjAuIEluIEFQSSB2ZXJzaW9ucyBwcmV2a'
                                + 'W91cyB0byAxNS4wLCBpZiB5b3Ugc3BlY2lmeSBhIHZhbHVlIGZvciBhIGZpZWxkLCBhbmQgdGhhdCB2YWx1ZSBpcyB0b28gbGFyZ2UsIHRoZSB2YWx1ZSBpcyB0cnVuY2F0ZWQuIEZvciBBUE'
                                + 'kgdmVyc2lvbiAxNS4wIGFuZCBsYXRlciwgaWYgYSB2YWx1ZSBpcyBzcGVjaWZpZWQgdGhhdCBpcyB0b28gbGFyZ2UsIHRoZSBvcGVyYXRpb24gZmFpbHMgYW5kIHRoZSBmYXVsdCBjb2RlIFN'
                                + 'UUklOR19UT09fTE9ORyBpcyByZXR1cm5lZC4gQWxsb3dGaWVsZFRydW5jYXRpb25IZWFkZXIgYWxsb3dzIHlvdSB0byBzcGVjaWZ5IHRoYXQgdGhlIHByZXZpb3VzIGJlaGF2aW9yLCB0cnVu'
                                + 'Y2F0aW9uLCBiZSB1c2VkIGluc3RlYWQgb2YgdGhlIG5ldyBiZWhhdmlvciBpbiBBUEkgdmVyc2lvbnMgMTUuMCBhbmQgbGF0ZXIuIFRoaXMgaGVhZGVyIGhhcyBubyBlZmZlY3QgaW4gdmVyc'
                                + '2lvbnMgMTQuMCBhbmQgZWFybGllci4gVGhlIGFmZmVjdGVkIGZpZWxkcyBhcmU6IGFueVR5cGUsIGVtYWlsLCBlbmNyeXB0ZWRzdHJpbmcsIG11bHRpcGlja2xpc3QsIHBob25lLCBwaWNrbG'
                                + 'lzdCwgc3RyaW5nLCBhbmQgdGV4dGFyZWEu';
        
        system.assertEquals(testOutputString, convertToByteArray(testInputString));
    }

    static testmethod void testHandleGetBindingsResult(){
         
        // Preparation
        // Create a collection of update jobs that have to be processed and will be passed to the bindings result.
             
        EskerFaxWebServiceHandler testEFWSH;
         
        List<Web_Service_Update_Job__c> testJobsToDelete; 
         
        List<Web_Service_Update_Job__c> testUpdateJobsToProcess = new List<Web_Service_Update_Job__c>{};
        
        testUpdateJobsToProcess.add(new Web_Service_Update_Job__c(Job_Name__c = 'Fax Communication Transmission'));
        testUpdateJobsToProcess.add(new Web_Service_Update_Job__c(Job_Name__c = 'Fax Communication Transmission'));
        testUpdateJobsToProcess.add(new Web_Service_Update_Job__c(Job_Name__c = 'Fax Communication Transmission'));
        
        // 1 - Successful call simulation
        //     If a populated binding result is passed to the handle get bindings method,
        //     ensure that the session, query and submission endpoint variables are populated.
        //     The number of web service calls remaining should stay the same.
        //     An empty collection of web service update jobs should be returned,
        //     indicating that no jobs have failed.
        
        testEFWSH = new EskerFaxWebServiceHandler(10);
        
        EskerFaxSessionService.BindingResult testBindingResult = new EskerFaxSessionService.BindingResult();
        
        testBindingResult.queryServiceLocation      = 'test query service location'     ;
        testBindingResult.sessionServiceLocation    = 'test session service location'   ;
        testBindingResult.submissionServiceLocation = 'test submission service location';
         
        testJobsToDelete = testEFWSH.handleGetBindingsResult(testBindingResult, testUpdateJobsToProcess);
         
        system.assert(testJobsToDelete.isEmpty());
          
        system.assertEquals('test query service location'     , testEFWSH.queryServiceSoap.endpoint_x     );
        system.assertEquals('test session service location'   , testEFWSH.sessionServiceSoap.endpoint_x   );
        system.assertEquals('test submission service location', testEFWSH.submissionServiceSoap.endpoint_x);
        system.assertEquals(10                                , testEFWSH.webServiceCallsRemaining        );
         
        // 2 - Unsuccessful call simulation
        //     If a null binding result is passed to the handle get bindings method,
        //     ensure that the session, query and submission endpoint variables should not change.
        //     The number of web service calls remaining should be reduced to zero.
        //     The returned collection of jobs to delete should contain all of the jobs passed in the jobs to process list.
                 
        testEFWSH = new EskerFaxWebServiceHandler(10);
         
        String initialQueryEndpoint      = testEFWSH.queryServiceSoap.endpoint_x;
        String initialSessionEndpoint    = testEFWSH.sessionServiceSoap.endpoint_x;
        String initialSubmissionEndpoint = testEFWSH.submissionServiceSoap.endpoint_x;
        
        testJobsToDelete = testEFWSH.handleGetBindingsResult(null, testUpdateJobsToProcess);
         
        system.assertEquals(testUpdateJobsToProcess  , testJobsToDelete                           );
        system.assertEquals(initialQueryEndpoint     , testEFWSH.queryServiceSoap.endpoint_x      );
        system.assertEquals(initialSessionEndpoint   , testEFWSH.sessionServiceSoap.endpoint_x    );
        system.assertEquals(initialSubmissionEndpoint, testEFWSH.submissionServiceSoap.endpoint_x ); 
        system.assertEquals(0                        , testEFWSH.webServiceCallsRemaining         );    
    }
    
    static testmethod void testHandleLoginResult(){
        
        // Preparation
        // Create a collection of update jobs that have to be processed and potentially cancelled as part of the handling operation 
         
        EskerFaxWebServiceHandler testEFWSH;
         
        List<Web_Service_Update_Job__c> testJobsToDelete;
        List<Web_Service_Update_Job__c> testUpdateJobsToProcess = new List<Web_Service_Update_Job__c>{};
        
        testUpdateJobsToProcess.add(new Web_Service_Update_Job__c(Job_Name__c = 'Fax Communication Transmission'));
        testUpdateJobsToProcess.add(new Web_Service_Update_Job__c(Job_Name__c = 'Fax Communication Transmission'));
        testUpdateJobsToProcess.add(new Web_Service_Update_Job__c(Job_Name__c = 'Fax Communication Transmission'));
        
        // 1 - Successful call simulation
        //     If a populated login result is passed to the handling method, ensure that the session Id variable is populated.
        //     The number of web service calls remaining should stay the same.
        //     An empty collection of web service update jobs should be returned, indicating that no jobs have failed.
        
        testEFWSH = new EskerFaxWebServiceHandler(10);
        
        EskerFaxSessionService.LoginResult testLoginResult = new EskerFaxSessionService.LoginResult();
        
        testLoginResult.sessionID = 'new test esker session id';
         
        testJobsToDelete = testEFWSH.handleLoginResult(testLoginResult, testUpdateJobsToProcess);
         
        system.assert(testJobsToDelete.isEmpty());
          
        system.assertEquals('new test esker session id', testEFWSH.sessionID               );
        system.assertEquals(10                         , testEFWSH.webServiceCallsRemaining);
         
        // 2 - Unsuccessful call simulation
        //     If a null login result is passed to the handling method ensure that the session variable remains null.
        //     The number of web service calls remaining should be reduced to zero.
        //     The returned collection of jobs to delete should contain all of the jobs passed in the jobs to process list.

        testEFWSH = new EskerFaxWebServiceHandler(10);
        
        testJobsToDelete = testEFWSH.handleLoginResult(null, testUpdateJobsToProcess);
         
        system.assertEquals(testUpdateJobsToProcess, testJobsToDelete                  );
        system.assertEquals(null                   , testEFWSH.sessionID               );
        system.assertEquals(0                      , testEFWSH.webServiceCallsRemaining); 
        
    }
    
    static testmethod void testHandleLogoutResult(){
        
        EskerFaxWebServiceHandler testEFWSH;
        
        // 1 - successful logout
        //     Pass a true boolean as an argument to the handle logout method, indicating that the logout call was succesful.
        //     Process this result by erasing the current session Id controller variable.
        //     The number of remaining web service calls should not be altered.
        
        testEFWSH = new EskerFaxWebServiceHandler(10);
        
        testEFWSH.sessionID = 'sample session';
        testEFWSH.handleLogoutResult(true);
        
        system.assertEquals(null, testEFWSH.sessionId               );
        system.assertEquals(10  , testEFWSH.webServiceCallsRemaining);
        
        // 2 - unsuccessful logout
        //     Pass a false boolean as an argument to the handle logout method, indicating that the logout call failed.
        //     All remaining web service calls should be removed, the session Id should remain, as it is still active.

        testEFWSH = new EskerFaxWebServiceHandler(10);
        
        testEFWSH.sessionID = 'sample session';
        testEFWSH.handleLogoutResult(false);
        
        system.assertEquals('sample session', testEFWSH.sessionId               );
        system.assertEquals(0               , testEFWSH.webServiceCallsRemaining);
        
        // 3 - unsuccessful logout - null value
        //     Pass a null boolean as an argument to the handle logout method, indicating that the logout call failed.
        //     All remaining web service calls should be removed, the session Id should remain, as it is still active.

        testEFWSH = new EskerFaxWebServiceHandler(10);
        
        testEFWSH.sessionID = 'sample session';
        testEFWSH.handleLogoutResult(null);
        
        system.assertEquals('sample session', testEFWSH.sessionId               );
        system.assertEquals(0               , testEFWSH.webServiceCallsRemaining); 
        
    }
    
    static testmethod void testMarkAutoAcknowledgeCasesAsDelivered(){
        
        test.startTest();
        
            // Preparation 
            // Create a set of Sample Accounts, Communications and Urgent Pay Cases, and Web Service Update Jobs.
            Account testAccount = new Account(Name = 'TESTING ACCOUNT', AccountNumber = '-1', Type = 'Patent Renewals');
            insert testAccount;
            
            List<Communication__c> testCommunications = new List<Communication__c>{};
            testCommunications.add(new Communication__c (Name = 'TEST COMMUNICATION 1', Account__c = testAccount.Id));
            testCommunications.add(new Communication__c (Name = 'TEST COMMUNICATION 2', Account__c = testAccount.Id));
            testCommunications.add(new Communication__c (Name = 'TEST COMMUNICATION 3', Account__c = testAccount.Id));
            testCommunications.add(new Communication__c (Name = 'TEST COMMUNICATION 4', Account__c = testAccount.Id));
        
            insert testCommunications;
            
            List<Web_Service_Update_Job__c> testWebServiceUpdateJobs = new List<Web_Service_Update_Job__c>{};
            
            testWebServiceUpdateJobs.add(new Web_Service_Update_Job__c(Communication__c = testCommunications.get(0).Id));
            testWebServiceUpdateJobs.add(new Web_Service_Update_Job__c(Communication__c = testCommunications.get(1).Id));
            testWebServiceUpdateJobs.add(new Web_Service_Update_Job__c(Communication__c = null                        ));
            testWebServiceUpdateJobs.add(new Web_Service_Update_Job__c(Communication__c = testCommunications.get(2).Id));
            testWebServiceUpdateJobs.add(new Web_Service_Update_Job__c(Communication__c = testCommunications.get(3).Id));
            
            insert testWebServiceUpdateJobs;
            
            List<Urgent_Pay_Case__c> testUrgentPayCases = new List<Urgent_Pay_Case__c>{};
            
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000001', Communication__c = testCommunications.get(0).Id, Communication_Method__c = 'Fax - Auto Acknowledge', Status__c = 'Awaiting Delivery Acknowledgement' ));
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000002', Communication__c = testCommunications.get(1).Id, Communication_Method__c = 'Fax'                            , Status__c = 'Awaiting Delivery Acknowledgement' ));
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000003', Communication__c = null                        , Communication_Method__c = 'Fax - Auto Acknowledge', Status__c = 'Awaiting Delivery Acknowledgement' ));         
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000004', Communication__c = testCommunications.get(2).Id, Communication_Method__c = 'Fax - Auto Acknowledge', Status__c = 'Received / Awaiting Payment'       ));
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000005', Communication__c = testCommunications.get(2).Id, Communication_Method__c = 'Email'                          , Status__c = 'Awaiting Delivery Acknowledgement' ));
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000006', Communication__c = testCommunications.get(3).Id, Communication_Method__c = 'Fax - Auto Acknowledge', Status__c = 'Awaiting Delivery Acknowledgement' ));
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000007', Communication__c = testCommunications.get(2).Id, Communication_Method__c = 'Fax'                            , Status__c = 'Under Investigation'               ));
            testUrgentPayCases.add(new Urgent_Pay_Case__c(Name = '-000000008', Communication__c = testCommunications.get(3).Id, Communication_Method__c = 'Fax - Auto Acknowledge', Status__c = 'Awaiting Delivery Acknowledgement' ));
                        
            testUrgentPayCases = TestingUrgentPayCaseGenerator.populateEmptyUrgentPayFields(testUrgentPayCases);
            
            insert testUrgentPayCases;
        
            List<Urgent_Pay_Case__c> updatedUrgentPayCases;
        
            // 1 - Null argument.
            //     Passing a null argument to the method should not cause it to break
        
            markAutoAcknowledgeCasesAsDelivered(null);
            
            // 2 - Single auto acknowledge case.
            //     Pass a single web service update job to the method as an argument.
            //     A single urgent pay case is related to the update job through the communication object.
            //     The single case has a communication method of Fax - Auto Acknowledge and a status of Awaiting Delivery Acknowledgement
            //     The case should be marked as acknowledged.
            
            markAutoAcknowledgeCasesAsDelivered(new List<Web_Service_Update_Job__c>{testWebServiceUpdateJobs.get(0)});
            
            updatedUrgentPayCases = [SELECT Name, Status__c
                                     FROM Urgent_Pay_Case__c
                                     WHERE Id = :testUrgentPayCases.get(0).Id];
        
            system.assertEquals(1                             , updatedUrgentPayCases.size()          );
            system.assertEquals('Received / Awaiting Payment' , updatedUrgentPayCases.get(0).Status__c);
                
            // 3 - Single non-auto acknowledge case.
            //     Pass a single web service update job to the method as an argument.
            //     A single urgent pay case is related to the update job through the communication object.
            //     The single case has a communication method of Fax and a status of Awaiting Delivery Acknowledgement.
            //     The case should not be marked as acknowledged, its status value should remain the same.
            
            markAutoAcknowledgeCasesAsDelivered(new List<Web_Service_Update_Job__c>{testWebServiceUpdateJobs.get(1)});
            
            updatedUrgentPayCases = [SELECT Name, Status__c
                                     FROM Urgent_Pay_Case__c
                                     WHERE Id = :testUrgentPayCases.get(1).Id];
        
            system.assertEquals(1                                   , updatedUrgentPayCases.size()          );
            system.assertEquals('Awaiting Delivery Acknowledgement' , updatedUrgentPayCases.get(0).Status__c);
            
            // 4 - Single web service update job with no related communication
            //     Pass a single web service update job with no communication to the method as an argument.
            //     Existing cases attached to no communi cation should not be marked as acknowledged, their status value should remain the same
            
            markAutoAcknowledgeCasesAsDelivered(new List<Web_Service_Update_Job__c>{testWebServiceUpdateJobs.get(2)});
            
            updatedUrgentPayCases = [SELECT Name, Status__c
                                     FROM Urgent_Pay_Case__c
                                     WHERE Id = :testUrgentPayCases.get(2).Id];
        
            system.assertEquals(1                                   , updatedUrgentPayCases.size()          );
            system.assertEquals('Awaiting Delivery Acknowledgement' , updatedUrgentPayCases.get(0).Status__c);      
                
            // 5 - Multiple update jobs and cases.
            //     Pass multiple web service update jobs to the method as an argument.
            //     Many urgent pay cases are related to the update jobs through communication objects.
            //     These cases have varying status and communication method values.
            //     Only those that have a communication method of Fax - Auto Acknowledge 
            //     and status of Awaiting Delivery Acknowledgement should have their status value changed.
            
            List<Id> testUrgentPayCaseIds = new List<Id>{};
            
            for (Urgent_Pay_Case__c testUrgentPayCase : testUrgentPayCases){
                testUrgentPayCaseIds.add(testUrgentPayCase.Id); 
            }
            
            markAutoAcknowledgeCasesAsDelivered(testWebServiceUpdateJobs);
            
            updatedUrgentPayCases = [SELECT Name, Status__c
                                     FROM Urgent_Pay_Case__c
                                     WHERE Id IN :testUrgentPayCaseIds
                                     ORDER BY Name];
        
            system.assertEquals(8                                   , updatedUrgentPayCases.size()          );
            system.assertEquals('Received / Awaiting Payment'       , updatedUrgentPayCases.get(0).Status__c);
            system.assertEquals('Awaiting Delivery Acknowledgement' , updatedUrgentPayCases.get(1).Status__c);
            system.assertEquals('Awaiting Delivery Acknowledgement' , updatedUrgentPayCases.get(2).Status__c);
            system.assertEquals('Received / Awaiting Payment'       , updatedUrgentPayCases.get(3).Status__c);
            system.assertEquals('Awaiting Delivery Acknowledgement' , updatedUrgentPayCases.get(4).Status__c);
            system.assertEquals('Received / Awaiting Payment'       , updatedUrgentPayCases.get(5).Status__c);
            system.assertEquals('Under Investigation'               , updatedUrgentPayCases.get(6).Status__c);
            system.assertEquals('Received / Awaiting Payment'       , updatedUrgentPayCases.get(7).Status__c);
                        
        test.stopTest();    
    }*/
}