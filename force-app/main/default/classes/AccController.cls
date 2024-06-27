public with sharing class AccController {
    public transient Account acc { get; set; }
    public String accId { get; set; }

    public AccController() {
        accId = ApexPages.currentPage().getParameters().get('id');
        if (accId != null) {
            acc = [SELECT Id, Name, Phone, Website, Industry FROM Account WHERE Id = :accId LIMIT 1];
        }
    }
}