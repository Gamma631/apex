public with sharing class AllAccountsContactsController {
    public List<Account> accs { get; set; }
    
    public AllAccountsContactsController() {
        accs = new List<Account>();
        fetchAccs();
    }
    
    public void fetchAccs() {
        accs = [SELECT Id, Name, Phone, Website, Industry, 
                    (SELECT Id, Name FROM Contacts) 
                    FROM Account];
    }
    
    public String getContacts(Account acc) {
        List<String> contactNames = new List<String>();
        for (Contact con : acc.Contacts) {
            contactNames.add(con.Name);
        }
        return String.join(contactNames, ', ');
    }
}