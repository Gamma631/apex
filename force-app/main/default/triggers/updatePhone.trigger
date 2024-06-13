trigger updatePhone on Contact (after update) {
	List<Account> accs = new List<Account>();
	for (Contact con : Trigger.new) {
		if (con.Phone != Trigger.oldMap.get(con.Id).Phone) {
			Account acc = [SELECT Phone FROM Account WHERE Id = :con.AccountId];
			acc.Phone = con.Phone;
			accs.add(acc);
		}
	}
	update accs;
}