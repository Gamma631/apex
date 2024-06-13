trigger preventDelete on Account (before delete) {
	for (Account a : Trigger.New) {
		List<Contact> con = [SELECT Id FROM Contact WHERE AccountId = :a.Id];
		if (!con.isEmpty()) {
			a.addError('Error: Account is associated with at least one contact. Please remove this relation and try again.');
		}
	}
	
}