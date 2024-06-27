public with sharing class AllAccountsContactsController {
    public transient List<Account> accs { get; set; }
    public String searchString { get; set; }
    
    public AllAccountsContactsController() {
        accs = new List<Account>();
        searchString = '';
        fetchAccs();
    }
    
    public void fetchAccs() {
        String filterName = ApexPages.currentPage().getParameters().get('filterName');
        
        String query = 'SELECT Id, Name, Phone, Website, Industry, (SELECT Id, Name FROM Contacts) FROM Account WHERE 1 = 1';
        
        if (!String.isEmpty(filterName)) {
            query += ' AND Name LIKE %' + String.escapeSingleQuotes(filterName) + '%';
        }
        
        if (!String.isEmpty(searchString)) {
            query += ' AND Name Like ' + String.escapeSingleQuotes(searchString);
        }

        accs = Database.query(query);
    }

    public void searchAccs() {
        searchString = '%' + searchString + '%';
        fetchAccs();
    }
    
    public String getContacts(Account acc) {
        List<String> contactNames = new List<String>();
        for (Contact con : acc.Contacts) {
            contactNames.add(con.Name);
        }
        return String.join(contactNames, ', ');
    }

    public void edit() {
        return null;
    }

    public void save() {
        try {
            update accs;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving changes: ' + e.getMessage()));
        }
        return null;
    }

    public void cancel() {
        return null;
    }
}