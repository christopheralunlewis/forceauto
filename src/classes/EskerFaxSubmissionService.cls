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
	the Esker on demand submission SOAP web services. These services can be used to submit new fax messages
	to your Esker Fax account for processing. It even includes methods to generate attachments.
	
	You may notice that some of the methods and data structures in this class are commented out. This is because
	none of these methods are used by the demonstration code. However, you may want to use some of these 
	methods in your own implementation, so rather than exclude them I have simply commented them out.
	
	For more inforamation regarding the Esker fax submission service methods, please visit: 
	http://doc.esker.com/eskerondemand/cv_ly/en/webservices/
*/

public class EskerFaxSubmissionService {
    public class Attachment {
        public String inputFormat;
        public String outputFormat;
        public String stylesheet;
        public String outputName;
        public EskerFaxSubmissionService.WSFile sourceAttachment;
        public Integer nConvertedAttachments;
        public EskerFaxSubmissionService.convertedAttachments_element convertedAttachments;
        private String[] inputFormat_type_info = new String[]{'inputFormat','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] outputFormat_type_info = new String[]{'outputFormat','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] stylesheet_type_info = new String[]{'stylesheet','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] outputName_type_info = new String[]{'outputName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] sourceAttachment_type_info = new String[]{'sourceAttachment','urn:SubmissionService','WSFile','1','1','false'};
        private String[] nConvertedAttachments_type_info = new String[]{'nConvertedAttachments','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] convertedAttachments_type_info = new String[]{'convertedAttachments','urn:SubmissionService','convertedAttachments_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'inputFormat','outputFormat','stylesheet','outputName','sourceAttachment','nConvertedAttachments','convertedAttachments'};
    }
    public class Var {
        public String attribute;
        public String type_x;
        public String simpleValue;
        public Integer nValues;
        public EskerFaxSubmissionService.multipleStringValues_element multipleStringValues;
        public EskerFaxSubmissionService.multipleLongValues_element multipleLongValues;
        public EskerFaxSubmissionService.multipleDoubleValues_element multipleDoubleValues;
        private String[] attribute_type_info = new String[]{'attribute','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] type_x_type_info = new String[]{'type','urn:SubmissionService','VAR_TYPE','1','1','false'};
        private String[] simpleValue_type_info = new String[]{'simpleValue','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] nValues_type_info = new String[]{'nValues','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] multipleStringValues_type_info = new String[]{'multipleStringValues','urn:SubmissionService','multipleStringValues_element','1','1','true'};
        private String[] multipleLongValues_type_info = new String[]{'multipleLongValues','urn:SubmissionService','multipleLongValues_element','1','1','true'};
        private String[] multipleDoubleValues_type_info = new String[]{'multipleDoubleValues','urn:SubmissionService','multipleDoubleValues_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'attribute','type_x','simpleValue','nValues','multipleStringValues','multipleLongValues','multipleDoubleValues'};
    }
    public class multipleStringValues_element {
        public String[] string_x;
        private String[] string_x_type_info = new String[]{'string','http://www.w3.org/2001/XMLSchema','string','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'string_x'};
    }
    public class subNodes_element_1 {
        public String[] string_x;
        private String[] string_x_type_info = new String[]{'string','http://www.w3.org/2001/XMLSchema','string','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'string_x'};
    }
    public class SubNode {
        public String name;
        public String relativeName;
        public Integer nSubnodes;
        public EskerFaxSubmissionService.subNodes_element_1 subNodes;
        public Integer nVars;
        public EskerFaxSubmissionService.vars_element vars;
        private String[] name_type_info = new String[]{'name','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] relativeName_type_info = new String[]{'relativeName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] nSubnodes_type_info = new String[]{'nSubnodes','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] subNodes_type_info = new String[]{'subNodes','urn:SubmissionService','subNodes_element_1','1','1','true'};
        private String[] nVars_type_info = new String[]{'nVars','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] vars_type_info = new String[]{'vars','urn:SubmissionService','vars_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'name','relativeName','nSubnodes','subNodes','nVars','vars'};
    }
    public class SubmitTransportResponse_element {
        public EskerFaxSubmissionService.SubmissionResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','SubmissionResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class SessionHeader {
        public String sessionID;
        private String[] sessionID_type_info = new String[]{'sessionID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'sessionID'};
    }
    public class subnodes_element {
        public EskerFaxSubmissionService.SubNode[] SubNode;
        private String[] SubNode_type_info = new String[]{'SubNode','urn:SubmissionService','SubNode','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'SubNode'};
    }
    public class SubmissionResult {
        public String submissionID;
        public Integer transportID;
        private String[] submissionID_type_info = new String[]{'submissionID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] transportID_type_info = new String[]{'transportID','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'submissionID','transportID'};
    }
    public class vars_element {
        public EskerFaxSubmissionService.Var[] Var;
        private String[] Var_type_info = new String[]{'Var','urn:SubmissionService','Var','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'Var'};
    }
        public class multipleLongValues_element {
        public Integer[] int_x;
        private String[] int_x_type_info = new String[]{'int','http://www.w3.org/2001/XMLSchema','int','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'int_x'};
    }
    public class attachments_element {
        public EskerFaxSubmissionService.Attachment[] Attachment;
        private String[] Attachment_type_info = new String[]{'Attachment','urn:SubmissionService','Attachment','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'Attachment'};
    }
    public class multipleDoubleValues_element {
        public Double[] double_x;
        private String[] double_x_type_info = new String[]{'double','http://www.w3.org/2001/XMLSchema','double','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'double_x'};
    }
    public class WSFile {
        public String name;
        public String mode;
        public String content;
        public String url;
        public String storageID;
        private String[] name_type_info = new String[]{'name','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] mode_type_info = new String[]{'mode','urn:SubmissionService','WSFILE_MODE','1','1','false'};
        private String[] content_type_info = new String[]{'content','http://www.w3.org/2001/XMLSchema','base64Binary','1','1','false'};
        private String[] url_type_info = new String[]{'url','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] storageID_type_info = new String[]{'storageID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'name','mode','content','url','storageID'};
    }
    public class Transport {
        public String transportName;
        public String recipientType;
        public String transportIndex;
        public Integer nVars;
        public EskerFaxSubmissionService.vars_element vars;
        public Integer nSubnodes;
        public EskerFaxSubmissionService.subnodes_element subnodes;
        public Integer nAttachments;
        public EskerFaxSubmissionService.attachments_element attachments;
        private String[] transportName_type_info = new String[]{'transportName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] recipientType_type_info = new String[]{'recipientType','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] transportIndex_type_info = new String[]{'transportIndex','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] nVars_type_info = new String[]{'nVars','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] vars_type_info = new String[]{'vars','urn:SubmissionService','vars_element','1','1','true'};
        private String[] nSubnodes_type_info = new String[]{'nSubnodes','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] subnodes_type_info = new String[]{'subnodes','urn:SubmissionService','subnodes_element','1','1','true'};
        private String[] nAttachments_type_info = new String[]{'nAttachments','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] attachments_type_info = new String[]{'attachments','urn:SubmissionService','attachments_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'transportName','recipientType','transportIndex','nVars','vars','nSubnodes','subnodes','nAttachments','attachments'};
    }
    public class SubmitTransport_element {
        public EskerFaxSubmissionService.Transport transport;
        private String[] transport_type_info = new String[]{'transport','urn:SubmissionService','Transport','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'transport'};
    }
    public class ExtractionHeader {
        public String ExtractionJobID;
        public String ExtractionDocID;
        public Integer offset;
        public Integer transportIndex;
        private String[] ExtractionJobID_type_info = new String[]{'ExtractionJobID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] ExtractionDocID_type_info = new String[]{'ExtractionDocID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] offset_type_info = new String[]{'offset','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] transportIndex_type_info = new String[]{'transportIndex','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'ExtractionJobID','ExtractionDocID','offset','transportIndex'};
    }
    public class convertedAttachments_element {
        public EskerFaxSubmissionService.WSFile[] WSFile;
        private String[] WSFile_type_info = new String[]{'WSFile','urn:SubmissionService','WSFile','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'WSFile'};
    }
    public class SubmissionServiceSoap {
        public String endpoint_x = 'https://as1.ondemand.esker.com:443/EDPWS/EDPWS.dll?Handler=SubmissionHandler&Version=1.0';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public EskerFaxSubmissionService.ExtractionHeader ExtractionHeaderValue;
        public EskerFaxSubmissionService.SessionHeader SessionHeaderValue;
        private String ExtractionHeaderValue_hns = 'ExtractionHeaderValue=urn:SubmissionService';
        private String SessionHeaderValue_hns = 'SessionHeaderValue=urn:SubmissionService';
        private String[] ns_map_type_info = new String[]{'urn:SubmissionService', 'EskerFaxSubmissionService', 'urn:QueryService', 'EskerFaxQueryService'};
        public EskerFaxSubmissionService.SubmissionResult SubmitTransport(EskerFaxSubmissionService.Transport transport) {
            EskerFaxSubmissionService.SubmitTransport_element request_x = new EskerFaxSubmissionService.SubmitTransport_element();
            EskerFaxSubmissionService.SubmitTransportResponse_element response_x;
            request_x.transport = transport;
            Map<String, EskerFaxSubmissionService.SubmitTransportResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.SubmitTransportResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#SubmitTransport',
              'urn:SubmissionService',
              'SubmitTransport',
              'urn:SubmissionService',
              'SubmitTransportResponse',
              'EskerFaxSubmissionService.SubmitTransportResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        /*public String DownloadFile(EskerFaxSubmissionService.WSFile wsFile) {
            EskerFaxSubmissionService.DownloadFile_element request_x = new EskerFaxSubmissionService.DownloadFile_element();
            EskerFaxSubmissionService.DownloadFileResponse_element response_x;
            request_x.wsFile = wsFile;
            Map<String, EskerFaxSubmissionService.DownloadFileResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.DownloadFileResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#DownloadFile',
              'urn:SubmissionService',
              'DownloadFile',
              'urn:SubmissionService',
              'DownloadFileResponse',
              'EskerFaxSubmissionService.DownloadFileResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.Resources ListResources(String type_x,Boolean published) {
            EskerFaxSubmissionService.ListResources_element request_x = new EskerFaxSubmissionService.ListResources_element();
            EskerFaxSubmissionService.ListResourcesResponse_element response_x;
            request_x.type_x = type_x;
            request_x.published = published;
            Map<String, EskerFaxSubmissionService.ListResourcesResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.ListResourcesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#ListResources',
              'urn:SubmissionService',
              'ListResources',
              'urn:SubmissionService',
              'ListResourcesResponse',
              'EskerFaxSubmissionService.ListResourcesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.SubmissionResults SubmitXML(EskerFaxSubmissionService.XMLDescription xml) {
            EskerFaxSubmissionService.SubmitXML_element request_x = new EskerFaxSubmissionService.SubmitXML_element();
            EskerFaxSubmissionService.SubmitXMLResponse_element response_x;
            request_x.xml = xml;
            Map<String, EskerFaxSubmissionService.SubmitXMLResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.SubmitXMLResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#SubmitXML',
              'urn:SubmissionService',
              'SubmitXML',
              'urn:SubmissionService',
              'SubmitXMLResponse',
              'EskerFaxSubmissionService.SubmitXMLResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public void RegisterResource(EskerFaxSubmissionService.WSFile resource,String type_x,Boolean published,Boolean overwritePrevious) {
            EskerFaxSubmissionService.RegisterResource_element request_x = new EskerFaxSubmissionService.RegisterResource_element();
            EskerFaxSubmissionService.RegisterResourceResponse_element response_x;
            request_x.resource = resource;
            request_x.type_x = type_x;
            request_x.published = published;
            request_x.overwritePrevious = overwritePrevious;
            Map<String, EskerFaxSubmissionService.RegisterResourceResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.RegisterResourceResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#RegisterResource',
              'urn:SubmissionService',
              'RegisterResource',
              'urn:SubmissionService',
              'RegisterResourceResponse',
              'EskerFaxSubmissionService.RegisterResourceResponse_element'}
            );
            response_x = response_map_x.get('response_x');
        }
        public void DeleteResource(String resourceName,String type_x,Boolean published) {
            EskerFaxSubmissionService.DeleteResource_element request_x = new EskerFaxSubmissionService.DeleteResource_element();
            EskerFaxSubmissionService.DeleteResourceResponse_element response_x;
            request_x.resourceName = resourceName;
            request_x.type_x = type_x;
            request_x.published = published;
            Map<String, EskerFaxSubmissionService.DeleteResourceResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.DeleteResourceResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#DeleteResource',
              'urn:SubmissionService',
              'DeleteResource',
              'urn:SubmissionService',
              'DeleteResourceResponse',
              'EskerFaxSubmissionService.DeleteResourceResponse_element'}
            );
            response_x = response_map_x.get('response_x');
        }
        public EskerFaxSubmissionService.WSFile UploadFileAppend(String fileContent,EskerFaxSubmissionService.WSFile destWSFile) {
            EskerFaxSubmissionService.UploadFileAppend_element request_x = new EskerFaxSubmissionService.UploadFileAppend_element();
            EskerFaxSubmissionService.UploadFileAppendResponse_element response_x;
            request_x.fileContent = fileContent;
            request_x.destWSFile = destWSFile;
            Map<String, EskerFaxSubmissionService.UploadFileAppendResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.UploadFileAppendResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#UploadFileAppend',
              'urn:SubmissionService',
              'UploadFileAppend',
              'urn:SubmissionService',
              'UploadFileAppendResponse',
              'EskerFaxSubmissionService.UploadFileAppendResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.ConversionResult ConvertFile(EskerFaxSubmissionService.WSFile inputFile,EskerFaxSubmissionService.ConversionParameters params) {
            EskerFaxSubmissionService.ConvertFile_element request_x = new EskerFaxSubmissionService.ConvertFile_element();
            EskerFaxSubmissionService.ConvertFileResponse_element response_x;
            request_x.inputFile = inputFile;
            request_x.params = params;
            Map<String, EskerFaxSubmissionService.ConvertFileResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.ConvertFileResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#ConvertFile',
              'urn:SubmissionService',
              'ConvertFile',
              'urn:SubmissionService',
              'ConvertFileResponse',
              'EskerFaxSubmissionService.ConvertFileResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.ExtractionResult ExtractNext(EskerFaxSubmissionService.ExtractionParameters params) {
            EskerFaxSubmissionService.ExtractNext_element request_x = new EskerFaxSubmissionService.ExtractNext_element();
            EskerFaxSubmissionService.ExtractNextResponse_element response_x;
            request_x.params = params;
            Map<String, EskerFaxSubmissionService.ExtractNextResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.ExtractNextResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#ExtractNext',
              'urn:SubmissionService',
              'ExtractNext',
              'urn:SubmissionService',
              'ExtractNextResponse',
              'EskerFaxSubmissionService.ExtractNextResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.WSFile RetrieveResource(String resourceName,String type_x,Boolean published,String eMode) {
            EskerFaxSubmissionService.RetrieveResource_element request_x = new EskerFaxSubmissionService.RetrieveResource_element();
            EskerFaxSubmissionService.RetrieveResourceResponse_element response_x;
            request_x.resourceName = resourceName;
            request_x.type_x = type_x;
            request_x.published = published;
            request_x.eMode = eMode;
            Map<String, EskerFaxSubmissionService.RetrieveResourceResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.RetrieveResourceResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#RetrieveResource',
              'urn:SubmissionService',
              'RetrieveResource',
              'urn:SubmissionService',
              'RetrieveResourceResponse',
              'EskerFaxSubmissionService.RetrieveResourceResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.ExtractionResult ExtractFirst(EskerFaxSubmissionService.BusinessData document,EskerFaxSubmissionService.BusinessRules rules,EskerFaxSubmissionService.ExtractionParameters params) {
            EskerFaxSubmissionService.ExtractFirst_element request_x = new EskerFaxSubmissionService.ExtractFirst_element();
            EskerFaxSubmissionService.ExtractFirstResponse_element response_x;
            request_x.document = document;
            request_x.rules = rules;
            request_x.params = params;
            Map<String, EskerFaxSubmissionService.ExtractFirstResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.ExtractFirstResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#ExtractFirst',
              'urn:SubmissionService',
              'ExtractFirst',
              'urn:SubmissionService',
              'ExtractFirstResponse',
              'EskerFaxSubmissionService.ExtractFirstResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.WSFile UploadFile(String fileContent,String name) {
            EskerFaxSubmissionService.UploadFile_element request_x = new EskerFaxSubmissionService.UploadFile_element();
            EskerFaxSubmissionService.UploadFileResponse_element response_x;
            request_x.fileContent = fileContent;
            request_x.name = name;
            Map<String, EskerFaxSubmissionService.UploadFileResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.UploadFileResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#UploadFile',
              'urn:SubmissionService',
              'UploadFile',
              'urn:SubmissionService',
              'UploadFileResponse',
              'EskerFaxSubmissionService.UploadFileResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EskerFaxSubmissionService.SubmissionResult Submit(String subject,EskerFaxSubmissionService.BusinessData document,EskerFaxSubmissionService.BusinessRules rules) {
            EskerFaxSubmissionService.Submit_element request_x = new EskerFaxSubmissionService.Submit_element();
            EskerFaxSubmissionService.SubmitResponse_element response_x;
            request_x.subject = subject;
            request_x.document = document;
            request_x.rules = rules;
            Map<String, EskerFaxSubmissionService.SubmitResponse_element> response_map_x = new Map<String, EskerFaxSubmissionService.SubmitResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '#Submit',
              'urn:SubmissionService',
              'Submit',
              'urn:SubmissionService',
              'SubmitResponse',
              'EskerFaxSubmissionService.SubmitResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }*/
    }
    /*public class UploadFileAppend_element {
        public String fileContent;
        public EskerFaxSubmissionService.WSFile destWSFile;
        private String[] fileContent_type_info = new String[]{'fileContent','http://www.w3.org/2001/XMLSchema','base64Binary','1','1','false'};
        private String[] destWSFile_type_info = new String[]{'destWSFile','urn:SubmissionService','WSFile','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'fileContent','destWSFile'};
    }
    public class ConversionParameters {
        public String inputType;
        public String outputType;
        public String customParameters;
        public String outputFileMode;
        private String[] inputType_type_info = new String[]{'inputType','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] outputType_type_info = new String[]{'outputType','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] customParameters_type_info = new String[]{'customParameters','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] outputFileMode_type_info = new String[]{'outputFileMode','urn:SubmissionService','WSFILE_MODE','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'inputType','outputType','customParameters','outputFileMode'};
    }
    public class RetrieveResource_element {
        public String resourceName;
        public String type_x;
        public Boolean published;
        public String eMode;
        private String[] resourceName_type_info = new String[]{'resourceName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] type_x_type_info = new String[]{'type','urn:SubmissionService','RESOURCE_TYPE','1','1','false'};
        private String[] published_type_info = new String[]{'published','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] eMode_type_info = new String[]{'eMode','urn:SubmissionService','WSFILE_MODE','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'resourceName','type_x','published','eMode'};
    }
	public class Resources {
        public Integer nResources;
        public EskerFaxSubmissionService.resources_element resources;
        private String[] nResources_type_info = new String[]{'nResources','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] resources_type_info = new String[]{'resources','urn:SubmissionService','resources_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'nResources','resources'};
    }
    public class ConvertFile_element {
        public EskerFaxSubmissionService.WSFile inputFile;
        public EskerFaxSubmissionService.ConversionParameters params;
        private String[] inputFile_type_info = new String[]{'inputFile','urn:SubmissionService','WSFile','1','1','false'};
        private String[] params_type_info = new String[]{'params','urn:SubmissionService','ConversionParameters','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'inputFile','params'};
    }
    public class SubmissionResults {
        public String submissionID;
        public Integer nTransport;
        public EskerFaxSubmissionService.transportIDs_element transportIDs;
        private String[] submissionID_type_info = new String[]{'submissionID','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] nTransport_type_info = new String[]{'nTransport','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] transportIDs_type_info = new String[]{'transportIDs','urn:SubmissionService','transportIDs_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'submissionID','nTransport','transportIDs'};
    }
    public class RetrieveResourceResponse_element {
        public EskerFaxSubmissionService.WSFile return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','WSFile','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
	public class externalVars_element {
        public EskerFaxSubmissionService.Var[] Var;
        private String[] Var_type_info = new String[]{'Var','urn:SubmissionService','Var','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'Var'};
    }
    public class ListResourcesResponse_element {
        public EskerFaxSubmissionService.Resources return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','Resources','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class DownloadFileResponse_element {
        public String return_x;
        private String[] return_x_type_info = new String[]{'return','http://www.w3.org/2001/XMLSchema','base64Binary','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
	public class SubmitResponse_element {
        public EskerFaxSubmissionService.SubmissionResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','SubmissionResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class SubmitXML_element {
        public EskerFaxSubmissionService.XMLDescription xml;
        private String[] xml_type_info = new String[]{'xml','urn:SubmissionService','XMLDescription','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'xml'};
    }
    public class ConvertFileResponse_element {
        public EskerFaxSubmissionService.ConversionResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','ConversionResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class ExtractFirstResponse_element {
        public EskerFaxSubmissionService.ExtractionResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','ExtractionResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class RegisterResourceResponse_element {
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{};
    }
    public class ExtractNext_element {
        public EskerFaxSubmissionService.ExtractionParameters params;
        private String[] params_type_info = new String[]{'params','urn:SubmissionService','ExtractionParameters','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'params'};
    }
	public class SubmitXMLResponse_element {
        public EskerFaxSubmissionService.SubmissionResults return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','SubmissionResults','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class ListResources_element {
        public String type_x;
        public Boolean published;
        private String[] type_x_type_info = new String[]{'type','urn:SubmissionService','RESOURCE_TYPE','1','1','false'};
        private String[] published_type_info = new String[]{'published','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'type_x','published'};
    }
    public class ExtractionParameters {
        public Integer nItems;
        public Boolean fullPreviewMode;
        public String attachmentFilter;
        public String outputFileMode;
        public Boolean includeSubNodes;
        public String startIndex;
        private String[] nItems_type_info = new String[]{'nItems','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] fullPreviewMode_type_info = new String[]{'fullPreviewMode','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] attachmentFilter_type_info = new String[]{'attachmentFilter','urn:SubmissionService','ATTACHMENTS_FILTER','1','1','false'};
        private String[] outputFileMode_type_info = new String[]{'outputFileMode','urn:SubmissionService','WSFILE_MODE','1','1','false'};
        private String[] includeSubNodes_type_info = new String[]{'includeSubNodes','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] startIndex_type_info = new String[]{'startIndex','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'nItems','fullPreviewMode','attachmentFilter','outputFileMode','includeSubNodes','startIndex'};
    }
	public class DownloadFile_element {
        public EskerFaxSubmissionService.WSFile wsFile;
        private String[] wsFile_type_info = new String[]{'wsFile','urn:SubmissionService','WSFile','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'wsFile'};
    }
    public class Submit_element {
        public String subject;
        public EskerFaxSubmissionService.BusinessData document;
        public EskerFaxSubmissionService.BusinessRules rules;
        private String[] subject_type_info = new String[]{'subject','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] document_type_info = new String[]{'document','urn:SubmissionService','BusinessData','1','1','false'};
        private String[] rules_type_info = new String[]{'rules','urn:SubmissionService','BusinessRules','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'subject','document','rules'};
    }
    public class DeleteResource_element {
        public String resourceName;
        public String type_x;
        public Boolean published;
        private String[] resourceName_type_info = new String[]{'resourceName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] type_x_type_info = new String[]{'type','urn:SubmissionService','RESOURCE_TYPE','1','1','false'};
        private String[] published_type_info = new String[]{'published','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'resourceName','type_x','published'};
    }
    public class XMLDescription {
        public EskerFaxSubmissionService.WSFile xmlFile;
        public Integer nAttachments;
        public EskerFaxSubmissionService.attachments_element attachments;
        private String[] xmlFile_type_info = new String[]{'xmlFile','urn:SubmissionService','WSFile','1','1','false'};
        private String[] nAttachments_type_info = new String[]{'nAttachments','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] attachments_type_info = new String[]{'attachments','urn:SubmissionService','attachments_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'xmlFile','nAttachments','attachments'};
    }
    public class transportIDs_element {
        public Integer[] int_x;
        private String[] int_x_type_info = new String[]{'int','http://www.w3.org/2001/XMLSchema','int','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'int_x'};
    }
    public class UploadFileAppendResponse_element {
        public EskerFaxSubmissionService.WSFile return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','WSFile','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class ConversionResult {
        public EskerFaxSubmissionService.WSFile convertedFile;
        private String[] convertedFile_type_info = new String[]{'convertedFile','urn:SubmissionService','WSFile','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'convertedFile'};
    }
    public class transports_element {
        public EskerFaxSubmissionService.Transport[] Transport;
        private String[] Transport_type_info = new String[]{'Transport','urn:SubmissionService','Transport','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'Transport'};
    }
    public class ExtractNextResponse_element {
        public EskerFaxSubmissionService.ExtractionResult return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','ExtractionResult','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class UploadFile_element {
        public String fileContent;
        public String name;
        private String[] fileContent_type_info = new String[]{'fileContent','http://www.w3.org/2001/XMLSchema','base64Binary','1','1','false'};
        private String[] name_type_info = new String[]{'name','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'fileContent','name'};
    }
    public class UploadFileResponse_element {
        public EskerFaxSubmissionService.WSFile return_x;
        private String[] return_x_type_info = new String[]{'return','urn:SubmissionService','WSFile','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }
    public class resources_element {
        public String[] string_x;
        private String[] string_x_type_info = new String[]{'string','http://www.w3.org/2001/XMLSchema','string','0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'string_x'};
    }
    public class DeleteResourceResponse_element {
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{};
    }
    public class ExtractFirst_element {
        public EskerFaxSubmissionService.BusinessData document;
        public EskerFaxSubmissionService.BusinessRules rules;
        public EskerFaxSubmissionService.ExtractionParameters params;
        private String[] document_type_info = new String[]{'document','urn:SubmissionService','BusinessData','1','1','false'};
        private String[] rules_type_info = new String[]{'rules','urn:SubmissionService','BusinessRules','1','1','false'};
        private String[] params_type_info = new String[]{'params','urn:SubmissionService','ExtractionParameters','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'document','rules','params'};
    }
    public class BusinessData {
        public EskerFaxSubmissionService.WSFile file;
        public Integer nExternalVars;
        public EskerFaxSubmissionService.externalVars_element externalVars;
        public Integer nAttachments;
        public EskerFaxSubmissionService.attachments_element attachments;
        private String[] file_type_info = new String[]{'file','urn:SubmissionService','WSFile','1','1','false'};
        private String[] nExternalVars_type_info = new String[]{'nExternalVars','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] externalVars_type_info = new String[]{'externalVars','urn:SubmissionService','externalVars_element','1','1','true'};
        private String[] nAttachments_type_info = new String[]{'nAttachments','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] attachments_type_info = new String[]{'attachments','urn:SubmissionService','attachments_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'file','nExternalVars','externalVars','nAttachments','attachments'};
    }
    public class ExtractionResult {
        public Boolean noMoreItems;
        public Integer nTransports;
        public EskerFaxSubmissionService.transports_element transports;
        private String[] noMoreItems_type_info = new String[]{'noMoreItems','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] nTransports_type_info = new String[]{'nTransports','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] transports_type_info = new String[]{'transports','urn:SubmissionService','transports_element','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'noMoreItems','nTransports','transports'};
    }
    public class RegisterResource_element {
        public EskerFaxSubmissionService.WSFile resource;
        public String type_x;
        public Boolean published;
        public Boolean overwritePrevious;
        private String[] resource_type_info = new String[]{'resource','urn:SubmissionService','WSFile','1','1','false'};
        private String[] type_x_type_info = new String[]{'type','urn:SubmissionService','RESOURCE_TYPE','1','1','false'};
        private String[] published_type_info = new String[]{'published','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] overwritePrevious_type_info = new String[]{'overwritePrevious','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'resource','type_x','published','overwritePrevious'};
    }
    public class BusinessRules {
        public String configurationName;
        public String ruleName;
        private String[] configurationName_type_info = new String[]{'configurationName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] ruleName_type_info = new String[]{'ruleName','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:SubmissionService','true','true'};
        private String[] field_order_type_info = new String[]{'configurationName','ruleName'};
    }*/
}