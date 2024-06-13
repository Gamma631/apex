trigger preventInsertOnContactPhone on Contact (before insert) {
	for (Contact con : Trigger.New) {
		if ([SELECT Phone FROM Contact WHERE Phone = :con.Phone].size() > 1) {
			con.addError('Error: Provided phone number is already in use. Please try a different phone number.');
		}
	}
}