package test_xatlas

import xa ".."
import "core:testing"
import ot "shared:ounit"

@(test)
verify_sizes :: proc(t: ^testing.T) {
	ot.expect_size(t, xa.xatlasChart, 24)
	ot.expect_size(t, xa.xatlasChart, 24)
	ot.expect_size(t, xa.xatlasVertex, 20)
	ot.expect_size(t, xa.xatlasMesh, 40)
	ot.expect_size(t, xa.xatlasAtlas, 48)
	ot.expect_size(t, xa.xatlasMeshDecl, 96)
	ot.expect_size(t, xa.xatlasUvMeshDecl, 48)
	ot.expect_size(t, xa.xatlasChartOptions, 48)
	ot.expect_size(t, xa.xatlasPackOptions, 24)
}

@(test)
can_construct :: proc(t: ^testing.T) {
	atlas := xa.xatlasCreate()
	defer xa.xatlasDestroy(atlas)

	testing.expect(t, atlas != nil)
}

@(test)
progress_category :: proc(t: ^testing.T) {
	category : xa.xatlasProgressCategory
	str: cstring

	category = xa.xatlasProgressCategory.XATLAS_PROGRESS_CATEGORY_ADDMESH
	str = xa.xatlasProgressCategoryString(category)
	testing.expect(t, str == "Adding mesh(es)", string(str))

	category = xa.xatlasProgressCategory.XATLAS_PROGRESS_CATEGORY_COMPUTECHARTS
	str = xa.xatlasProgressCategoryString(category)
	testing.expect(t, str == "Computing charts", string(str))

	category = xa.xatlasProgressCategory.XATLAS_PROGRESS_CATEGORY_PACKCHARTS
	str = xa.xatlasProgressCategoryString(category)
	testing.expect(t, str == "Packing charts", string(str))

	category = xa.xatlasProgressCategory.XATLAS_PROGRESS_CATEGORY_BUILDOUTPUTMESHES
	str = xa.xatlasProgressCategoryString(category)
	testing.expect(t, str == "Building output meshes", string(str))
}
