
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


	section Start project
	Briefing		:2021-02-15, 5d
	Research		:2021-07-19, 5d
	Estimate		:2021-06-21, 5d
	Meeting		:2021-05-24, 5d

	section Design
	Scope		:2021-07-05, 5d
	Research		:2021-08-30, 5d
	Handover		:2021-05-31, 5d

	section Development
	Team meet		:2021-12-13, 5d
	Setup Git		:2021-09-06, 5d
	Server setup		:2021-03-01, 5d

```
