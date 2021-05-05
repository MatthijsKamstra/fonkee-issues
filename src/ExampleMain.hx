package;

import util.SaveFile;
import thx.csv.*;

using StringTools;

class ExampleMain {
	public function new() {
		trace('Convert csv to github friendly csv');

		convertDefaultEstimate('docs/data/estimate_2021.csv');
		convertDefaultPlanning('docs/data/planning_2021.csv');
	}

	function convertDefaultPlanning(source:String) {
		var mermaid = new Mermaid();
		mermaid.convert(source);
	}

	function convertDefaultEstimate(source:String) {
		trace('convertDefaultEstimate AND basicPlanning');
		var content:String = sys.io.File.getContent(source);
		var arr = thx.csv.Csv.decode(content);

		var list = arr[0];
		for (i in 0...list.length) {
			Sys.println('var ${list[i].toLowerCase()} = _arr[$i];');
		}

		var mapArr:Array<CSVObj> = [];

		var out = '';

		var previousSection = '';
		var previousTitle = '';
		var previousPage = '';
		var previousOnderdelen = '';

		for (i in 1...arr.length) {
			var _arr = arr[i];

			var section = _arr[0];
			if (section == '') {
				section = previousSection;
			} else {
				out += '\n\tsection ${Mermaid.cleanSection(section)}\n';
			}

			var title = _arr[1];
			if (title == '') {
				title = previousTitle;
			}

			var page = _arr[2];
			if (page == '') {
				page = previousPage;
			}

			var onderdelen = _arr[3];
			if (onderdelen == '') {
				onderdelen = previousOnderdelen;
			}

			var description = _arr[4];
			var estimate:String = _arr[5];

			if (estimate == null) {
				estimate = '0h';
			}

			// check if value has h, d, w?
			// trace('${i}. (${estimate})' + estimate.length);
			// trace('${i}. ${estimate.indexOf('h')}');
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

			trace('${i}. "$estimate"');

			var _title = '${section.replace('"', "'")} - ${title.replace('"', "'")}';
			if (page != '')
				_title += ' - ${page.replace('"', "'")}';
			if (onderdelen != '')
				_title += ' - ${onderdelen.replace('"', "'")}';

			// trace('${i}. "$estimate"');
			// estimates will be fine with 0h
			// if (Std.parseInt(estimate) != 0) {
			mapArr.push({
				title: '${_title}',
				description: '${description.replace('"', "'")}\n/estimate ${estimate}'
			});
			// }

			var currentDate = Date.now();
			var t = DateTools.format(Date.now(), "%F");
			// 2016-07-08

			out += '\t${Mermaid.cleanTask(_title)}\t\t:${t}, 5d\n';

			// set previous
			previousSection = section;
			previousTitle = title;
			previousPage = page;
			previousOnderdelen = onderdelen;
		}

		var markdown = '
```mermaid
gantt
	title A Gantt Diagram
	dateFormat  YYYY-MM-DD
	excludes    weekends

	%% section Section
	%% A task           :a1, 2014-01-01, 30d
	%% Another task     :after a1  , 20d
	%% section Another
	%% Task in sec      :2014-01-12  , 12d
	%% another task      : 24d

${out}
```
';

		saveFileArr(source + '.converted.csv', mapArr);

		SaveFile.markdown(source + '.planning.converted.md', markdown);
	}

	// function convertDefaultPlanning() {
	// 	var content:String = sys.io.File.getContent('docs/data/planning_2021.csv');
	// 	var decoded = thx.csv.Csv.decode(content);
	// }

	/**
	 * [Description]
	 * @param path
	 * @param map
	 */
	function saveFileArr(path:String, arr:Array<CSVObj>) {
		var content = '"title","description"\n';

		for (i in 0...arr.length) {
			var obj = arr[i];
			var title = obj.title;
			var desc = obj.description;

			content += '"${title}","${desc}"\n';
		}
		sys.io.File.saveContent(path, content);

		trace('> File (${path}) is saved!');
	}

	static function main() {
		var app = new ExampleMain();
	}
}

typedef CSVObj = {
	@:optional var _id:String;
	var title:String;
	var description:String;
}
