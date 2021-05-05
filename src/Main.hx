import thx.csv.*;

using StringTools;

class Main {
	public function new() {
		trace('Convert csv to github friendly csv');

		// setupDefault();
		setupBoerderijdagen();
	}

	function setupDefault() {
		var content:String = sys.io.File.getContent('data/default_website_setup.csv');
		// trace(content);

		var decoded = thx.csv.Csv.decode(content);
		var encoded = thx.csv.Csv.encode(decoded);

		// trace(decoded);
		// trace(encoded);

		convertData(decoded);
	}

	function setupBoerderijdagen() {
		var content:String = sys.io.File.getContent('data/boerderijdagen_estimate.csv');
		// trace(content);

		var decoded = thx.csv.Csv.decode(content);
		var encoded = thx.csv.Csv.encode(decoded);

		// trace(decoded);
		// trace(encoded);

		convertDataBoer(decoded);
	}

	function convertDataBoer(arr:Array<Array<String>>) {
		trace('Total issues (with empty issues): ' + arr.length);

		var list = arr[0];
		for (i in 0...list.length) {
			Sys.println('var ${list[i].toLowerCase()} = _arr[$i];');
		}

		var map:Map<String, String> = [];
		var chapterMap:Map<String, String> = [];
		var chapterArr:Array<String> = [];

		var previousSection = '';
		var previousTitle = '';
		var previousPage = '';
		var previousOnderdelen = '';
		for (i in 1...arr.length) {
			var _arr = arr[i];

			var section = _arr[0];
			if (section == '') {
				section = previousSection;
				chapterMap.set(section, section);
				if (chapterArr.indexOf(section) == -1) {
					chapterArr.push(section);
				}
			}

			var title = _arr[1];
			if (title == '') {
				title = previousTitle;
			}
			var pagina = _arr[2];
			if (pagina == '') {
				pagina = previousPage;
			}
			var onderdelen = _arr[3];
			if (onderdelen == '') {
				onderdelen = previousOnderdelen;
			}

			var description = _arr[4];

			var estimate = _arr[5];
			// check if value has h, d, w?
			// trace('${i}. (${estimate})' + estimate.length);
			// trace(Std.parseInt(estimate));
			if (estimate.indexOf('h') != -1 || estimate.indexOf('d') != -1 || estimate.indexOf('w') != -1) {
				// trace('${i}. (${estimate}) fine');
				// do nothing
			} else if (estimate == '') {
				// change to zero hours... weird but anyway
				estimate = '0h'; // default
			} else {
				// trace('${estimate}h');
				estimate = '${estimate}h'; // in hours
			}

			var temp = '${section.replace('"', "'")} - ${title.replace('"', "'")}';
			if (pagina != '')
				temp += ' - ${pagina.replace('"', "'")}';
			if (onderdelen != '')
				temp += ' - ${onderdelen.replace('"', "'")}';

			// estimate needed?

			if (Std.parseInt(estimate) != 0) {
				map.set('${temp}', '${description.replace('"', "'")}\n/estimate ${estimate}');
			}

			// set previous
			previousSection = section;
			previousTitle = title;
			previousPage = pagina;
			previousOnderdelen = onderdelen;
		}
		trace('Total issues (without empty issues): ' + Lambda.count(map));

		// var count = 1;
		// for (key in chapterMap.keys()) {
		// 	var chapter = chapterMap[key];
		// 	trace('${count} - $chapter');
		// 	count++;
		// }

		trace('chapterArr.length: ' + chapterArr.length);
		trace('Lambda.count(chapterMap): ' + Lambda.count(chapterMap));

		saveFile('data/boerderijdagen_estimate_converted.csv', map);
	}

	function convertData(arr:Array<Array<String>>) {
		trace('Total issues (with empty issues): ' + arr.length);

		var list = arr[0];
		for (i in 0...list.length) {
			trace('var ${list[i].toLowerCase()} = _arr[$i];');
		}

		var map:Map<String, String> = [];
		var chapterMap:Map<String, String> = [];
		var chapterArr:Array<String> = [];

		var previousSection = '';
		for (i in 0...arr.length) {
			var _arr = arr[i];
			// trace(_arr);

			var section = _arr[0];
			if (section == '') {
				section = previousSection;
				chapterMap.set(section, section);
				if (chapterArr.indexOf(section) == -1) {
					chapterArr.push(section);
				}
			}
			var title = _arr[1];
			var description = _arr[2];
			var estimate = _arr[3];
			// check if value has h, d, w?
			// trace('${i}. (${estimate})' + estimate.length);
			// trace(Std.parseInt(estimate));
			if (estimate.indexOf('h') != -1 || estimate.indexOf('d') != -1 || estimate.indexOf('w') != -1) {
				// trace('${i}. (${estimate}) fine');
				// do nothing
			} else if (estimate == '') {
				// change to zero hours... weird but anyway
				estimate = '0h'; // default
			} else {
				// trace('${estimate}h');
				estimate = '${estimate}h'; // in hours
			}

			// title can't be empty
			if (title == '') {
				// trace('empty ${i}');
			} else {
				map.set('${section.replace('"', "'")} - ${title.replace('"', "'")}', '${description.replace('"', "'")}\n/estimate ${estimate}');
			}

			// set previous section
			previousSection = section;
		}
		trace('Total issues (without empty issues): ' + Lambda.count(map));

		var count = 1;
		for (key in chapterMap.keys()) {
			var chapter = chapterMap[key];
			trace('${count} - $chapter');
			count++;
		}

		trace('chapterArr.length: ' + chapterArr.length);
		trace('Lambda.count(chapterMap): ' + Lambda.count(chapterMap));

		saveFile('data/default_website_setup_converted.csv', map);
	}

	/**
	 * [Description]
	 * @param path
	 * @param map
	 */
	function saveFile(path:String, map:Map<String, String>) {
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

	/**
	 * [Description]
	 * @param path
	 * @param map
	 */
	function saveFileArr(path:String, arr:Array<{}>) {
		var content = '"title","description"\n';

		for (i in 0...arr.length) {
			var obj = arr[i];
			var title = Reflect.getProperty(obj, 'title');
			var desc = Reflect.getProperty(obj, 'description');

			content += '"${title}","${desc}"\n';
		}
		sys.io.File.saveContent(path, content);

		trace('> File (${path}) is saved!');
	}

	static function main() {
		var app = new Main();
	}
}
