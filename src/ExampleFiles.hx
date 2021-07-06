package;

import util.SaveFile;

using DateTools;

class ExampleFiles {
	var monthArr = [
		'januari', 'februari', 'maart', 'april', 'mei', 'juni', 'juli', 'augustus', 'september', 'oktober', 'november', 'december'
	];
	var dayArr = [
		'zondag',
		'maandag',
		'dinsdag',
		'woensdag',
		'donderdag',
		'vrijdag',
		'zaterdag',
		'zondag'
	];

	var discArr = ["Section", "Title", "Page", "Components", "Description ", "Estimate"];

	var sectionArr = ['Start project', '', '', '', 'Design', '', '', 'Development', '', ''];
	var titleArr = [
		'Briefing', 'Research', 'Estimate', 'Meeting', 'Scope', 'Research', 'Handover', 'Team meet', 'Setup Git', 'Server setup'
	];
	var pageArr = ['', '', '', '', '', '', '', '', '', ''];
	var componentsArr = ['', '', '', '', '', '', '', '', '', ''];
	var descriptionArr = [
		'🔥',
		'',
		'yes import that also 👍',
		'',
		'Something clever',
		'',
		'- [ ] one
- [ ] two
- [ ] three',
		'',
		'Let\'s discuss this a bit,

oh and this

maybe more

And some more

🆙',
		''
	];

	var estimateArr = ['2d', '2h', '0', '5d', '7', '', '12h', '2d', '1h', '2'];
	var labelArr = [
		'Design', 'UX', 'Frontend', 'Todo', 'Frontend Backend', '', 'Unclear Frontend Backend', 'Research', 'Bug', 'Unclear'
	];

	public function new() {
		trace('ExampleFiles');
		init();
	}

	function init() {
		exportPlanning('docs/data/planning_2021.csv');
		exportEstimate('docs/data/estimate_2021.csv');
	}

	function exportPlanning(source:String) {
		var content = '';

		var jan1 = new Date(2021, 0, 1, 0, 0, 0);
		trace(jan1.getDay());
		trace(dayArr[jan1.getDay()]);
		var jan4 = new Date(2021, 0, 4, 0, 0, 0);
		trace(jan4.getDay());
		trace(dayArr[jan4.getDay()]);

		trace(jan4.delta(7.days()));

		var string1 = '';
		var string2 = '';
		var string3 = '';

		var weekCounter = 1;

		var startDate = new Date(2021, 0, 4, 0, 0, 0);
		var nextDate = new Date(2021, 0, 4, 0, 0, 0);

		for (i in 0...53) {
			var fiveDays = nextDate.delta(5.days());
			string1 += '"Week ${weekCounter}",';
			// string1 += '"Week ${weekCounter}\n${nextDate.getDate()}-${(nextDate.getMonth() + 1)} / ${fiveDays.getDate()}-${(fiveDays.getMonth() + 1)}",';
			string2 += '"${nextDate.getDate()} ${monthArr[nextDate.getMonth()]}",';
			string3 += ',';

			// var random = Math.floor(Math.random() * 100);
			// if (random >= 90) {
			// 	string3 += 'x';
			// }

			weekCounter++;
			nextDate = nextDate.delta(7.days());
		}

		content += '"Phase","Title",' + string1 + '\n';
		content += ',,' + string2 + '\n';
		for (i in 0...10) {
			var strLength = string3.length;
			var random = Math.floor(Math.random() * strLength);
			var arr = string3.split(',');
			arr[random] = 'x';
			var _string3 = arr.join(',');

			content += '"${sectionArr[i]}","${titleArr[i]}",' + _string3 + '\n';
		}

		sys.io.File.saveContent(source, content);
	}

	function exportEstimate(source:String) {
		var content = '"Section","Title","Page","Components","Description","Estimate","Label"\n';

		var temp = '';
		for (i in 0...titleArr.length) {
			temp += "'',";
		}
		trace('var emptyArr = [' + temp + '];');

		// content += ',,,,,,\n';

		for (i in 0...10) {
			content += '"${sectionArr[i]}","${titleArr[i]}","${pageArr[i]}","${componentsArr[i]}","${descriptionArr[i]}","${estimateArr[i]}","${labelArr[i]}"\n';
		}

		sys.io.File.saveContent(source, content);
	}

	static public function main() {
		var app = new ExampleFiles();
	}
}
