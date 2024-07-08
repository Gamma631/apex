trigger HighPrioCaseTrigger on Case (after insert) {
    List<High_Prio_Case__e> eventList = new List<High_Prio_Case__e>();
    
    for (Case newCase : Trigger.new) {
        if (newCase.Priority == 'High') {
            High_Prio_Case__e event = new High_Prio_Case__e(
                CaseNumber__c = newCase.CaseNumber
            );
            eventList.add(event);
        }
    }
    
    if (!eventList.isEmpty()) {
        Database.SaveResult[] results = EventBus.publish(eventList);
        for (Database.SaveResult result : results) {
            if (!result.isSuccess()) {
                System.debug('Error publishing event: ' + result.getErrors()[0].getMessage());
            }
        }
    }
}
