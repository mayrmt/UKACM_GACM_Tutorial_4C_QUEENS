# Combined use of 4C and QUEENS

![](fig/both_logos.png)

## The 4C & QUEENS Ecosystem

Physical and probabilistic modeling are distinct but complementary domains, each requiring specialized
expertise to address their respective challenges. The 4C and QUEENS frameworks provide an interoperable ecosystem that bridges these domains: 4C enables high-fidelity physical modeling of single- and multiphysics systems, while QUEENS offers capabilities for simulation analytics and probabilistic modeling. Their co-development and interoperability allow researchers to develop models in their respective domains independently, while facilitating the seamless fusion of multiphysics simulations with probabilistic analysis techniques.

This tutorial will demonstrate how computational mechanics researchers can exploit this interoperability to enhance predictive capabilities and accelerate scientific discovery. Topics will range from simulation analytics to Bayesian uncertainty quantification, illustrated with practical examples based on 4C multiphysics models of various complexity to lay a solid foundation for future innovative research.

## What is covered in this tutorial?

This tutorial covers the interplay of 4C and QUEENS and demonstrates how to orchestrate a series of 4C simulations from QUEENS. It starts with simple parameter studies and then graudally increases the complexity to parameter identifiaction and uncertainty quantification.

After successfull completion of this tutorial, you will know how to

- perform a parameter study with 4C and QUEENS
- indentify material parameters for simulation models based on actual measurement data
- assess and quantify impact of uncertain input parameters, e.g. material parameters, on the model outcome, e.g. displacements or stresses.

## How to work with this tutorial?

The tutorial is organized in two examples, where each example is stored in its own directory. The directories are:

- `3-orchestrating-4C-simulations-with-QUEENS/`
- `4-quantifying-uncertainty-due-to-heterogeneous_material_fields/`

For each example, a Jupiter notebook (file ending `*.ipynb`) guides you through the learning task. It briefly introduces the problem setting and then explains the content and structure of a suitable QUEENS workflow for the example. 

This tutorial is intended for self-study. Please work through the tutorial material for yourself or in small groups. Experienced 4C and QUEENS developers will be present to help with questions or problems.

---

## Resources:

- 4C Website: https://4c-multiphysics.org
- 4C GitHub Repository: https://github.com/4C-multiphysics/4C
- QUEENS Website: https://www.queens-py.org
- QUEENS GitHub Repository: https://github.com/queens-py/queens




