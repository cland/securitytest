import com.testapp.Customer
import com.testapp.Person
import com.testapp.Role
import com.testapp.PersonRole 

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
	
		  new Customer(
			firstName:'Barney', lastName:'Rubble',
			age:44,
			emailAddress:'barney@somewhere.com'
		  ).save()
		}
    }
    def destroy = {
    }
}
