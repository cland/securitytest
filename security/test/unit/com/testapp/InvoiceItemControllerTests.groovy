package com.testapp



import org.junit.*
import grails.test.mixin.*

@TestFor(InvoiceItemController)
@Mock(InvoiceItem)
class InvoiceItemControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/invoiceItem/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.invoiceItemInstanceList.size() == 0
        assert model.invoiceItemInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.invoiceItemInstance != null
    }

    void testSave() {
        controller.save()

        assert model.invoiceItemInstance != null
        assert view == '/invoiceItem/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/invoiceItem/show/1'
        assert controller.flash.message != null
        assert InvoiceItem.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/invoiceItem/list'

        populateValidParams(params)
        def invoiceItem = new InvoiceItem(params)

        assert invoiceItem.save() != null

        params.id = invoiceItem.id

        def model = controller.show()

        assert model.invoiceItemInstance == invoiceItem
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/invoiceItem/list'

        populateValidParams(params)
        def invoiceItem = new InvoiceItem(params)

        assert invoiceItem.save() != null

        params.id = invoiceItem.id

        def model = controller.edit()

        assert model.invoiceItemInstance == invoiceItem
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/invoiceItem/list'

        response.reset()

        populateValidParams(params)
        def invoiceItem = new InvoiceItem(params)

        assert invoiceItem.save() != null

        // test invalid parameters in update
        params.id = invoiceItem.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/invoiceItem/edit"
        assert model.invoiceItemInstance != null

        invoiceItem.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/invoiceItem/show/$invoiceItem.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        invoiceItem.clearErrors()

        populateValidParams(params)
        params.id = invoiceItem.id
        params.version = -1
        controller.update()

        assert view == "/invoiceItem/edit"
        assert model.invoiceItemInstance != null
        assert model.invoiceItemInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/invoiceItem/list'

        response.reset()

        populateValidParams(params)
        def invoiceItem = new InvoiceItem(params)

        assert invoiceItem.save() != null
        assert InvoiceItem.count() == 1

        params.id = invoiceItem.id

        controller.delete()

        assert InvoiceItem.count() == 0
        assert InvoiceItem.get(invoiceItem.id) == null
        assert response.redirectedUrl == '/invoiceItem/list'
    }
}
