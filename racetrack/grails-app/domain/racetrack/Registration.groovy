package racetrack

class Registration {
	static constraints = {
		race()
		runner()
		paid()
		dateCreated()
	}
	static belongsTo = [race:Race, runner:Runner]
	Boolean paid
	Date dateCreated

	def beforeInsert = {
	// your code goes here
	}
	def beforeUpdate = {
	// your code goes here
	}
	def beforeDelete = {
	// your code goes here
	}
	def onLoad = {
	// your code goes here
	}
}
