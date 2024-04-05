package test_xatlas

import "core:bytes"
import "core:fmt"
import "core:runtime"
import "core:testing"
import "shared:ounit"
import xa ".."

@(test)
verify_sizes :: proc(t: ^testing.T) {
	using ounit
	expect_size(t, xa.xatlasChart, 24)
	expect_size(t, xa.xatlasChart, 24)
	expect_size(t, xa.xatlasVertex,20)
	expect_size(t, xa.xatlasMesh,40)
	expect_size(t, xa.xatlasAtlas,48)
	expect_size(t, xa.xatlasMeshDecl, 96)
	expect_size(t, xa.xatlasUvMeshDecl,48)
	expect_size(t, xa.xatlasChartOptions, 48)
	expect_size(t, xa.xatlasPackOptions, 24)
}

@(test)
can_construct :: proc(t: ^testing.T) {
	atlas := xa.xatlasCreate()
	defer xa.xatlasDestroy(atlas)

	testing.expect(t, atlas != nil)
}

@(test)
add_mesh :: proc(t: ^testing.T) {
	atlas := xa.xatlasCreate()
	defer xa.xatlasDestroy(atlas)
	assert(atlas != nil)

	// act:= Z80_MAXIMUM_CYCLES
	// exp:= 18446744073709551585
	// testing.expect(t, act == exp, fmt.tprintf("%v (should be: %v)", act, exp))
}
