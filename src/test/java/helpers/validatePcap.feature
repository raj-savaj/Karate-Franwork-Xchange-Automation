Feature:Pcap Validation
    Scenario: Pcap Validation
        * def validatePcap = Java.type("helpers.validatePcap")
        * def pcapValidation = new validatePcap()