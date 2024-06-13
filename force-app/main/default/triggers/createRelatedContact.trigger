trigger createRelatedContact on Account (after insert) {
	List<Contact> cons = new List<Contact>();
	for (Account a : Trigger.New) {
		Contact con = new Contact();
		con.AccountId = a.Id;
		con.Email = (a.Email != null && a.Email != '') ? a.Email : 'dummy@email.com';
		cons.add(con);
	}
	insert con;
}