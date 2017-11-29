<Query Kind="Program">
  <Connection>
    <ID>a35dd2f1-5438-4786-9c8c-9e2101776697</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>eBikes</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

void Main()
{
	foreach (Customers other in Customers)
	{
		OnlineCustomer customer = new OnlineCustomer();
		customer.UserName = other.FirstName.Substring(1, 1) + other.LastName;
		customer.TrackingCookie = Guid.NewGuid();
		customer.CreatedOn = DateTime.Now;
		customer.Dump();
		OnlineCustomers.InsertOnSubmit(customer);
		SubmitChanges();
	}
}
