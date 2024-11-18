package test_xatlas

import xatlas ".."
import "core:testing"
import ot "shared:ounit"

@(test)
verify_sizes :: proc(t: ^testing.T) {
	ot.expect_size(t, xatlas.Chart, 24)
	ot.expect_size(t, xatlas.Vertex, 20)
	ot.expect_size(t, xatlas.Mesh, 40)
	ot.expect_size(t, xatlas.Atlas, 48)
	ot.expect_size(t, xatlas.MeshDecl, 96)
	ot.expect_size(t, xatlas.UvMeshDecl, 48)
	ot.expect_size(t, xatlas.ChartOptions, 48)
	ot.expect_size(t, xatlas.PackOptions, 24)
}

@(test)
can_construct :: proc(t: ^testing.T) {
	atlas := xatlas.Create()
	defer xatlas.Destroy(atlas)

	testing.expect(t, atlas != nil)
}

@(test)
progress_category :: proc(t: ^testing.T) {
	category: xatlas.ProgressCategory
	str: cstring

	category = xatlas.ProgressCategory.XATLAS_PROGRESS_CATEGORY_ADDMESH
	str = xatlas.ProgressCategoryString(category)
	testing.expect(t, str == "Adding mesh(es)", string(str))

	category = xatlas.ProgressCategory.XATLAS_PROGRESS_CATEGORY_COMPUTECHARTS
	str = xatlas.ProgressCategoryString(category)
	testing.expect(t, str == "Computing charts", string(str))

	category = xatlas.ProgressCategory.XATLAS_PROGRESS_CATEGORY_PACKCHARTS
	str = xatlas.ProgressCategoryString(category)
	testing.expect(t, str == "Packing charts", string(str))

	category = xatlas.ProgressCategory.XATLAS_PROGRESS_CATEGORY_BUILDOUTPUTMESHES
	str = xatlas.ProgressCategoryString(category)
	testing.expect(t, str == "Building output meshes", string(str))
}
