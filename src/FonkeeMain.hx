import js.html.Element;
import js.html.EmbedElement;
import util.Emoji;
import util.Debug;
import thx.csv.*;
import js.Browser.*;

using StringTools;

class FonkeeMain {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('Fonkee Issues ${Emoji.blowFish}');
			init();
		});
	}

	function init() {
		Debug.debugFavicon();
		showEstimate();
		showEstimateConverted();
	}

	function showEstimate() {
		var el = document.getElementById('code-estimate');
		if (el == null)
			return;

		trace("showEstimate el: " + el);

		window.fetch("data/estimate_2021.csv")
			.then(function(response) {
				return response.text();
			})
			.then(function(data) {
				console.log(data);
				convertData(el, data);
			});
	}

	function showEstimateConverted() {
		var el = document.getElementById('code-estimate-converted');
		if (el == null)
			return;

		trace("showEstimateConverted el: " + el);

		window.fetch("data/estimate_2021.csv.converted.csv")
			.then(function(response) {
				return response.text();
			})
			.then(function(data) {
				console.log(data);
				convertData(el, data);
			});
	}

	function convertData(el:Element, content:String) {
		var arr = thx.csv.Csv.decode(content);
		trace(arr);
		var html = '<table class="table table-striped table-hover">';
		html += '<thead>';

		var row = arr[0];
		html += '<tr>';
		html += '<th scope="col">#</th>';
		for (j in 0...row.length) {
			var col = row[j];
			html += '<th scope="col">${col}</th>';
		}
		html += '</tr>';
		html += '</thead>';

		html += '<tbody>';
		for (i in 1...arr.length) {
			var row = arr[i];
			html += '<tr>';
			html += '<th scope="row">${i}</th>';
			for (j in 0...row.length) {
				var col = row[j];
				html += '<td>${col}</td>';
			}
			html += '</tr>';
		}
		html += '</tbody>';
		html += '</table>';

		el.innerHTML = html;
	}

	static function main() {
		var app = new FonkeeMain();
	}
}
