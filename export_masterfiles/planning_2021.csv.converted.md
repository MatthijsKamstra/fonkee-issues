
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
	Briefing		:2021-03-08, 5d
	Research		:2021-06-14, 5d
	Estimate		:2021-12-20, 5d
	Meeting		:2021-01-18, 5d

	section Design
	Scope		:2021-11-22, 5d
	Research		:2021-06-21, 5d
	Handover		:2021-02-01, 5d

	section Development
	Team meet		:2021-01-25, 5d
	Setup Git		:2021-10-18, 5d
	Server setup		:2021-10-18, 5d

```
