from skfem import ElementTriP1, Basis, BilinearForm, LinearForm, enforce, solve, MeshTri
from skfem.helpers import dot, grad

mesh = MeshTri().refined(6)


def poisson_pde(source_x, source_y, source_term):

    # Set discretization
    e = ElementTriP1()
    basis = Basis(mesh, e)

    @BilinearForm
    def laplace(u, v, _):
        return dot(grad(u), grad(v))

    @LinearForm
    def rhs(v, w):
        # Source term
        return source_term(w.x[0], w.x[1], source_x, source_y) * v

    # Stiffness matrix
    A = laplace.assemble(basis)

    # Right-hand side
    b = rhs.assemble(basis)

    # Enforce Dirichlet boundary conditions
    A, b = enforce(A, b, D=mesh.boundary_nodes())

    # Solve
    solution = solve(A, b)

    return solution


def plot_to_axis(field, ax):
    mesh.plot(field, ax=ax)
    ax.axis("equal")
    ax.set_aspect("equal", "box")
    ax.set_xlim([0, 1])
    ax.set_ylim([0, 1])
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")
