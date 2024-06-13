trigger assignOrdersProduct on Order (after insert) {
	Product2 prod = [SELECT Id FROM Product2 WHERE Name = 'Installation: Portable' LIMIT 1];
	List<OrderItem> ordItems = new List<OrderItem>();

	for (Order o : Trigger.new) {
		if ([SELECT COUNT() FROM OrderItem WHERE OrderId = :o.Id AND Product2Id = :prod.Id] == 0) {
			OrderItem insertProd = new OrderItem(
				OrderId = o.Id,
				Product2Id = prod.Id,
				Quantity = 1
			);
			ordItems.add(insertProd);
		}
	}
	if (!ordItems.isEmpty()) {
		insert ordItems;
	}
}