import pyvista as pv

fe_mesh = pv.read("beam_coarse.exo")


def plot_results(
    result_file, plotter, color_bar_title="zz-component of Cauchy stress tensor\n"
):
    outputs = pv.read(result_file).warp_by_vector("displacement")
    plotter.add_mesh(fe_mesh.copy(), style="wireframe", color="blue")
    outputs["cauchy_zz"] = outputs["element_cauchy_stresses_xyz"][:, 2]
    plotter.add_mesh(
        outputs,
        scalars="cauchy_zz",
        scalar_bar_args={
            "title": color_bar_title,
            "title_font_size": 15,
            "label_font_size": 15,
        },
    )
    plotter.add_axes(line_width=5)
    plotter.camera_position = [
        (1.1321899035097993, -6.851600196807601, 2.7649096132703574),
        (0.0, 0.0, 0.2749999999999999),
        (-0.97637930372977, -0.08995062285804697, 0.19644933366041056),
    ]
