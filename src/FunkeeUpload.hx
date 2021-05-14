package;

import js.Browser.*;
import js.html.*;

/**
 * @source
 * - https://developer.mozilla.org/en-US/docs/Web/API/File/Using_files_from_web_applications
 * - https://stackoverflow.com/questions/13938686/can-i-load-a-local-file-into-an-html-canvas-element
 *
 *
 */
class FunkeeUpload {
	var fileInput:InputElement;
	var previewText:SpanElement;

	var btnDownload:ButtonElement;
	var btnBase64:ButtonElement;
	var btnBase642:ButtonElement;

	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('FunkeeUpload - Dom ready');
			init();
		});
	}

	function init() {
		fileInput = cast document.getElementById("formFile");
		previewText = cast document.getElementById('filePreviewText');

		fileInput.onchange = function(e) {
			var fileList:FileList = e.files;
			if (fileInput.files.length > 0) {
				var file:File = fileInput.files[0];
				console.log("You chose: ", file.name);
				console.log("Weight: ", file.size);
				console.log("Type: ", file.type);
				trace(file);

				previewText.innerText = '"${file.name}", type:"${file.type}" is ' + bytesToSize(file.size);

				var fileReader = new FileReader();
				fileReader.onload = function() {
					// convert image file to base64 string
					trace(fileReader.result); // previewImg.src = fileReader.result;
					convertData(fileReader.result);
				};
				fileReader.readAsText(file);
			}
		};
	}

	function convertData(content:String) {
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

		var csvTable = document.getElementById('csv-table');
		csvTable.innerHTML = html;
	}

	public function bytesToSize(bytes:Int) {
		var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
		if (bytes == 0)
			return '0 Byte';
		var i = Std.int(Math.floor(Math.log(bytes) / Math.log(1024)));
		return Math.round(bytes / Math.pow(1024, i)) + ' ' + sizes[i];
	}

	static public function main() {
		var app = new FunkeeUpload();
	}
}
