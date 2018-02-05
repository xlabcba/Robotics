# Linear Optimal Control

## Linear Optimal Control Introduction
see [wikipedia](https://en.wikipedia.org/wiki/Optimal_control#Linear_quadratic_control)

> **Optimal Control** deals with the problem of finding a control law for a given system such that a certain optimality criterion is achieved. A control problem includes a cost functional that is a function of state and control variables. An optimal control is a set of differential equations describing the paths of the control variables that minimize the cost function. 

> **Linear Quadratic Control** is a special case of the general nonlinear optimal control problem, which can be stated as following:
Minimize the *quadratic* continuous-time cost function:

<img src="https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/figures/quadraticCost.png"/>

> Subject to the *linear* first-order dynamic constraints

<img src="https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/figures/linearConstraint.png"/>

> and the initial condition

<img src="https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/figures/initialCondition.png"/>

> **Linear Quadratic Regulator (LQR)** is a particular form of the LQ problem that arises in many control system problems where all of the matrices (i.e. **A**, **B**, **Q**, and **R**) are constant, the initial time is arbitrarily set to zero, and the terminal time is taken in the limit t<sub>f</sub> → ∞ (this last assumption is what is known as infinite horizon). This can be stated as following:
Minimize the infinite horizon quadratic continuous-time cost function:

<img src="https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/figures/quadraticContinuousCost.png"/>

> Subject to the *linear time-invariant* first-order dynamic constraints

<img src="https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/figures/linearTimeVariantConstraint.png"/>

> and the initial condition

<img src="https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/figures/initialCondition.png"/>

> In the finite-horizon case the matrices are restricted in that **Q** and **R** are positive semi-definite and positive definite, respectively. In the infinite-horizon case, however, the matrices **Q** and **R** are not only positive-semidefinite and positive-definite, respectively, but are also constant. These additional restrictions on **Q** and **R** in the infinite-horizon case are enforced to ensure that the cost function remains positive. Furthermore, in order to ensure that the cost function is bounded, the additional restriction is imposed that the pair **(A, B)** is controllable. Note that the LQ or LQR cost functional can be thought of physically as attempting to minimize the control energy (measured as a quadratic form).

## Folder Structure

* **[homework3.pdf](https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/homework3.pdf)** - Description of 3 programming questions related to Linear Optimal Control.
* **[hw3.m](https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/hw3.m)** - Function to run solution to each question by giving corresponding question number.
* **[Q1.m](https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/Q1.m)** - This function implements a finite horizon discrete time LQR for the damped mass system.
* **[Q2.m](https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/Q2.m)** - This function is same as Q1 except it implements a receeding horizon controller.
* **[Q3.m](https://github.com/xlabcba/Robotics/blob/master/LinearOptimalControl/Q3.m)** - This function calculates the optimal trajectory with new control policy and cost function to minimize the change in control input rather than the magnitude of the control input itself.

## Run Instruction:
1. Put hw3.m & Q1.m & Q2.m & Q3.m into MATLAB
2. In MATLAB terminal, run
```
	$ startup_rvc
```
3. In MATLAB terminal, run following to show corresponding programming solutions
```
	$ hw3($QuestionNumber)
```	
