
<%@ page import="com.testapp.Customer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<g:javascript library="mscorlib"/>
<g:javascript library="PerfectWidgets"/>

	</head>
	<body>
		<a href="#show-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-customer" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			
			<!--widget will be in the div below-->
	<div id="root">
	</div>

	<div>
		<input type="text" id="valbox" value="60"/>
		<button onclick="updateVal();">Set value</button>
	</div>
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list customer">
			
				<g:if test="${customerInstance?.firstName}">
				<li class="fieldcontain">
					<span id="firstName-label" class="property-label"><g:message code="customer.firstName.label" default="First Name" /></span>
					
						<span class="property-value" aria-labelledby="firstName-label"><g:fieldValue bean="${customerInstance}" field="firstName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.lastName}">
				<li class="fieldcontain">
					<span id="lastName-label" class="property-label"><g:message code="customer.lastName.label" default="Last Name" /></span>
					
						<span class="property-value" aria-labelledby="lastName-label"><g:fieldValue bean="${customerInstance}" field="lastName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.age}">
				<li class="fieldcontain">
					<span id="age-label" class="property-label"><g:message code="customer.age.label" default="Age" /></span>
					
						<span class="property-value" aria-labelledby="age-label"><g:fieldValue bean="${customerInstance}" field="age"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.emailAddress}">
				<li class="fieldcontain">
					<span id="emailAddress-label" class="property-label"><g:message code="customer.emailAddress.label" default="Email Address" /></span>
					
						<span class="property-value" aria-labelledby="emailAddress-label"><g:fieldValue bean="${customerInstance}" field="emailAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.invoices}">
				<li class="fieldcontain">
					<span id="invoices-label" class="property-label"><g:message code="customer.invoices.label" default="Invoices" /></span>
					
						<g:each in="${customerInstance.invoices}" var="i">
						<span class="property-value" aria-labelledby="invoices-label"><g:link controller="invoice" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${customerInstance?.id}" />
					<g:link class="edit" action="edit" id="${customerInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
		<script type="text/javascript">
        var slider;
        window.onload = function () {
            //widget model
            var jsonModel = {"Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":null,"JSBindingsText":null,"Name":"Instrument","RecalculateAll":false,"Smooth":true,"Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":1,"Color":{"knownColor":35,"name":null,"state":1,"value":0},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1},"Style":"Default","ToolTipValue":null,"Visible":true,"Elements":[{"__type":"Circle:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4293256677}},"JSBindingsText":"this.setCenter(new PerfectWidgets.Framework.DataObjects.Vector((this.getInstrument().getByName('Instrument') .getSize() .getWidth()\/2),(this.getInstrument().getByName('Instrument') .getSize() .getHeight()\/2)));\u000a","Name":"Circle1","RecalculateAll":false,"Smooth":true,"Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":6,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1},"Style":"Circle1","ToolTipValue":null,"Visible":true,"Center":{"Height":612.5,"Length":866.20580695352066,"Rotation":0.78539816339744828,"Width":612.5,"X":612.5,"Y":612.5},"Radius":603.125},{"__type":"Circle:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4293256677}},"JSBindingsText":"this.setCenter(this.getInstrument().getByName('Circle1') .getCenter());\u000a","Name":"Circle2","RecalculateAll":false,"Smooth":true,"Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":6,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1},"Style":"Circle1","ToolTipValue":null,"Visible":true,"Center":{"Height":612.5,"Length":866.20580695352066,"Rotation":0.78539816339744828,"Width":612.5,"X":612.5,"Y":612.5},"Radius":568.75},{"__type":"Joint:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":null,"JSBindingsText":"this.setCenter(this.getInstrument().getByName('Circle1') .getCenter());\u000a","Name":"Joint1","RecalculateAll":false,"Smooth":true,"Stroke":null,"Style":"","ToolTipValue":null,"Visible":true,"Elements":[{"__type":"Scale:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":null,"JSBindingsText":null,"Name":"Scale1","RecalculateAll":false,"Smooth":true,"Stroke":null,"Style":"","ToolTipValue":null,"Visible":true,"Elements":[{"__type":"Ticks:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":null,"JSBindingsText":"this.setDistance(this.getInstrument().getByName('Joint1') .getRadius());\u000a","Name":"Ticks1","RecalculateAll":false,"Smooth":true,"Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":7,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1},"Style":"Ticks1","ToolTipValue":null,"Visible":true,"Colorizer":null,"Distance":387.5,"Dock":0,"MaxLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"MinLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"OriginWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"Padding":0,"Divisions":11,"StepWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"SubDivisions":5,"SubTicksPosition":0,"UseDescreteValues":false,"UseRoundValues":false,"Length":56.25,"SubLength":37.5},{"__type":"ScaleLabels:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":null,"JSBindingsText":"this.setDistance((this.getInstrument().getByName('Joint1') .getRadius()+106.25));\u000a","Name":"ScaleLabels1","RecalculateAll":false,"Smooth":true,"Stroke":null,"Style":"ScaleLabels1","ToolTipValue":null,"Visible":true,"Colorizer":null,"Distance":493.75,"Dock":0,"MaxLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":2,"Value":99},"MinLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"OriginWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"Padding":0,"Font":{"Bold":1,"FamilyName":"Arial","Italic":2,"Size":18,"Strikeout":2,"Underline":2},"Format":{"CurrencyNegativePattern":0,"CurrencyPositivePattern":0,"CurrencySymbol":"$","DateSeparator":".","DecimalPlaces":2,"DecimalSeparator":".","FormatMask":"","FormatStyle":0,"GroupSeparator":" ","NumberNegativePattern":0,"PercentNegativePattern":0,"PercentPositivePattern":0,"UseCultureSettings":true,"UseGroupSeparator":true},"Formula":"","ItemMargins":{},"OddLabelsDistance":0,"Position":1,"ShowSuperposableLabels":true,"TextAlignment":1,"TextAngle":90,"TextRotationMode":1,"Divisions":11,"StepWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"UseRoundValues":false},{"__type":"RangedLevel:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4286545791}},"JSBindingsText":"this.setDistance((this.getInstrument().getByName('Joint1') .getRadius()-93.75));\u000a","Name":"RangedLevel2","RecalculateAll":false,"Smooth":true,"Stroke":null,"Style":"RangedLevel2","ToolTipValue":null,"Visible":true,"Colorizer":null,"Distance":293.75,"Dock":0,"MaxLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"MinLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"OriginWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"Padding":0,"ValueWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"Colors":[],"Divisions":0,"DivisionsStroke":null,"EndColor":{"knownColor":164,"name":null,"state":1,"value":0},"StartColor":{"knownColor":35,"name":null,"state":1,"value":0},"AlignmentMode":0,"EndWidth":62.5,"StartWidth":62.5},{"__type":"Slider:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":null,"JSBindingsText":null,"Name":"Slider1","RecalculateAll":false,"Smooth":true,"Stroke":null,"Style":"","ToolTipValue":null,"Visible":true,"Elements":[{"__type":"RangedLevel:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4288269823}},"JSBindingsText":"this.setDistance((this.getInstrument().getByName('Joint1') .getRadius()-90.625));\u000athis.setValue(this.getInstrument().getByName('Slider1').getAnimationValue());\u000a","Name":"RangedLevel1","RecalculateAll":false,"Smooth":true,"Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":4,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1},"Style":"Needle1","ToolTipValue":null,"Visible":true,"Colorizer":null,"Distance":296.875,"Dock":0,"MaxLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"MinLimitWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"OriginWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":0,"Value":0},"Padding":0,"ValueWrapper":{"__type":"SmartValueWrapper:#PerpetuumSoft.Instrumentation.Model","Kind":1,"Value":48.99466487115037},"Colors":[],"Divisions":0,"DivisionsStroke":null,"EndColor":{"knownColor":164,"name":null,"state":1,"value":0},"StartColor":{"knownColor":35,"name":null,"state":1,"value":0},"AlignmentMode":0,"EndWidth":56.25,"StartWidth":56.25},{"__type":"Needle:#PerpetuumSoft.Instrumentation.Model","Active":true,"BreakEventsBubbling":false,"CssClass":{},"Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4288269823}},"JSBindingsText":"this.setStartPoint(this.getInstrument().getByName(\"Slider1\").getPosition(0));\u000athis.setEndPoint(this.getInstrument().getByName(\"Slider1\").getPosition((this.getInstrument().getByName('Joint1') .getRadius()+50)));\u000a","Name":"Needle1","RecalculateAll":false,"Smooth":true,"Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":4,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1},"Style":"Needle1","ToolTipValue":null,"Visible":true,"EndPoint":{"Height":200.48791367725869,"Length":506.70371667123413,"Rotation":0.40679824770497075,"Width":465.35282631330648,"X":465.35282631330648,"Y":200.48791367725869},"StartPoint":{"Height":612.5,"Length":866.20580695352066,"Rotation":0.78539816339744828,"Width":612.5,"X":612.5,"Y":612.5},"EndWidth":0,"NeedlePoints":[],"ShowMode":0,"StartWidth":62.5}],"MaxLimit":{"Kind":0,"Value":0},"MinLimit":{"Kind":0,"Value":0},"Step":0,"Value":48.99466487115037}],"Colorizer":null,"Maximum":110,"Minimum":0,"Reverse":false}],"Margins":{},"Center":{"Height":612.5,"Length":866.20580695352066,"Rotation":0.78539816339744828,"Width":612.5,"X":612.5,"Y":612.5},"Dock":0,"Radius":387.5,"StartAngle":90,"TotalAngle":360}],"Enabled":true,"Focused":false,"GridStep":25,"IsFixed":false,"MeasureUnit":{},"Parameters":[],"ShowGrid":true,"Size":{"Height":1225,"Length":1732.4116139070413,"Rotation":0.78539816339744828,"Width":1225,"X":1225,"Y":1225},"SnapToGrid":true,"Styles":[{"__type":"Style:#PerpetuumSoft.Instrumentation.Styles","Fill":null,"Font":{"Bold":0,"FamilyName":"Microsoft Sans Serif","Italic":0,"Size":10,"Strikeout":0,"Underline":0},"Image":null,"Name":"Default","Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":1,"Color":{"knownColor":35,"name":null,"state":1,"value":0},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1}},{"__type":"Style:#PerpetuumSoft.Instrumentation.Styles","Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4293256677}},"Font":null,"Image":null,"Name":"Circle1","Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":6,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1}},{"__type":"Style:#PerpetuumSoft.Instrumentation.Styles","Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4286545791}},"Font":null,"Image":null,"Name":"RangedLevel2","Stroke":null},{"__type":"Style:#PerpetuumSoft.Instrumentation.Styles","Fill":{"__type":"SolidFill:#PerpetuumSoft.Framework.Drawing","Color":{"knownColor":0,"name":null,"state":2,"value":4288269823}},"Font":null,"Image":null,"Name":"Needle1","Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":4,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1}},{"__type":"Style:#PerpetuumSoft.Instrumentation.Styles","Fill":null,"Font":{"Bold":1,"FamilyName":"Arial","Italic":2,"Size":18,"Strikeout":2,"Underline":2},"Image":null,"Name":"ScaleLabels1","Stroke":null},{"__type":"Style:#PerpetuumSoft.Instrumentation.Styles","Fill":null,"Font":null,"Image":null,"Name":"Ticks1","Stroke":{"__type":"SimpleStroke:#PerpetuumSoft.Framework.Drawing","Width":7,"Color":{"knownColor":0,"name":null,"state":2,"value":4286545791},"DashLenght":5,"DotLenght":1,"SpaceLenght":2,"Style":1}}]};
            //creating widget
            var widget = new PerfectWidgets.Widget("root", jsonModel);
            //getting slider object
            slider = widget.getByName("Slider1");
        }
        //
        function updateVal() {
            //set new slider value
            slider.setValue(document.getElementById("valbox").value);
         }
    </script>
	</body>
</html>
