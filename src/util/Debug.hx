package util;

import js.Browser.*;

class Debug {
	public function new() {
		// your code
	}

	public static function debugFavicon() {
		if (window.location.href.indexOf('docs') != -1) {
			var title = document.title;
			document.title = "🐞 " + title;
		}
	}
}
