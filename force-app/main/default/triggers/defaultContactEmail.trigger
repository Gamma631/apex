trigger defaultContactEmail on Contact (before insert) {
	for (Contact con : Trigger.New) {
		if (con.Email == '' || con.Email == null) {
			con.Email = 'dummy@email.com';
		}
	}
}