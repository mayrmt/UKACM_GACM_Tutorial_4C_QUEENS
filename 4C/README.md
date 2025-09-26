# 4C Multiphysics

![](fig/logo_4C.png)

## What is 4C Multiphysics?

4C is a parallel multiphysics research code to analyze and solve a plethora of physical problems
described by ordinary or partial differential equations. Its development is driven by challenging research questions and real-world problems, for which existing tools do not suffice, either due to the lack of capabilities or due to falling short of accuracy or performance. 4C offers ready-to-use simulation
capabilities for a variety of physical models, encompassing single-field systems such as solids, fluids, and scalar transport phenomena, as well as coupled multiphysics systems. Its modular architecture
also supports research in mathematical modeling and the development of novel numerical methods.

## What is covered in this tutorial?

This tutorial covers the creation of 4C input files as well as running 4C simulations. It starts with a simple single-field solid mechanics problem and then gradually increases the complexity to contact mechanics as well as fluid-solid interaction.

After successfull completion of this tutorial, you will know how to

- read, modify, and create 4C input files;
- define Dirichlet and Neumann boundary conditions;
- run 4C simulations from the command line;
- visualize 4C simulation results in ParaView.

## How to work with this tutorial?

The tutorial is organized in three examples, where each example is stored in its own directory. The directories are:

- `01_solid_mechanics/`
- `02_contact_mechanics/`
- `03_fluid_solid_interaction/`

For each example, a `README.md` guides you through the learning task. It briefly introduces the problem setting and then explains the content and structure of a suitable 4C input file for the example. Each example concludes with some additional numerical experimentation steps, where you can modify the example and observe the effect of the modification on the simulation progress and outcome.

This tutorial is intended for self-study. Please work through the tutorial material for yourself or in small groups. Experienced 4C developers will be present to help with questions or problems.

---

## Resources:

- Website: [https://4c-multiphysics.org](https://4c-multiphysics.org)
- GitHub: [https://github.com/4C-multiphysics/4C](https://github.com/4C-multiphysics/4C)