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
	
	This class was generated using wsdl2apex by consuming the Esker Fax on demand WSDL file through the 
	Salesforce setup menu. It contains several methods and data structures that can be used to interact with
	the Esker on demand session SOAP web services. These services are used to establish a session with the 
	Esker fax on demand system. 
	
	IMPORTANT NOTE: You must have an Esker on demand account in order to establish a method. Please contact an Esker
	represenative or visit www.Esker.com for more information. 
	
	You may notice that some of the methods and data structures in this class are commented out. This is because
	none of these methods are used by the demonstration code. However, you may want to use some of these 
	methods in your own implementation, so rather than exclude them I have simply commented them out.
	
	For more inforamation regarding the Esker fax session service methods, please visit: 
	http://doc.esker.com/eskerondemand/cv_ly/en/webservices/
*/

public class EskerFaxSessionService {
    public class BindingResult {
        public String sessionServiceLocation;
        public String submissionServiceLocation;
        public String queryServiceLocation;
        public String sessionServiceWSDL;
        public String submissionServiceWSDL;
        public String queryServiceWSDL;
        private String[] sessionServiceLocation_type_info = new String[]{'sessionServiceLocation','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] submissionServiceLocation_type_info = new String[]{'submissionServiceLocation','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] queryServiceLocation_type_info = new String[]{'queryServiceLocation','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] sessionServiceWSDL_type_info = new String[]{'sessionServiceWSDL','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] submissionServiceWSDL_type_info = new String[]{'submissionServiceWSDL','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] queryServiceWSDL_type_info = new String[]{'queryServiceWSDL','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'sessionServiceLocation','submissionServiceLocation','queryServiceLocation','sessionServiceWSDL','submissionServiceWSDL','queryServiceWSDL'};
    }
    public class LoginResult {
        public String sessionID;
        private String[] sessionID_type_info = new String[]{'sessionID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'sessionID'};
    }
    public class SessionHeader {
        public String sessionID;
        private String[] sessionID_type_info = new String[]{'sessionID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'sessionID'};
    }
    public class Login_element {
        public String userName;
        public String password;
        private String[] userName_type_info = new String[]{'userName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] password_type_info = new String[]{'password','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'userName','password'};
    }
    public class LoginResponse_element {
        public EskerFaxSessionService.LoginResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SessionService','LoginResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class GetBindingsResponse_element {
        public EskerFaxSessionService.BindingResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SessionService','BindingResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class GetBindings_element {
        public String reserved;
        private String[] reserved_type_info = new String[]{'reserved','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'reserved'};
    }
    public class SessionServiceSoap {
        public String endpoint_x = 'https://as1.ondemand.esker.com:443/EDPWS/EDPWS.dll?Handler=Default&Version=1.0';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public EskerFaxSessionService.SessionHeader SessionHeaderValue;
        private String SessionHeaderValue_hns = 'SessionHeaderValue=urn:SessionService';
        private String[] ns_map_type_info = new String[]{'urn:QueryService', 'EskerFaxQueryService', 'urn:SessionService', 'EskerFaxSessionService'};
        public EskerFaxSessionService.LoginResult Login(String userName,String password) {
            EskerFaxSessionService.Login_element request_x = new EskerFaxSessionService.Login_element();
            EskerFaxSessionService.LoginResponse_element response_x;
            request_x.userName = userName;
            request_x.password = password;
            Map<String, EskerFaxSessionService.LoginResponse_element> response_map_x = new Map<String, EskerFaxSessionService.LoginResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#Login',
              'urn:SessionService',
              'Login',
              'urn:SessionService',
              'LoginResponse',
              'EskerFaxSessionService.LoginResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSessionService.BindingResult GetBindings(String reserved) {
            EskerFaxSessionService.GetBindings_element request_x = new EskerFaxSessionService.GetBindings_element();
            EskerFaxSessionService.GetBindingsResponse_element response_x;
            request_x.reserved = reserved;
            Map<String, EskerFaxSessionService.GetBindingsResponse_element> response_map_x = new Map<String, EskerFaxSessionService.GetBindingsResponse_element>();
            response_map_x.put('response_x', response_x);
            //if(Test.isRunningTest()){
            //  return new EskerFaxSessionService.BindingResult();
            //}
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#GetBindings',
              'urn:SessionService',
              'GetBindings',
              'urn:SessionService',
              'GetBindingsResponse',
              'EskerFaxSessionService.GetBindingsResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        /*public EskerFaxSessionService.ServiceInformation GetServiceInformation(String language) {
            EskerFaxSessionService.GetServiceInformation_element request_x = new EskerFaxSessionService.GetServiceInformation_element();
            EskerFaxSessionService.GetServiceInformationResponse_element response_x;
            request_x.language = language;
            Map<String, EskerFaxSessionService.GetServiceInformationResponse_element> response_map_x = new Map<String, EskerFaxSessionService.GetServiceInformationResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#GetServiceInformation',
              'urn:SessionService',
              'GetServiceInformation',
              'urn:SessionService',
              'GetServiceInformationResponse',
              'EskerFaxSessionService.GetServiceInformationResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSessionService.SessionInformation GetSessionInformation() {
            EskerFaxSessionService.GetSessionInformation_element request_x = new EskerFaxSessionService.GetSessionInformation_element();
            EskerFaxSessionService.GetSessionInformationResponse_element response_x;
            Map<String, EskerFaxSessionService.GetSessionInformationResponse_element> response_map_x = new Map<String, EskerFaxSessionService.GetSessionInformationResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#GetSessionInformation',
              'urn:SessionService',
              'GetSessionInformation',
              'urn:SessionService',
              'GetSessionInformationResponse',
              'EskerFaxSessionService.GetSessionInformationResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public void Logout() {
            EskerFaxSessionService.Logout_element request_x = new EskerFaxSessionService.Logout_element();
            EskerFaxSessionService.LogoutResponse_element response_x;
            Map<String, EskerFaxSessionService.LogoutResponse_element> response_map_x = new Map<String, EskerFaxSessionService.LogoutResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#Logout',
              'urn:SessionService',
              'Logout',
              'urn:SessionService',
              'LogoutResponse',
              'EskerFaxSessionService.LogoutResponse_element'}
            );
            response_x = response_map_x.get('response_x');
        }*/
    }
    /*public class GetServiceInformation_element {
        public String language;
        private String[] language_type_info = new String[]{'language','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'language'};
    }
    public class GetServiceInformationResponse_element {
        public EskerFaxSessionService.ServiceInformation return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SessionService','ServiceInformation','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class SessionInformation {
        public String login;
        public String identifier;
        public String account;
        public String name;
        public String company;
        public String email;
        public String culture;
        public String timeZone;
        public String language;
        public String filesPath;
        private String[] login_type_info = new String[]{'login','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] identifier_type_info = new String[]{'identifier','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] account_type_info = new String[]{'account','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] name_type_info = new String[]{'name','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] company_type_info = new String[]{'company','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] email_type_info = new String[]{'email','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] culture_type_info = new String[]{'culture','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] timeZone_type_info = new String[]{'timeZone','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] language_type_info = new String[]{'language','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] filesPath_type_info = new String[]{'filesPath','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'login','identifier','account','name','company','email','culture','timeZone','language','filesPath'};
    }
    public class ServiceInformation {
        public String message;
        public String details;
        private String[] message_type_info = new String[]{'message','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] details_type_info = new String[]{'details','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'message','details'};
    }
    public class GetSessionInformationResponse_element {
        public EskerFaxSessionService.SessionInformation return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SessionService','SessionInformation','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class GetSessionInformation_element {
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{};
    }
    public class LogoutResponse_element {
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{};
    }
    public class Logout_element {
        private String[] apex_schema_type_info = new String[]{'urn:SessionService','true','true'};
        private String[] field_order_type_info = new String[]{};
    }*/
}