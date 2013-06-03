package com.testapp

class Customer {
    static constraints = {
    firstName(blank:false,maxSize:50)
    lastName(blank:false,maxSize:50)
    age(nullable:true)
    emailAddress(nullable:true)
  }

	static hasMany = [invoices:Invoice]
  String firstName
  String lastName
  Integer age
  String emailAddress
  
  String toString(){
	  return "${firstName} ${lastName}"
  }
}
