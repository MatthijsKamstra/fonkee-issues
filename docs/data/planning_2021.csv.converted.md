
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
	Briefing		:2021-04-05, 5d
	Research		:2021-08-30, 5d
	Estimate		:2021-10-25, 5d
	Meeting		:2021-07-12, 5d

	section Design
	Scope		:2021-07-05, 5d
	Research		:2021-01-18, 5d
	Handover		:2021-07-05, 5d

	section Development
	Team meet		:2021-09-13, 5d
	Setup Git		:2021-06-14, 5d
	Server setup		:2021-12-20, 5d

```
