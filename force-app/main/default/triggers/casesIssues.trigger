trigger casesIssues on Case (before insert, before update) {
	for (Case c : Trigger.new) {
		if (Trigger.isInsert) {
			if (c.Status != 'New') {
				c.Status = 'New';
			}
		}

		if (Trigger.isUpdate) {
			if ((c.Comments != '' && c.Comments != null) && c.Status == 'New') {
				c.Status = 'Working';
			}
		}
	}
}