package com.testapp

import org.springframework.dao.DataIntegrityViolationException

class InvoiceItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [invoiceItemInstanceList: InvoiceItem.list(params), invoiceItemInstanceTotal: InvoiceItem.count()]
    }

    def create() {
        [invoiceItemInstance: new InvoiceItem(params)]
    }

    def save() {
        def invoiceItemInstance = new InvoiceItem(params)
        if (!invoiceItemInstance.save(flush: true)) {
            render(view: "create", model: [invoiceItemInstance: invoiceItemInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), invoiceItemInstance.id])
        redirect(action: "show", id: invoiceItemInstance.id)
    }

    def show(Long id) {
        def invoiceItemInstance = InvoiceItem.get(id)
        if (!invoiceItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), id])
            redirect(action: "list")
            return
        }

        [invoiceItemInstance: invoiceItemInstance]
    }

    def edit(Long id) {
        def invoiceItemInstance = InvoiceItem.get(id)
        if (!invoiceItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), id])
            redirect(action: "list")
            return
        }

        [invoiceItemInstance: invoiceItemInstance]
    }

    def update(Long id, Long version) {
        def invoiceItemInstance = InvoiceItem.get(id)
        if (!invoiceItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (invoiceItemInstance.version > version) {
                invoiceItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'invoiceItem.label', default: 'InvoiceItem')] as Object[],
                          "Another user has updated this InvoiceItem while you were editing")
                render(view: "edit", model: [invoiceItemInstance: invoiceItemInstance])
                return
            }
        }

        invoiceItemInstance.properties = params

        if (!invoiceItemInstance.save(flush: true)) {
            render(view: "edit", model: [invoiceItemInstance: invoiceItemInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), invoiceItemInstance.id])
        redirect(action: "show", id: invoiceItemInstance.id)
    }

    def delete(Long id) {
        def invoiceItemInstance = InvoiceItem.get(id)
        if (!invoiceItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), id])
            redirect(action: "list")
            return
        }

        try {
            invoiceItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'invoiceItem.label', default: 'InvoiceItem'), id])
            redirect(action: "show", id: id)
        }
    }
}
