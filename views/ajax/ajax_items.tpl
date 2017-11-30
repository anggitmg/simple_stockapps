[[ define "items_layout" ]]

[[ template "script". ]]
[[ template "style". ]]

<div id="app-ajax-items">
	<h3>Items Management</h3>
	<span><i style="font-size: 90%;">You could add, remove (Administrator privilege), or request items (Operator privilege), Please choose one of navigation options below.</i></span>

	[[ template "side_navigation". ]]
	<div id="app-form-wrapper">
		[[ template "add_box". ]]
		[[ template "remove_box". ]]
	</div>
</div>

[[ end ]]

[[ define "script" ]]
<script>
$(document).ready(function() {
	var sideNavBar = $("div#app-side-nav ul li a");
	var addButton = $("a.item-add");
	var removeButton = $("a.item-remove");
	var addBox = $("div#app-add-content");
	var removeBox = $("div#app-remove-content");
	var hashUrl = window.location.hash;
	var getOptionFromHash = hashUrl.substring(22);

	// onload if current url has a hash url
	switch(getOptionFromHash) {
		case "add":
			addBox.css("display", "block");
			removeBox.css("display", "none");
			$("title").text("Adding Item - Simple StockApps");
			$("input[placeholder='Item Name']").focus();
		break;
		case "remove":
			removeBox.css("display", "block");
			addBox.css("display", "none");
			$("title").text("Removing Item - Simple StockApps");
		break;
	}

	// prevent default from clicked links		
	sideNavBar.click(function(e) {
		e.preventDefault();
	});

	// when addbutton click
	addButton.click(function() {
		var stateObj = { page: "items#add" };
		history.pushState(stateObj, "page", "/navbar?#navigate_link=/items#add");
		addBox.css("display", "block");
		removeBox.css("display", "none");
		$("title").text("Adding Item - Simple StockApps");
		$("input[placeholder='Item Name']").focus();
	});
	// when removebutton click
	removeButton.click(function() {
		var stateObj = { page: "items#remove" };
		history.pushState(stateObj, "page", "/navbar?#navigate_link=/items#remove");
		removeBox.css("display", "block");
		addBox.css("display", "none");
		$("title").text("Removing Item - Simple StockApps");
	});

	// handling request from form add items
	appFormAddItemsHandler();
});

// add items handler
function appFormAddItemsHandler() {
	var addItemForm = $("form.app-form-add");

	// Date and time variable
	// using current date and time on "date-of-entry" value when loaded
	var waktuBaru = new Date();	// new date object
	var tahun = waktuBaru.getFullYear(),	// full year (ex: 2017)
		bulan = waktuBaru.getMonth(),		// month (ex: 10)
		tanggal = waktuBaru.getDate(),		// date (ex: 01 or 12)
		currentTanggal = tahun + "-" + bulan + "-" + tanggal; // 
	var jam = waktuBaru.getHours(),
		menit = waktuBaru.getMinutes();

	if (jam < 10) {
		jam = "0" + jam;
	}

	if (menit < 10) {
		menit = "0" + menit;
	}

	var currentJam = jam + ":" + menit;

	// set default current date
	$("input.date-of-entry").val(currentTanggal + " " + currentJam);

	// onsubmit
	addItemForm.submit(function(e) {
		e.preventDefault();
		var itemName = $("input.item-name").val();
		var itemModel = $("input.item-model").val();
		var itemQuantity = $("input.item-quantity").val();
		var itemUnit = $("input.item-unit").val();
		var dateOfEntry = $("input.date-of-entry").val();
		var timePeriod = $("input.time-period").val();
		var typeofTimePeriod = $("select.select-time-period");
		var itemOwner = $("input.item-owner").val();

		// regular expression --> YYYY-MM-DD hh:mm
		var regularExpressionForDatetime = /^(\d{4})/;

		// itemExpired is optional value, user could blank this out
		// if value is null or empty, then system will change it with "-" string
		if (!timePeriod) {
			timePeriod = "";
			typeofTimePeriod = "";
		}

		if (itemName && itemModel && itemQuantity && itemUnit && dateOfEntry && itemOwner) {
			$.ajax({
				url: "/items",
				method: "POST",
				async: true,
				data: {
					item_name: itemName,
					item_model: itemModel,
					item_quantity: itemQuantity,
					item_unit: itemUnit,
					date_of_entry: dateOfEntry,
					time_period: timePeriod,
					typeof_time_period: typeofTimePeriod,
					item_owner: itemOwner,
					form_request: "ADD"
				},
				success: function() {
					alert("Successfuly inserting data!");
					window.location = "/";
				}
			});
			addItemForm[0].reset();
		}
	});
}

function daysInMonth(month, year) {
  	return new Date(year, month, 0).getDate();
}
</script>
[[ end ]]

[[ define "style" ]]
<style>
	/* Vertical navigation style */
	div#app-side-nav {
		padding-top: 25px;
		position: absolute;
		left: 10px;
		height: 100%;
		border-radius: 5px;
	}
	div#app-side-nav ul {
		list-style-type: none;
		margin: 0;
		padding: 0;
		width: 200px;
	}
	div#app-side-nav ul a {
		text-decoration: none;
		display: block;
		color: #2c3e50;
		padding: 11px;
		font-weight: 500;
	}
	div#app-side-nav ul a:hover {
		background-color: #D8D8D8;
	}
	/* end of vertical navigation style */

	/* form wrapper style */
	div#app-form-wrapper {
		position: absolute;
		left: 220px;
		padding: 15px;
	}
	div#app-add-content {
		display: none;
	}
	div#app-remove-content {
		display: none;
	}
	/* end of wrapepr style */

	/* Add Items Content Style */
	div#app-add-content input[type="text"] {
		outline: none;
		border: none;
		border-bottom: solid 1px #1abc9c;
		padding: 10px;
		width: 300px;
	}
	div#app-add-content input[type="submit"] {
		border: none;
		padding: 5px;
		width: 300px;
		background-color: #c0392b;
		color: #F2F2F2;
		border-radius: 15px;
	}
	div#app-add-content input[type="submit"]:hover {
		cursor: pointer;
		background-color: #27ae60;
	}
	div#app-add-content input[type="number"] {
		border: none;
		padding: 10px;
		padding-left: 10px;
		width: 300px;
		border-bottom: solid 1px #1abc9c;
		outline: none;
	}
	div#app-add-content input[type="number"].time-period {
		width: 150px;
		background-color: none;
	}
	select.select-time-period {
		border: none;
		outline: none;
		padding: 9px;
		border-bottom: solid 1px #1abc9c;
		width: 148px;
	}
	select.select-time-period:hover {
		cursor: pointer;
	}
	.row:after {
		content: "";
		display: table;
		clear: both;
	}
	.arrow-right {
		  width: 0; 
		  height: 0; 
		  border-top: 5px solid transparent;
		  border-bottom: 5px solid transparent;
		  border-left: 5px solid gray;
		  float: right;
	}
	/* label note */
	label.app-input-note {
		font-size: 80%;
		padding-left: 15px;
		color: red;
	}
	/* end of Add Items Content style */
</style>
[[ end ]]

[[ define "add_box" ]]
<!-- Add item content -->
<div id="app-add-content">
	<form class="app-form-add">
		<div class=".row">
			<input class="item-name" type="text" placeholder="Item Name" required="">
			<label class="app-input-note"> <i>*Example: Cat-6A UTP Cable</i></label>
		</div><br>
		<div class=".row">
			<input class="item-model" type="text" placeholder="Model/Brand" required=""> <label class="app-input-note"><i>*Example: AMP Connect</i></label>
		</div><br>
		<div class=".row">
			<input class="item-quantity" type="number" placeholder="Quantity" min="1" required="">
		</div><br>
		<div class=".row">
			<input class="item-unit" type="text" placeholder="Item Unit" required=""> <label class="app-input-note"><i>*Example: Roll, Packs, etc.</i></label>
		</div><br>
		<div class=".row">
			<div class=".row">
				<label style="font-size: 90%; padding: 10px; color: #2980b9;">Date of Entry</label>
			</div>
			<div class=".row">
				<input class="date-of-entry" type="text" placeholder="YYYY-MM-DD hh:mm" required=""> <label class="app-input-note"><i>*Example: 2017-08-10 16:00 (Use 24 Hours Format)</i></label>
			</div>
		</div><br>
		<div class=".row">
			<input class="time-period" type="number" placeholder="Time Period">
			<select class="select-time-period">
				<option value="day" selected>Day(s)</option>
				<option value="month">Month(s)</option>
				<option value="week">Week(s)</option>
			</select> <label class="app-input-note"><i style="color: blue;">Optional or you could blank this out</i></label>
		</div><br>
		<div class=".row">
			<input class="item-owner" type="text" placeholder="Owner" required="">
		</div><br>
		<div class=".row">
			<input type="submit" value="Submit Data">
		</div>
	</form>
</div>
<!-- -->
[[ end ]]

[[ define "remove_box" ]]
<!-- Remove item content -->
<div id="app-remove-content">
	<h1>Remove!</h1>
</div>
<!-- -->
[[ end ]]

[[ define "side_navigation" ]]
<br><br>
<div id="app-side-nav">
	<ul>
		<li>
			<a class="item-add" href="javascript:void(0)">
				Add <div class="arrow-right"></div>
			</a>
		</li>
		<li>
			<a class="item-remove" href="javascript:void(0)">
				Remove <div class="arrow-right"></div>
			</a>
		</li>
		<li>
			<a class="request-item" href="javascript:void(0)">
				Request <div class="arrow-right"></div>
			</a>
		</li>
	</ul>
</div>
[[ end ]]