$(document).ready(function() {
	var sfield = $("#searchField");
	sfield.autocomplete({
		minLength: 3,
		source: sfield.attr("data-url"),
		select: function(event, ui) {
			window.location.href = ui.item.value;
			return true;
		},
		position: {
			my: "right top",
			at: "right bottom+8"
		}
	});
});