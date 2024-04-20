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
