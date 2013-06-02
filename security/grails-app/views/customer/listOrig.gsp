
<%@ page import="com.testapp.Customer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
<link rel="stylesheet" href="${resource(dir:'css',file:'ui.jqgrid.css')}" />
<link rel="stylesheet" href="${resource(dir:'css/redmond',file:'jquery-ui-1.9.1.custom.min.css')}" />
<g:javascript library="jquerymin"/>
<g:javascript library="jqueryuilatest"/>
<g:javascript library="jquerygridlocale"/>
<g:javascript library="jquerygrid"/>




	</head>
	<body>
		<a href="#list-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id='message' class="message" style="display:none;"></div>

<div style="margin-top:5px">
  <input class="ui-corner-all" id="btnAdd" type="button" value="Add Record"/>
  <input class="ui-corner-all" id="btnEdit" type="button" value="Edit Selected Record"/>
  <input class="ui-corner-all" id="btnDelete" type="button" value="Delete Selected Record"/>
</div>		
		<!-- table tag will hold our grid -->
<table id="customer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="customer_list_pager" class="scroll" style="text-align:center;"></div>

<script type="text/javascript">// <![CDATA[
  /* when the page has finished loading.. execute the follow */
  $(document).ready(function () {
	// set on click events for non toolbar buttons
      $("#btnAdd").click(function(){
        $("#customer_list").jqGrid("editGridRow","new",
           {addCaption:'Create New Customer',
           afterSubmit:afterSubmitEvent,
           savekey:[true,13]});
      });

      $("#btnEdit").click(function(){
         var gr = $("#customer_list").jqGrid('getGridParam','selrow');
         if( gr != null )
           $("#customer_list").jqGrid('editGridRow',gr,
           {closeAfterEdit:true,
            afterSubmit:afterSubmitEvent
           });
         else
           alert("Please Select Row");
      });

      $("#btnDelete").click(function(){
          
        var gr = $("#customer_list").jqGrid('getGridParam','selrow'); //if multi use: 'selarrrow'
        
        if( gr != null && gr != "" )
          $("#customer_list").jqGrid('delGridRow', gr , {afterSubmit:afterSubmitEvent});
        else
          alert("Please Select Row to delete!");
      });

      //initialize the grid
    jQuery("#customer_list").jqGrid({
      url:'jq_customer_list',
      editurl:'jq_edit_customer',
      datatype: "json",
      colNames:['First Name','Last Name','Age','Email Address','id'],
      colModel:[
        {name:'firstName', editable:true,editrules:{required:true}},
        {name:'lastName', editable:true,editrules:{required:true}},
        {name:'age', editable:true,editoptions:{size:3},editrules:{required:true,integer:true}},
        {name:'emailAddress', editable:true,editoptions:{size:30},editrules:{required:true,email:true}},
        {name:'id',hidden:true}
     ],
     rowNum:2,
     rowList:[1,2,3,4],
     multiselect: false,
    pager: jQuery('#customer_list_pager'),
    viewrecords: true,
    gridview: true,
    cellEdit:true,
    cellsubmit: 'remote',
    cellurl:'jq_edit_customer'
    }).navGrid('#customer_list_pager',
            {add:false,edit:false,del:false,search:false,refresh:true}, // which buttons to show?
            {closeAfterEdit:true, afterSubmit:afterSubmitEvent,savekey:[true,13]},         // edit options
            {addCaption:'Create New Customer',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterEdit:false},  // add options            
            {}          // delete options
        );
    $("#customer_list").jqGrid('filterToolbar',{autosearch:true});
  });  
// ]]>
  function afterSubmitEvent(response, postdata) {
      var success = true;
  
      var json = eval('(' + response.responseText + ')');
      var message = json.message;

      if(json.state == 'FAIL') {
          success = false;
      } else {
        $('#message').html(message);
        $('#message').show().fadeOut(10000);
      }
      
      var new_id = json.id
      return [success,message,new_id];
  }
</script>
	</body>
</html>
