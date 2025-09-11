# Introduction to monolithic fluid/solid interaction in 4C

This tutorial demonstrates the simulation of a fluid/solid interaction (FSI) problem using a monolithic approach. The solid domain is governed by the equations of elastodynamics, whil the flow domain is subject to incompressible Navier-Stokes equations described by an Arbitrary Lagrangean-Euelerian (ALE) observer.

As concrete example, this tutorial studies a pressure wave through an elastic tube. This problem has originally been introduced by Gerbeau and Vidrascu (2003) [^1] and is designed to mimic hemodynamic
conditions, especially w.r.t. to the material densities with the ratio $\rho^S/\rho^F \approx 1$. Nowadays, it is widely considered a benchmark for monolithic solvers in the FSI community.

## Problem description

The system consists of a straight, thin-walled solid tube (length $\ell = 5 cm$, outer radius $r_o = 0.6 cm$, inner radius $r_i = 0.5 cm$) that is filled with fluid. The solid tube is fully clamped at both ends. Both solid and fluid are initially at rest.

As external excitation, the fluid surface at $z = 0$ is loaded with a surface traction $h^F = 1.3332\cdot 10^4 g\cdot cm/s^2$ in $z$-direction for the duration of $3\cdot 10^{−3} s$. The fluid velocities at $z=\ell$ are prescribed to zero, essentially closing the tube at the far end.

The pressure pulse travels along the longitudinal axis of the tube, causing a traveling radial dilation of the tube:

![](fig/pw.jpg)

## Model setup in 4C

### Mesh

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

### Boundary conditions

### Linear solver

#### Direct solver

#### Iterative solver with algebraic multigrid preconditioning

[^2]

---

[^1] J.-F. Gerbeau and M. Vidrascu. A quasi-Newton algorithm based on a reduced model for fluid-
structure interaction problems in blood flows. ESAIM: Mathematical Modelling and Numerical Analysis (Mod´elisation Math´ematique et Analyse Num´erique), 37(4):631–647, 2003

[^2] M. W. Gee, U. Küttler, and W. A. Wall. Truly monolithic algebraic multigrid for fluid–structure interaction. International Journal for Numerical Methods in Engineering, 85(8):987–1016, 2011
