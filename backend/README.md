# Javelo Backend Challenge

## Guidelines

**For each level, write code that creates a new `data/output.json` file from the data in `data/input.json`. An `expected_output.json` file is available to give you a reference on what result is expected.**

- Clone this repo (do **not** fork it)
- Solve the levels in ascending order
- Only do one commit per level

### Pointers

You can have a look at the higher levels, but please do the simplest thing that could work for the level you're currently solving.

The levels become more complex over time, so you will probably have to re-use some code and adapt it to the new requirements.
A good way to solve this is by using OOP, adding new layers of abstraction when they become necessary and possibly write tests so you don't break what you have already done.

Don't hesitate to write [shameless code](http://red-badger.com/blog/2014/08/20/i-spent-3-days-with-sandi-metz-heres-what-i-learned/) at first, and then refactor it in the next levels.

For higher levels we are interested in seeing code that is:
- clean
- extensible
- robust (don't overlook edge cases, use exceptions where needed, ...)

Please also note that:
- running `$ ruby main.rb` from the level folder should generate the desired output, but of course feel free to add more files if needed.

### Sending Your Results

- You should already be in contact with us, don't hesitate to ask if something seems wrong
- When you are done, send the link of your repository to the person you are talking to

## Challenge

### Intro

In this test, you are going to work on objectives, the main feature of javelo!

An objective represents a task that a user should accomply within a certain amount of time.

This feature aims to help these users planify well those tasks, and track their progression in order to accomplish them smoothly and on time.

Example of a real life objective:
```
{
  id: 17548,
  title: "Make 50 blank tests to be trained for the javelo challenge",
  start: 0,
  start_date: '2017-12-01',
  end_date: '2018-09-31',
  target: 50,
  unit: 'number'
}
```

### Level 1: Progress

In this level, we'll focus on some records of objective's progress. For each one you should compute the corresponding `progress` value.

Progress is the objective's percentage achieved the value of the `progress_record` represents.

### Level 2: Progress Over Time

In order to help people achieve their objectives, start and end dates are furnished.

Objectives are expected to be completed linearly during these dates.

Each record is now dated. Meaning its value can be compared to the expected completion of the corresponding objective at that date.

The `excess` is the difference between thos two values, in percentage of the expected completion.

### Level 3: Milestones

Sometimes users need more control over the theoric achievement of an objective, and the 2 starting and ending points are not enough.
A milestone is a (time, value) point defining where the real achievement curve should pass. By using milestones, users can define better how they should complete their objectives over time between the starting and ending points.

The theoric achievement between milestones (and between a milestone and one of the start or end point) is linear.

The excess is computed using the theoric achievement at the date of a record, the value of this record and the starting point.

### Level 4: Objective Tree & Weighted Mean Progress

Objectives can be children of other objectives. We say they have a parent objective.

The theoric achievement of a parent objective is deduced from its children: at a certain date it is the mean of the theoric accomplishement of its children objectives, taking into account some coefficients.

The start and end values of these parent objectives are also computed thanks to their children and corresponding coefficients.
