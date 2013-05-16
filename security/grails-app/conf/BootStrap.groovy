import com.testapp.Person
import com.testapp.Role
import com.testapp.PersonRole

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
    }
    def destroy = {
    }
}
