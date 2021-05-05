package util;

class SaveFile {
	public function new(path:String, map:Map<String, String>) {
		var content = '"title","description"\n';
		for (title in map.keys()) {
			var desc = map[title];
			// trace('"${title}"');
			// trace('$title is $desc');
			content += '"${title}","${desc}"\n';
		}
		sys.io.File.saveContent(path, content);

		trace('File (${path}) is saved!');
	}

	public static function markdown(path:String, md:String) {
		sys.io.File.saveContent(path, md);
		trace('File (${path}) is saved!');
	}
}
