$(document).ready(function() {
	var field = $("#searchField");
	field.typeahead({
		highlight: true,
		minLength: 3
	},{
		name: "students",
		source: function(query, cb) {
			$.ajax(field.attr("data-students"), {data: {q: query}, dataType: "json", method: "get", success: cb});
		},
		templates: {
			header: "<h3>Sch&uuml;ler</h3>",
			suggestion: function(data) {
				return "<p>" + data.name + " - <small>" + data.class + "</small></p>";
			}
		}
	}, {
		name: "teachers",
		source: function(query, cb) {
			$.ajax(field.attr("data-teachers"), {data: {q: query}, dataType: "json", method: "get", success: cb});
		},
		displayKey: "name",
		templates: {
			header: "<h3>Lehrer</h3>",
		}
	}, {
		name: "books",
		source: function(query, cb) {
			$.ajax(field.attr("data-books"), {data: {q: query}, dataType: "json", method: "get", success: cb});
		},
		templates: {
			header: "<h3>B&uuml;cher</h3>",
			suggestion: function(data) {
				return "<p>" + data.title + "</p>";
			}
		}
	});
	field.on("typeahead:selected", function(event, suggestion, dataset) {
		$(location).attr("href", suggestion.url);
	});
});