public with sharing class ScheduleDelete implements Schedulable {
    public void execute(SchedulableContext sc) {
        DeleteStale batch = new DeleteStale();
        Database.executeBatch(batch);
    }
}