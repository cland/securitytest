package com.testapp

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
class CustomerController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count()]
	}
	def subgrid(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count()]
	}
	def create() {
		[customerInstance: new Customer(params)]
	}

	def save() {
		def customerInstance = new Customer(params)
		if (!customerInstance.save(flush: true)) {
			render(view: "create", model: [customerInstance: customerInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])
		redirect(action: "show", id: customerInstance.id)
	}

	def show(Long id) {
		def customerInstance = Customer.get(id)
		if (!customerInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), id])
			redirect(action: "list")
			return
		}

		[customerInstance: customerInstance]
	}

	def edit(Long id) {
		def customerInstance = Customer.get(id)
		if (!customerInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), id])
			redirect(action: "list")
			return
		}

		[customerInstance: customerInstance]
	}

	def update(Long id, Long version) {
		def customerInstance = Customer.get(id)
		if (!customerInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), id])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (customerInstance.version > version) {
				customerInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[message(code: 'customer.label', default: 'Customer')] as Object[],
						"Another user has updated this Customer while you were editing")
				render(view: "edit", model: [customerInstance: customerInstance])
				return
			}
		}

		customerInstance.properties = params

		if (!customerInstance.save(flush: true)) {
			render(view: "edit", model: [customerInstance: customerInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])
		redirect(action: "show", id: customerInstance.id)
	}

	def delete(Long id) {
		def customerInstance = Customer.get(id)
		if (!customerInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), id])
			redirect(action: "list")
			return
		}

		try {
			customerInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), id])
			redirect(action: "show", id: id)
		}
	} //end method

	def jq_customer_list = {
		def sortIndex = params.sidx ?: 'lastName'
		def sortOrder  = params.sord ?: 'asc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def customers = Customer.createCriteria().list(max:maxRows, offset:rowOffset) {
			// first name case insensitive where the field begins with the search term
			if (params.firstName)
				ilike('firstName',params.firstName + '%')

			// last name case insensitive where the field begins with the search term
			if (params.lastName)
				ilike('lastName',params.lastName + '%')

			// age search where the age Equals the search term
			if (params.age)
				eq('age', Integer.valueOf(params.age))

			// email case insensitive where the field contains search term
			if (params.emailAddress)
				ilike('emailAddress','%' + params.emailAddress + '%')

			// set the order and direction
			order(sortIndex, sortOrder)
		}
		def totalRows = customers.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = customers.collect {
			[cell: [it.firstName,
					it.lastName,
					it.age,
					it.emailAddress
				], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
	} //end def

	def jq_edit_customer = {
		println(params)
		def customer = null
		def message = ""
		def state = "FAIL"
		def id

		// determine our action
		switch (params.oper) {
			case 'add':
			// add instruction sent
				customer = new Customer(params)
				if (! customer.hasErrors() && customer.save()) {
					message = "Customer  ${customer.firstName} ${customer.lastName} Added"
					id = customer.id
					state = "OK"
				} else {
					message = "Could Not Save Customer"
				}

				break;
			case 'del':
			// check customer exists
			//println(params)
				def idlist = params.list("id")				

				idlist = JSON.parse(idlist.toString())				

				for(int i=0;i<idlist.size();i++){					
					customer = Customer.get(idlist[i] as Long)
					//customer = Customer.get(params.id)
					if (customer) {
						// delete customer
						customer.delete()
						message = "${message} ${i+1}) Customer  ${customer.firstName} ${customer.lastName} Deleted. "
						state = "OK"
					}else{
					message = "${message} ${i+1}) failed to delete user with id ${idlist[i]}. "
					state = "fail"
					}
				}//end for loop
				break;
			default:
			// edit action
			// first retrieve the customer by its ID
				customer = Customer.get(params.id)
				if (customer) {
					// set the properties according to passed in parameters
					customer.properties = params
					if (! customer.hasErrors() && customer.save()) {
						message = "Customer  ${customer.firstName} ${customer.lastName} Updated"
						id = customer.id
						state = "OK"
					} else {
						message = "Could Not Update Customer"
					}
				}
				break;
		}//end switch statement

		def response = [message:message,state:state,id:id]

		render response as JSON
	} //end jq_edit_customer
	
	def jq_invoice_list = {
		//println(params)
		def invoices = Invoice.createCriteria().list() {
			eq "customer.id", params.id as long
			order('invoiceNo','asc')
		}
		
		def jsonCells = invoices.collect {
			[cell: [it.invoiceNo,
					it.amount,					
				], id: it.id]
		}
		def jsonData= [rows: jsonCells]
		render jsonData as JSON
	} //end list invoice
	def jq_edit_invoice = {
		println(params)
		def invoice = null
		def message = ""
		def state = "FAIL"
		def id

		// determine our action
		switch (params.oper) {
			case 'add':
			// add instruction sent
			params.put("customer.id", params.custid);
			//def customer = Customer.get(params.custid)
				invoice = new Invoice(params)
				if (! invoice.hasErrors() && invoice.save()) {
					message = "Invoice  ${invoice.toString()}  Added"
					id = invoice.id
					state = "OK"
				} else {
					message = "Could Not Add Invoice"
					println(invoice.errors)
				}

				break;
			case 'del':
			// check customer exists
			//println(params)
				def idlist = params.list("id")

				idlist = JSON.parse(idlist.toString())

				for(int i=0;i<idlist.size();i++){
					invoice = Invoice.get(idlist[i] as Long)
					//invoice = Invoice.get(params.id)
					if (invoice) {
						// delete invoice
						//invoice.delete()
						message = "${message} ${i+1}) Invoice  ${invoice.invoiceNo} amount: ${invoice.amount} Deleted. "
						state = "OK"
					}else{
					message = "${message} ${i+1}) failed to delete invoice with id ${idlist[i]}. "
					state = "fail"
					}
				}//end for loop
				break;
			default:
			// edit action
			// first retrieve the customer by its ID
				invoice = Invoice.get(params.id)
				if (invoice) {
					// set the properties according to passed in parameters
					invoice.properties = params
					if (! invoice.hasErrors() && invoice.save()) {
						message = "Invoice  ${invoice.toString()} Updated"
						id = invoice.id
						state = "OK"
					} else {
						message = "Could Not Update invoice"
					}
				}
				break;
		}//end switch statement

		def response = [message:message,state:state,id:id]

		render response as JSON
	} //end edit invoice
} //end class
