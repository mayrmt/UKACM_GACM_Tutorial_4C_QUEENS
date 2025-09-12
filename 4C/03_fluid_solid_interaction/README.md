# Introduction to monolithic fluid/solid interaction in 4C

This tutorial demonstrates the simulation of a fluid/solid interaction (FSI) problem using a monolithic approach. The solid domain is governed by the equations of elastodynamics, whil the flow domain is subject to incompressible Navier-Stokes equations described by an Arbitrary Lagrangean-Euelerian (ALE) observer.

As concrete example, this tutorial studies a pressure wave through an elastic tube. This problem has originally been introduced by Gerbeau and Vidrascu (2003) [1] and is designed to mimic hemodynamic
conditions, especially w.r.t. to the material densities with the ratio $\rho^S/\rho^F \approx 1$. Nowadays, it is widely considered a benchmark for monolithic solvers in the FSI community.

## Problem description

The system consists of a straight, thin-walled solid tube (length $\ell = 5 cm$, outer radius $r_o = 0.6 cm$, inner radius $r_i = 0.5 cm$) that is filled with fluid. The solid tube is fully clamped at both ends. Both solid and fluid are initially at rest.

As external excitation, the fluid surface at $z = 0$ is loaded with a surface traction $h^F = 1.3332\cdot 10^4 g\cdot cm/s^2$ in $z$-direction for the duration of $3\cdot 10^{−3} s$. The fluid velocities at $z=\ell$ are prescribed to zero, essentially closing the tube at the far end.

The pressure pulse travels along the longitudinal axis of the tube, causing a traveling radial dilation of the tube:

![](fig/pw.jpg)

## Model setup in 4C

To create a 4C model and input file, at least two ingredients are required:

- The finite element mesh in a suitable mesh format
- A `*.4C.yaml` file will all simulation parameters and boundary conditions

This tutorial comes with ready-to-use mesh files, so that the focus can be put on creating input files for 4C simulations.

### Predefined Mesh Files

This tutorial comes with a series of ready-to-use meshes with different mesh resolutions.
The following meshes are available (along with recommendation for the number of MPI ranks to run each mesh):

| Filename  | Global number of DOFs | MPI ranks |
|-----------|-----------------------|-----------|
| pw_m1.exo | 8406                  | 1         |
| pw_m2.exo | 58333                 | 2         |
| pw_m3.exo | 187516                | 8         |

Each mesh file contains both solid and fluid mesh. See for example the mesh `pw_m2.exo`:

![](fig/pw_m2.png)

The mesh contains the following node sets:

| Node Set ID | Node Set Name           | Description |
|-------------|-------------------------|-------------|
| 1           | solid_fsi_surf          | FSI interface of the solid domain |
| 2           | fluid_fsi_surf          | FSI interface of the fluid domain |
| 3           | solid_clamp_surf        | Fully constrained solid surfaces at both ends of the tube |
| 4           | fluid_inflow_surf       | Fluid surface subject to the pressure pulse |
| 5           | fluid_outflow_surf      | Fluid surface at the other end of the tube |
| 6           | solid_fsi_no_dbc_curves | Solid nodes at the intersection of Dirichlet boundary and FSI interface |
| 7           | fluid_fsi_no_dbc_curves | Fluid nodes at the intersection of Dirichlet boundary and FSI interface |

Both solid and fluid are meshed with eight-noded hexahedral elements to support a finite element basis with 1st order Lagrange polynomials.

### Creating the 4C input file

You will now create the 4C input file. Therefore, create a new file entitled `pw.4C.yaml`.
Now, insert the first set of simulation parameters:

- Define the problem type in order to solve a fluid/solid interaction problem:

   ```yaml
   PROBLEM TYPE:
     PROBLEMTYPE: "Fluid_Structure_Interaction"
   ```

- Define the spatial dimension:

   ```yaml
   PROBLEM SIZE:
      DIM: 3
   ```

In order to solve an FSI problem, you now need to define the involved single fields (solid, fluid, ALE mesh motion)
as well as the interaction among them.
First, let's define the individual fields:

- Solid:

   ```yaml
   STRUCTURAL DYNAMIC:
     INT_STRATEGY: "Old"
     LINEAR_SOLVER: 1
   ```

- Define a **fluid** field:

   ```yaml
   FLUID DYNAMIC:
     LINEAR_SOLVER: 1
     TIMEINTEGR: "Np_Gen_Alpha"
     ALPHA_M: 0.5
     ALPHA_F: 0.5
     GAMMA: 0.5
     NONLINITER: Newton
     GRIDVEL: BDF2
   ```

   It performs time integration via the Generalized-alpha scheme [2].
   The nonlinear problem in each time step is solved by a Newton method.
   A 2nd-order backward differentiation formula (BDF2) is used to approximate the grid velocity in the ALE description of the Navier-Stokes equations based on the ALE Mesh discplacements.

- The mesh motion problem of the ALE formulation of the fluid domain is defined as follows:

   ```yaml
     ALE DYNAMIC:
       ALE_TYPE: springs_material
       LINEAR_SOLVER: 1
    ```

### Boundary conditions

### Linear solver

In this tutorial, we will explore two different solver options for monolithic FSI problesm: direct vs. iterative.
While direct solvers are easy to use, since they do not require the choice of solver parameters,
they are often less efficient than properly preconditioned iterarative linear solvers.

First, we prepare the input file by adding two differnt solvers:

```yaml
SOLVER 1:
  SOLVER: "UMFPACK"
SOLVER 2:
  SOLVER: "Belos"
  AZPREC: "MueLu"
  AZREUSE: 10
  SOLVER_XML_FILE: "gmres.xml"
  MUELU_XML_FILE: "muelu_solid_fluid_ale.xml"
  NAME: "Fsi_Solver"
```

Therein, `SOLVER 1` selects a direct solver, `UMFPACK`, while `SOLVER 2` defines an FSI-specific multigrid preconditioner proposed by Gee et al. (2011) [3].
The additional files `gmres.xml` and `muelu_solid_fluid_ale.xml` are part of this repository.
For details on the use and defintion of iterative solvers and multigrid preconditions in 4C, we refer to [4C's preconditioning tutorial](https://4c-multiphysics.github.io/4C/documentation/tutorials/tutorial_preconditioning.html).

You can later switch between both the direct and the iterative solver by changing the solver ID in the input parameter `LINEAR_SOLVER` within the `FSI DYNAMIC/MONOLITHIC SOLVER:` section of the 4C input file.

#### Direct Solver

First, we start with a direct solver. It is defined as follows:

```yaml
SOLVER 1:
  SOLVER: "UMFPACK"
```

This enables `UMFPACK` as direct solver, which will compute an LU factorization of the FSI system matrix and use it to solve the arising linear system of equations.

To tell the FSI algorithm to use this solver, make sure to set assign the value `1` to the input parameter `LINEAR_SOLVER` within the `FSI DYNAMIC/MONOLITHIC SOLVER:` section of the 4C input file.

#### Iterative Solver

To overcome performance and feasibility limitations of direct solvers, let us now explore iterative solvers with appropriate preconditioning.
Therefore, define a second solver in the 4C input file by adding:

```yaml
SOLVER 2:
  SOLVER: "Belos"
  AZPREC: "MueLu"
  AZREUSE: 10
  SOLVER_XML_FILE: "gmres.xml"
  MUELU_XML_FILE: "muelu_solid_fluid_ale.xml"
```

The parameter `SOVLER: "Belos"` enables a Generalized Minimual Residual (GMRES) solver [4] from Trilinos' Belos package [5] as iterative solver, which will approximate the solution of the linear system up to a user-given tolerance. The exact settings of the GMRES method are pre-defined in `gmres.xml`. To accelerate convergence of the GMRES solver, `AZPREC` points 4C to use Trilinos' `MueLu` package as a preconditioner. In this tutorial, we employ a fully coupled algenraic multigrid preconditioner tailored to FSI systems as proposed in [3]. It is defined in `muelu_solid_fluid_ale.xml`. By setting `AZREUSE: 10`, the preconditioner can be reused up to ten times in order to save the cost for preconditioner setup.

> For details on the use and defintion of iterative solvers and multigrid preconditions in 4C, we refer to [4C's preconditioning tutorial](https://4c-multiphysics.github.io/4C/documentation/tutorials/tutorial_preconditioning.html).

To tell the FSI algorithm to use `SOLVER 2`, make sure to set assign the value `2` to the input parameter `LINEAR_SOLVER` within the `FSI DYNAMIC/MONOLITHIC SOLVER:` section of the 4C input file.

---

[1] J.-F. Gerbeau and M. Vidrascu. A quasi-Newton algorithm based on a reduced model for fluid-structure interaction problems in blood flows. ESAIM: Mathematical Modelling and Numerical Analysis (Mod´elisation Math´ematique et Analyse Num´erique), 37(4):631–647, 2003

[2] K. E. Jansen, C. H. Whiting, and G. M. Hulbert. A generalized-α method for integrating the filtered Navier–Stokes equations with a stabilized finite element method. Computer Methods in Applied Mechanics and Engineering, 190(3–4):305–319, 2000

[3] M. W. Gee, U. Küttler, and W. A. Wall. Truly monolithic algebraic multigrid for fluid–structure interaction. International Journal for Numerical Methods in Engineering, 85(8):987–1016, 2011

[4] Y. Saad and M. H. Schultz. GMRES: A Generalized Minimal Residual Algorithm for Solving Nonsymmetric Linear Systems. SIAM Journal on Scientific and Statistical Computing, 7(3):856–869, 1986

[5] E. Bavier, M. Hoemmen, S. Rajamanickam, and H. Thornquist. Amesos2 and Belos: Direct and Iterative Solvers for Large Sparse Linear Systems. Scientific Programming, 20(3):241–255, 2012
