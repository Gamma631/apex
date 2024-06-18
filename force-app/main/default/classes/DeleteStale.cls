public with sharing class DeleteStale implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id FROM Account WHERE Id NOT IN (SELECT AccountId FROM Opportunity WHERE CloseDate >= LAST_N_DAYS:180 AND IsClosed = false)';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        Database.delete(scope);
    }

    public void finish(Database.BatchableContext bc){
        
    }
}