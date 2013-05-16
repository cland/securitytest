import racetrack.Race
import racetrack.Registration
import racetrack.Runner
import racetrack.User
import grails.util.*

class BootStrap {

	def init = { servletContext ->
		println "Bootstrap > environment: " + Environment.getCurrent()
		switch(Environment.getCurrent()){
			case "DEVELOPMENT":
		def jane = new Runner(firstName:"Jane",
		lastName:"Doe",
		dateOfBirth:(new Date() - 365*30),
		gender:"F",
		address:"123 Main St",
		city:"Goose",
		state:"NC",
		zipcode:"12345",
		email:"jane@whereever.com")
		jane.save()

		def jay = new Runner(firstName:"Jay",
		lastName:"Deembs",
		dateOfBirth:(new Date() - 365*30),
		gender:"M",
		address:"123 Main St",
		city:"Cape Town",
		state:"NC",
		zipcode:"3345",
		email:"jay@whereever.com")
		jay.save()
		
		def admin = new User(login:"admin",
		password:"wordpass",
		role:"admin")
		admin.save()
		if(admin.hasErrors()){
			println admin.errors
		}

		def jdoe = new User(login:"jdoe",
		password:"password",
		role:"user")
		jdoe.save()
		if(jdoe.hasErrors()){
			println jdoe.errors
		}

		def trot = new Race(
				name:"Turkey Trot",
				startDate:(new Date() + 90),
				city:"Duck",
				state:"NC",
				distance:5.0,
				cost:20.0,
				maxRunners:350
				)
		trot.save()
		if(trot.hasErrors()){
			println trot.errors
		}
		def reg = new Registration(
				paid:false,
				runner:jane,
				race:trot
				)
		reg.save()
		if(reg.hasErrors()){
			println reg.errors
		}
		
		def burner = new Race(
				name:"Barn Burner",
				startDate:(new Date() + 120),
				city:"Cary",
				state:"NC",
				distance:10.0,
				cost:15.0,
				maxRunners:350
				)
		burner.save()
		if(burner.hasErrors()){
			println burner.errors
		}
		def chase = new Race(
				name:"Race for the Chase",
				startDate:(new Date() + 150),
				city:"Duck",
				state:"NC",
				distance:5.0,
				cost:25.0,
				maxRunners:350
				)
		chase.save()
		if(chase.hasErrors()){
			println chase.errors
		}
				break
			case "PRODUCTION" :
			def admin = new User(login:"admin",	password:"wordpass",role:"admin")
				admin.save()
				if(admin.hasErrors()){
					println admin.errors
				}
			break
		}
	} //end init
	
	
	def destroy = {
	}
} //end class
