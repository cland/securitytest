package com.testapp

import org.springframework.dao.DataIntegrityViolationException

class InvoiceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [invoiceInstanceList: Invoice.list(params), invoiceInstanceTotal: Invoice.count()]
    }

    def create() {
        [invoiceInstance: new Invoice(params)]
    }

    def save() {
		println(params)
        def invoiceInstance = new Invoice(params)
        if (!invoiceInstance.save(flush: true)) {
            render(view: "create", model: [invoiceInstance: invoiceInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'invoice.label', default: 'Invoice'), invoiceInstance.id])
        redirect(action: "show", id: invoiceInstance.id)
    }

    def show(Long id) {
        def invoiceInstance = Invoice.get(id)
        if (!invoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
            redirect(action: "list")
            return
        }

        [invoiceInstance: invoiceInstance]
    }

    def edit(Long id) {
        def invoiceInstance = Invoice.get(id)
        if (!invoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
            redirect(action: "list")
            return
        }

        [invoiceInstance: invoiceInstance]
    }

    def update(Long id, Long version) {
        def invoiceInstance = Invoice.get(id)
        if (!invoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (invoiceInstance.version > version) {
                invoiceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'invoice.label', default: 'Invoice')] as Object[],
                          "Another user has updated this Invoice while you were editing")
                render(view: "edit", model: [invoiceInstance: invoiceInstance])
                return
            }
        }

        invoiceInstance.properties = params

        if (!invoiceInstance.save(flush: true)) {
            render(view: "edit", model: [invoiceInstance: invoiceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'invoice.label', default: 'Invoice'), invoiceInstance.id])
        redirect(action: "show", id: invoiceInstance.id)
    }

    def delete(Long id) {
        def invoiceInstance = Invoice.get(id)
        if (!invoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
            redirect(action: "list")
            return
        }

        try {
            invoiceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
            redirect(action: "show", id: id)
        }
    }
}
