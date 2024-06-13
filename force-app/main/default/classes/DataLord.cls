public with sharing class DataLord {
    public DataLord() {

    }

    public Integer NumAccounts() {
        return [SELECT COUNT() FROM Account];
    }

    public Integer NumHot() {
        return [SELECT COUNT() FROM Account WHERE Rating = 'Hot'];
    }

    public Integer NumComplex() {
        return [SELECT COUNT() FROM Account WHERE Name LIKE '%&%'];
    }

    public List<Account> BigFive() {
        return [SELECT Id, AnnualRevenue FROM Account ORDER BY AnnualRevenue LIMIT 5];
    }

    public List<Contact> MajorPlayers() {
        return [SELECT Id FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE Rating = 'Hot')];
    }

    public String MostPopularAccount() {
        List<Account> accs = [SELECT Id FROM Account];
        String mostAssociated = '';
        Integer mostCons = 0;
        for (Account a : accs) {
            Integer cons = [SELECT COUNT() FROM Contact WHERE AccountId = :a.Id];
            if (cons > mostCons) {
                mostCons = cons;
                mostAssociated = a.Name;
            }
        }
        return mostAssociated;
    }

    public List<Lead> TopLeadSources() {
        List<Lead> leads = [SELECT LeadSource, Status FROM Lead];
        Map<String, Integer> bestLeads = new Map<String, Integer>();
        for (Lead lead : leads) {
            if (lead.Status = 'Closed') { //this is not a value in this field.

            } 
        }
    }
}