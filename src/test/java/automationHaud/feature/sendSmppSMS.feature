@smpp_to_http
@parallel=false
Feature: Send SMS using SMPP

    Background:
        * url sttUrl
        * def pcapFilename = 'test_sample_1.pcap'
        * def pcapClass = callonce read('classpath:helpers/validatePcap.feature')
        * def pcapValidation = pcapClass.pcapValidation
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
        * def countPattern = function(text,pattern) { var rgxp = new RegExp(pattern, "gi"); return text.match(rgxp).length; }
        * header Content-Type = 'application/json'

    Scenario: Create SMPP supplier
        * pcapValidation.startPcapWriting(pcapFilename)
        * eval sleep(5000)
        Given path 'create/server'
        * def payloadServer = 
        """
            {
                "name":"supplierconn1",
                "service_id":"supplierconn1",
                "statistics_only":"false",
                "statistics_response_time_warning_level":"1000"
            }
        """
        And params payloadServer
        When method post
        Then status 200
    
    Scenario: Configure SMPP supplier
        Given path 'configure/server/supplierconn1'
        * def payloadServerConfigure = 
        """
            {
                "system_id":"supplierconn1",
                "window_size":"600",
                "mps":"0",
                "enquire_link_period":"60000",
                "send_dlr_on_submit":"true",
                "respond_submit":"true",
                "enquire_link_response":"true"
            }
        """
        And params payloadServerConfigure
        When method post
        Then status 200
    
    Scenario: Create SMPP client
        Given path 'create/client'
        * def payloadClinet = 
        """
            {
                "name":"user1",
                "service_id":"user1",
                "statistics_only":"false",
                "statistics_response_time_warning_level":"1000"
            }
        """
        And params payloadClinet
        When method post
        Then status 200
    
    Scenario: Configure SMPP client
        Given path 'configure/client/user1'
        * def payloadClientConfigure = 
        """
            {
                "host":"172.20.0.230",
                "port":"2775",
                "ssl":"false",
                "window_size":"600",
                "response_timeout":"10000",
                "mps":"600",
                "submit_delay_ms":"0",
                "enquire_link_period":"60000",
                "sequence_number_start":"1"
            }
        """
        And params payloadClientConfigure
        When method post
        Then status 200
    
    Scenario: Connect client
        Given path 'connect/user1'
        When method post
        Then status 200
    
    Scenario: Create connectionlink to client
        Given path 'connectionlink/user1'
        And param link_service_id = 'user1'
        When method post
        Then status 200
    
    Scenario: Bind client
        Given path 'bind/user1'
        * def payloadBind = 
        """
            {
                "bind_type":"transceiver",
                "system_id":"user1",
                "password":"12345"
            }
        """
        And params payloadBind
        When method post
        Then status 200
    
    Scenario: Create message batch
        Given path 'submit_sm/batch/create/user1'
        And param batch_id = 'testmessage01'
        When method post
        Then status 200
    
    Scenario: Add message to batch
        Given path 'submit_sm/batch/add/user1'
        * def payloadMessage = 
        """
            {
                "batch_id":"testmessage01",
                "submit_id":"testmessage01_1",
                "repeat":"1",
                "source_addr_ton":"2",
                "source_addr_npi":"4",
                "source_addr":"35699523380",
                "dest_addr_ton":"1",
                "dest_addr_npi":"1",
                "destination_addr":"35699523365",
                "esm_class":"3",
                "data_coding":"3",
                "message_payload":"c2FtcGxlIHNtcHAgbWVzc2FnZSB1c2luZyBrYXJhdGU",
                "service_type":"SMPP"
            }
        """
        And params payloadMessage
        When method post
        Then status 200
    
    Scenario: Submit batch
        Given path 'submit_sm/batch/submit/user1'
        * def payloadMessageSubmit = 
        """
            {
                "batch_id":"testmessage01",
                "repeat":"1",
                "shuffle":"true"
            }
        """
        And params payloadMessageSubmit
        When method post
        Then status 200
        * eval sleep(10000)
        * pcapValidation.stopPcapWriting()

    
    Scenario: Validate Submit_sm packet count in pcap file   
        * def filter = "'smpp.command_id==0x00000004 || smpp.command_id==0x00000005'"
        * def pcapData = pcapValidation.readPcapFile(pcapFilename,filter)
        * print pcapData
        * match 1 == countPattern(pcapData,"Submit_sm")
        * match 1 == countPattern(pcapData,"Deliver_sm")
		
	
	Scenario: Validate DCS, destination_addr and source_addr Value in Submit_sm packet 
        * def filter = "'smpp.command_id==0x00000004' -T json"
        * def pcapData = pcapValidation.readPcapFile(pcapFilename,filter)
        * json jsonVar = pcapData
        * print jsonVar
        * match jsonVar[0]._source.layers.smpp["smpp.data_coding"] == '0x00000003'
        * match jsonVar[0]._source.layers.smpp["smpp.source_addr"] == '35699523380'
        * match jsonVar[0]._source.layers.smpp["smpp.destination_addr"] == '35699523365'