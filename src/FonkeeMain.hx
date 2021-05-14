import thx.csv.*;
import js.Browser.*;

using StringTools;

class FonkeeMain {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('Fonkee Issues 🐡');
			init();
		});
	}

	function init() {
		debugFavicon();
	}

	function debugFavicon() {
		if (window.location.href.indexOf('docs') != -1) {
			var title = document.title;
			document.title = "🐞 " + title;
		}
	}

	static function main() {
		var app = new FonkeeMain();
	}
}
