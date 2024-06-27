public with sharing class DisplayAccountController {
    public String accId { get; set; }
    public transient Account acc { get; private set; }
    public Boolean displayacc { get; private set; }
    public transient List<Contact> relatedContacts { get; private set; }

    public DisplayAccountController() {
        relatedContacts = new List<Contact>();
    }
    
    public void fetchAcc() {
        try {
            acc = [SELECT Name, Phone, Website, Industry FROM Account WHERE Id = :accId LIMIT 1];
            displayacc = true; 
            relatedContacts = acc.Contacts;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error fetching Account: ' + e.getMessage()));
            displayacc = false;
            relatedContacts.clear();
        }
    }
}