# CSV_2_GITLAB_ISSUES

goal to convert data from sheets/excell to information that work with gitlab.

- issues with estimates
- planning

how to convert sheets/excel to files that work gitlab.

## issues

| Section       | Title      | Description | Estimate |
| ------------- | ---------- | ----------- | -------- |
| UX design     | flowcharts | do          | 4h       |
|               | wireframes | do 2        | 4        |
| visual design | invision   | x           | 8h       |

- `Section` is added from the first time it appears, needs to start with section
- `Title` needed (no title, no entry in export)
- `Description` can have markdown features and enters for next lines.
- `Estimates` in 4, 4h, 4d 4w

## Mermaid

gantt for planning

https://mermaid-js.github.io/mermaid/#/gantt

sheet specs

| Section | Task       | week 10 | week 11 |
| ------- | ---------- | ------- | ------- |
|         |            | 1 maart | 8 maart |
| Server  | acceptance | x       |         |
| Server  | production |         | x       |

## Gant example

````mermaid
gantt
    title A Gantt Diagram
    %% this is a comment
    dateFormat  YYYY-MM-DD
    excludes    weekends

    section Section
    A task           :a1, 2014-01-01, 30d
    Another task     :after a1  , 20d
    section Another
    Task in sec      :2014-01-12  , 12d
    another task      : 24d
    ```
````
