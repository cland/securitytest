<div id="main-header" role="banner">

	<div id="header">
	<g:render template="/layouts/raceSearch" />
		<p>
			<a class="header-main" href="${resource(dir:'')}"> RaceTrack </a>
		</p>
		<p class="header-sub">When's your next race?</p>
		<div id="loginHeader">
			<g:loginControl />
		</div>
	</div>
		<div id="grailsLogo">
		<a href="/racetrack/"> <img
			src="${resource(dir: 'images', file: 'tagumi_logo_128_trans.png')}"
			alt="Grails" /></a>
	</div>
</div>
