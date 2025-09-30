import pyvista as pv
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection


def plot_field(field, ax, color_bar_title):
    mesh = pv.read("membrane_20.e")[0][0]
    mesh.cell_data["field"] = field
    cell_values = field

    faces = mesh.extract_surface().faces.reshape((-1, 5))[:, 1:]  
    vertices = mesh.points

    cmap = plt.get_cmap("viridis")
    norm = plt.Normalize(vmin=cell_values.min(), vmax=cell_values.max())
    colors = [cmap(norm(val)) for val in cell_values]

    poly3d = [[vertices[idx] for idx in face] for face in faces]
    collection = Poly3DCollection(poly3d, facecolors=colors, edgecolor="k", linewidths=0.2)
    ax.add_collection3d(collection)

    ax.auto_scale_xyz(vertices[:, 0], vertices[:, 1], vertices[:, 2])
    ax.set_axis_off()
    
    sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
    sm.set_array([])
    plt.colorbar(sm, ax=ax, fraction=0.02, pad=0.04, label=color_bar_title)

    ax.view_init(elev=90, azim=-90)


def plot_random_field(random_field, latent_sample, plotter, color_bar_title):
    field = random_field.expanded_representation([latent_sample])[0]
    plot_field(field, plotter, color_bar_title)
