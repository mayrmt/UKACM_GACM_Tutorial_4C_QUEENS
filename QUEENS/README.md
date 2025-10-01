# QUEENS

![](fig/logo_queens.png)

## What is QUEENS?

QUEENS is a Python framework for solver-independent multi-query analyses of large-scale computational models. It fulfills two major objectives: first, it provides a broad suite of analysis techniques, ranging from parameter studies to Bayesian inverse problems, with an emphasis on probabilistic approaches; and second, it ensures robust management of multi-query settings in high-performance computing (HPC) environments, including simulation scheduling, error handling, and communication management, all in a solver-agnostic fashion. The application of modern probabilistic methods to advanced physics-based models is enabled through a high-level Python abstraction, thereby facilitating comprehensive analyses of complex systems within HPC workflows.

## What is covered in this tutorial?

This tutorial covers basic workflowss in QUEENS.

After successfull completion of this tutorial, you will know how to

- setup a QUEENS analysis script;
- create and evaluate a model in QUEENS;
- define random variables;
- perform Monte Carlo integration.

## How to work with this tutorial?

An introductory presentation is located here:

- `0-presentations/`

The tutorial is organized in two examples, where each example is stored in its own directory. The directories are:

- `1-grid-iterator-rosenbrock/`
- `2-uncertainty-propagation-and-quantification/`

For each example, a Jupiter notebook (file ending `*.ipynb`) guides you through the learning task. It briefly introduces the problem setting and then explains the content and structure of a suitable QUEENS workflow for the example.

This tutorial is intended for self-study. Please work through the tutorial material for yourself or in small groups. Experienced QUEENS developers will be present to help with questions or problems.

---

## Resources:

- QUEENS Website: https://www.queens-py.org
- QUEENS GitHub Repository: https://github.com/queens-py/queens