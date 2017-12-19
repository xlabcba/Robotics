# Rapidly-exploring Random Tree (RRT)

## RRT Introduction
see [wikipedia](https://en.wikipedia.org/wiki/Rapidly-exploring_random_tree)

> A rapidly exploring random tree (RRT) is an algorithm designed to efficiently search nonconvex, high-dimensional spaces by randomly building a space-filling tree. The tree is constructed incrementally from samples drawn randomly from the search space and is inherently biased to grow towards large unsearched areas of the problem.

## Folder Structure

* **homework2.pdf** - Description of 3 programming questions related to RRT algorithm.
* **hw2.m** - Function to run solution to each question by giving corresponding question number.
* **robotCollision.m** - Function to evaluate whether the configuration <q> is in collision with a spherical obstacle centered at <sphereCenter> with radius <r>.
* **Q1.m** - This function takes two joint configurations and the parameters of the obstacle as input and calculates whether a collision free path exists between them, with robotCollision.m used.
* **Q2.m** - This function calculates a path from qStart (start configuration) to xGoal (goal position) by implementing RRT algorithm, with robotCollision.m and Q1.m used.
* **Q3.m** - This function smooths path given in qMilestones, which is a path consisting of configurations from qStart to xGoal.

## Run Instruction:
1. Put hw2.m & Q1.m & Q2.m & Q3.m into MATLAB
2. In MATLAB terminal, run
```
	$ startup_rvc
```
3. In MATLAB terminal, run following to show corresponding programming solutions
```
	$ hw2($QuestionNumber)
```	
