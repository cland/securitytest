<%@ page import="com.testapp.Customer" %>



<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="customer.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="50" required="" value="${customerInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="customer.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="50" required="" value="${customerInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'age', 'error')} ">
	<label for="age">
		<g:message code="customer.age.label" default="Age" />
		
	</label>
	<g:field name="age" type="number" value="${customerInstance.age}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'emailAddress', 'error')} ">
	<label for="emailAddress">
		<g:message code="customer.emailAddress.label" default="Email Address" />
		
	</label>
	<g:textField name="emailAddress" value="${customerInstance?.emailAddress}"/>
</div>

