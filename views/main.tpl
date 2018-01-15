[[ define "main_layout" ]]
<!DOCTYPE html>
<html>
	<head>
		<title>[[.HtmlTitle]]</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="/css/style.css">
		<link rel="icon" href="/img/lintasarta_icon.png" type="image/gif">
		<script src="/js/jquery-3.2.1.min.js"></script>
		<script src="/js/app.js"></script>
	</head>
	<body>
		<div id="app-container">
			<div id="app-loading-bar"></div>
			<div id="app-status-page" style="display: none;">Aku Rumah</div>
			[[ template "navigation". ]]
			[[ template "login_popup". ]]
			[[ template "table_monitor". ]]
		</div>
		[[ template "side_notification_bar". ]]
	</body>
</html>
[[ end ]]

[[ define "login_popup" ]]
<br>
<div id="app-login-popup" class="app-modal">
	<div class="app-modal-content">
		<h2 class="app-login-header">Sign in to StockApps</h2>
		<div class="app-login-alert"></div>
		<form class="app-login-form">
			<label><input class="app-username input-text" type="text" placeholder="Username"></label><br>
			<label><input class="app-password input-text" type="password" placeholder="Password"></label><br><br>
			<label><input class="app-login-btn" type="submit" value="Sign in"></label>
		</form>
		<br>
		<button class="app-close-btn">Close</button><br><br>
		<p><b>&copy;AQX</b> <a href="https://github.com/anggitmg" target="_blank" style="color: grey;">GitHub</a></p>
	</div>
</div>
[[ end ]]

[[ define "table_monitor" ]]
<div id="app-user-islogged-in" style="display: none;">[[ .HtmlUserIsLoggedIn ]]</div>
<div id="app-table-nav">
	<button class="sub-nav our-data">Our Items</button>&nbsp;
	<button class="sub-nav other-data">Other Items</button>&nbsp;
	<button class="sub-nav empty-data">Empty Items</button>
</div>
<div id="app-table-box"></div>

<div id="app-pickup-alert"></div>
<div id="app-modal-pickup-container"></div>
[[ end ]]

[[ define "side_notification_bar" ]]
<div id="app-side-notif">
</div>
[[ end ]]