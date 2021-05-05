package;

import js.Browser.*;
import js.Browser;
import js.html.*;

class MainJs {
	public function new() {
		trace('MainJs');

		// modified from http://html5demos.com/file-api
		var holder = document.getElementById('holder'),
			state = document.getElementById('status');

		if (untyped window.FileReader == 'undefined') {
			state.className = 'fail';
		} else {
			state.className = 'success';
			state.innerHTML = 'File API & FileReader available';
		}

		holder.ondragover = function() {
			js.Lib.nativeThis.className = 'hover';
			return false;
		};
		holder.ondragend = function() {
			js.Lib.nativeThis.className = '';
			return false;
		};
		holder.ondrop = function(e) {
			js.Lib.nativeThis.className = '';
			e.preventDefault();

			var file = e.dataTransfer.files[0], reader = new FileReader();
			reader.onload = function(event) {
				console.log(event.target);
				holder.innerText = event.target.result;
			};
			console.log(file);
			reader.readAsText(file);

			return false;
		};
	}

	static public function main() {
		var app = new MainJs();
	}
}
