def yaml_to_vtu(path, mesh_name):
    import lnmmeshio

    with open(path, "r") as f:
        pv_obj = lnmmeshio.to_pyvista(lnmmeshio.read_four_c_yaml(f))

    pv_obj.save(mesh_name)


yaml_to_vtu("coarse_plate_dirichlet_template.4C.yaml", "membrane.vtu")
# yaml_to_vtu("coarse_plate_dirichlet_template.4C.yaml", "translated.vtu")
