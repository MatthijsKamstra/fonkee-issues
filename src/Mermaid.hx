package;

import util.SaveFile;
import thx.csv.*;

using StringTools;
using util.IntTools;

class Mermaid {
	// default, should be removed later
	var _source = 'data/mermaid_boerderijdagen2021.csv';

	var monthMap = [
		'januari' => 1, 'februari' => 2, 'maart' => 3, 'april' => 4, 'apr' => 4, 'mei' => 5, 'juni' => 6, 'juli' => 7, 'augustus' => 8, 'september' => 9,
		'oktober' => 10, 'november' => 11, 'december' => 12,
	];

	public function new(isLocal:Bool = false) {
		trace('Mermaid');
		if (isLocal) {
			getData();
		}
	}

	/**
	 * [Description]
	 * @param source
	 */
	public function convert(source:String) {
		var content:String = sys.io.File.getContent(source);
		// trace(content);

		var decoded = thx.csv.Csv.decode(content);
		// var encoded = thx.csv.Csv.encode(decoded);

		// trace(decoded);
		// trace(encoded);

		convertData(source, decoded);
	}

	function getData() {
		var content:String = sys.io.File.getContent(_source);
		// trace(content);

		var decoded = thx.csv.Csv.decode(content);
		var encoded = thx.csv.Csv.encode(decoded);

		// trace(decoded);
		// trace(encoded);

		convertData(_source, decoded);
	}

	/**
	 * [Description]
	 * @param arr
	 */
	public function convertData(source:String, arr:Array<Array<String>>) {
		trace('Total issues (with empty issues): ' + arr.length);

		// var list = arr[0];
		// for (i in 0...list.length) {
		// 	Sys.println('var ${list[i].toLowerCase()} = _arr[$i];');
		// }

		var dataArr = [];

		var list = arr[1];
		trace(list);
		for (i in 0...list.length) {
			// Sys.println(list[i]);
			// trace(convert2MermaidDate(list[i]));
			var d = convert2MermaidDate(list[i]);
			if (d != "")
				dataArr[i] = d;
		}
		trace(dataArr);

		var csvArr:Array<Array<String>> = [];
		var out = '';

		for (i in 1...arr.length) {
			var _arr = arr[i];

			var section = _arr[0];
			if (section != '')
				out += '\n\tsection ${Mermaid.cleanSection(section).replace('/', '_').replace(':', '_')}\n';

			// need the time for a project
			var temp = '';
			var startDate = "YYYY-MM-DD";
			var daysNr = 0;
			for (j in 2..._arr.length) {
				var _colomn = _arr[j];
				if (_colomn != '') {
					temp += 'x';
					daysNr += 5;
					if (startDate == "YYYY-MM-DD") {
						startDate = dataArr[j];
					}
				} else {
					temp += '_';
				}
			}
			trace(temp);
			trace(startDate);
			trace('${daysNr}d');

			var task = _arr[1];
			if (task != '')
				out += '\t${Mermaid.cleanTask(task)}\t\t:${startDate}, ${daysNr}d\n';

			// var week9 = _arr[2];
			// var week10 = _arr[3];
			// var week11 = _arr[4];
			// var week12 = _arr[5];
			// var week13 = _arr[6];
			// var week14 = _arr[7];
			// var week15 = _arr[8];
			// var week16 = _arr[9];
			// var week17 = _arr[10];
			// var week18 = _arr[11];
			// var week19 = _arr[12];
			// var week20 = _arr[13];
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

		SaveFile.markdown(source + '.converted.md', markdown);
	}

	// ____________________________________ utils ____________________________________

	public static function cleanSection(str:String) {
		return cap(str);
	}

	public static function cleanTask(str:String) {
		return cap(str);
	}

	public static function cap(string:String):String {
		return string.charAt(0).toUpperCase() + string.substring(1, string.length);
	}

	/**
	 * convert what ever used to YYYY-MM-DD
	 *
	 * assumption:
	 *
	 * in: "12 april"
	 * out: "2021-04-12"
	 *
	 * @param value
	 */
	function convert2MermaidDate(value:String):String {
		var nr = Std.parseInt(value);
		var month:String = value.replace('$nr', '')
			.replace(' ', '')
			.replace('\t', '')
			.replace('\r\n', '')
			.replace('\n', '')
			.replace('\r', '')
			.toLowerCase(); // remove number, remove spaces, returns

		var year:String = '2021';
		// trace(nr, month);
		if (!monthMap.exists(month)) {
			// trace('${month}:' + monthMap.exists(month));
			// trace('-----> what is happening? : "${month}"');
			trace('-----> what is happening (${value})? : "${month.urlEncode()}"');
			return "";
		}
		// trace(monthMap.get(month));
		// trace('nr.lpadNr: ' + nr.lpadNr());
		// trace('month.lpadNr: ' + monthMap.get(month).lpadNr());
		return '${year}-${monthMap.get(month).lpadNr()}-${nr.lpadNr()}'; // YYYY-MM-DD
	}

	static public function main() {
		var app = new Mermaid(true);
	}
}
