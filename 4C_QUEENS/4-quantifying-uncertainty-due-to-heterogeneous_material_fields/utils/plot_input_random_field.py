import pyvista as pv


def plot_field(field, plotter, color_bar_title):
    mesh = pv.read("membrane_20.e")[0][0]
    mesh.cell_data["field"] = field
    plotter.add_mesh(
        mesh,
        scalars="field",
        scalar_bar_args={
            "title": color_bar_title,
            "title_font_size": 10,
            "label_font_size": 10,
        },
    )
    plotter.view_xy()


def plot_random_field(random_field, latent_sample, plotter, color_bar_title):
    field = random_field.expanded_representation([latent_sample])[0]
    plot_field(field, plotter, color_bar_title)
