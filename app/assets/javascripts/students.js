function addAjaxToListSelect() {
	var field = $("#listSelect");
	field.change(function() {
		$.ajax(field.attr("data-url"), {data: {list: field.val()}, dataType: "script"});
	});
}

$(document).ready(addAjaxToListSelect);