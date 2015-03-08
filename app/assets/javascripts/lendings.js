$(document).ready(function() {
	lookupBook = function(e) {
		$.ajax(e.data.field.data("lookup"), {dataType: "script", data: {a: e.data.index, b: e.data.field.val()}});
		return false;
	}

	for(i = 0; i < 16; ++i) {
		f = $("input#isbn_" + i + ".form-control");
		f.blur({field: f, index: i}, lookupBook);
	}
});