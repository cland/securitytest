modules = {
    application {
        resource url:'js/application.js'
    }
	jquerymin{
		resource url: 'js/jquery-1.9.0.min.js', disposition: 'head'
	}
	jquerygrid{
		resource url: 'js/jquery.jqGrid.min.js', disposition: 'head'
	}
	jquerygridlocale{
		resource url: 'js/i18n/grid.locale-en.js', disposition: 'head'
	}
	jquerygridfmatter{
		resource url: 'js/jquery.fmatter.js', disposition: 'head'
	}
	jqueryuilatest{
		resource url: 'js/jquery-ui-1.9.1.custom.min.js', disposition: 'head'
	}
}