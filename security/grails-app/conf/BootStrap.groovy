import com.testapp.* 

//Just a test

class BootStrap {

    def init = { servletContext ->
		def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true) 
		def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
		
		def testUser = new Person(username: 'me', enabled: true, password: 'password') 
		testUser.save(flush: true)
		
		PersonRole.create testUser, adminRole, true
		
		assert Person.count() == 1 
		assert Role.count() == 2 
		assert PersonRole.count() == 1
		
		// if we have an empty customer database,
		// create some test data
		if (Customer.count() == 0) {
		  new Customer(
			firstName:'John', lastName:'Smith',
			age:27,
			emailAddress:'john@somewhere.com'
		  ).save()
	
		  new Customer(
			firstName:'Frank', lastName:'Malone',
			age:37,
			emailAddress:'frank@somewhere.com'
		  ).save()
	
		  new Customer(
			firstName:'Dave', lastName:'Brown',
			age:34,
			emailAddress:'dave@somewhere.com'
		  ).save()
	
		  //customer and invoices
		  def invoice1 = new Invoice(invoiceNo:"inv-ds-001",amount:87.03)
		  def item1 = new InvoiceItem(name: "Laptop thinkpad")
		  def item2 = new InvoiceItem(name: "Docking station")
		  def customer = new Customer(
			firstName:'Barney', lastName:'Rubble',
			age:44,
			emailAddress:'barney@somewhere.com'
		  )		  	
		  	  
		  invoice1.addToItems(item1)
		  invoice1.addToItems(item2)		 
		  customer.addToInvoices(invoice1)		  
		  customer.save(flush:true)
		  if(customer.hasErrors()){
			  println(customer.errors)
		  }
		 // invoice1.save()
		 // if(invoice1.hasErrors()){
		//	  println(invoice1.errors)
		 // }
		  
		}
    }
    def destroy = {
    }
}
