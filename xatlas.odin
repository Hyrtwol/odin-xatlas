package xatlas

import _c "core:c"

foreign import xatlas "xatlas.lib"

uint32_t :: _c.uint32_t
int32_t :: _c.int32_t
size_t :: _c.size_t
float :: _c.float
float2 :: [2]float
bool :: _c.bool

ImageChartIndexMask :: 0x1FFFFFFF
ImageHasChartIndexBit :: 0x80000000
ImageIsBilinearBit :: 0x40000000
ImageIsPaddingBit :: 0x20000000

ParameterizeFunc :: #type proc "c" (positions : ^float, texcoords : ^float, vertexCount : u32, indices : ^u32, indexCount : u32)
ProgressFunc :: #type proc "c" (category : ProgressCategory, progress : _c.int, userData : rawptr) -> bool
ReallocFunc :: #type proc "c" (pointer : rawptr, size : size_t) -> rawptr
FreeFunc :: #type proc "c" (pointer : rawptr)
PrintFunc :: #type proc "c" (format : cstring, #c_vararg args: ..any) -> _c.int

ChartType :: enum i32 {
    XATLAS_CHART_TYPE_PLANAR,
    XATLAS_CHART_TYPE_ORTHO,
    XATLAS_CHART_TYPE_LSCM,
    XATLAS_CHART_TYPE_PIECEWISE,
    XATLAS_CHART_TYPE_INVALID,
}

IndexFormat :: enum i32 {
    XATLAS_INDEX_FORMAT_UINT16,
    XATLAS_INDEX_FORMAT_UINT32,
}

AddMeshError :: enum i32 {
    XATLAS_ADD_MESH_ERROR_SUCCESS,
    XATLAS_ADD_MESH_ERROR_ERROR,
    XATLAS_ADD_MESH_ERROR_INDEXOUTOFRANGE,
    XATLAS_ADD_MESH_ERROR_INVALIDFACEVERTEXCOUNT,
    XATLAS_ADD_MESH_ERROR_INVALIDINDEXCOUNT,
}

ProgressCategory :: enum i32 {
    XATLAS_PROGRESS_CATEGORY_ADDMESH,
    XATLAS_PROGRESS_CATEGORY_COMPUTECHARTS,
    XATLAS_PROGRESS_CATEGORY_PACKCHARTS,
    XATLAS_PROGRESS_CATEGORY_BUILDOUTPUTMESHES,
}

Chart :: struct {
    faceArray : ^u32,
    atlasIndex : u32,
    faceCount : u32,
    type : ChartType,
    material : u32,
}

Vertex :: struct {
    atlasIndex : i32,
    chartIndex : i32,
    uv : float2,
    xref : u32,
}

Mesh :: struct {
    chartArray : ^Chart,
    indexArray : ^u32,
    vertexArray : ^Vertex,
    chartCount : u32,
    indexCount : u32,
    vertexCount : u32,
}

Atlas :: struct {
    image : ^u32,
    meshes : ^Mesh,
    utilization : ^float,
    width : u32,
    height : u32,
    atlasCount : u32,
    chartCount : u32,
    meshCount : u32,
    texelsPerUnit : float,
}

MeshDecl :: struct {
    vertexPositionData : rawptr,
    vertexNormalData : rawptr,
    vertexUvData : rawptr,
    indexData : rawptr,
    faceIgnoreData : ^bool,
    faceMaterialData : ^u32,
    faceVertexCount : ^u8,
    vertexCount : u32,
    vertexPositionStride : u32,
    vertexNormalStride : u32,
    vertexUvStride : u32,
    indexCount : u32,
    indexOffset : i32,
    faceCount : u32,
    indexFormat : IndexFormat,
    epsilon : float,
}

UvMeshDecl :: struct {
    vertexUvData : rawptr,
    indexData : rawptr,
    faceMaterialData : ^u32,
    vertexCount : u32,
    vertexStride : u32,
    indexCount : u32,
    indexOffset : i32,
    indexFormat : IndexFormat,
}

ChartOptions :: struct {
    paramFunc : ParameterizeFunc,
    maxChartArea : float,
    maxBoundaryLength : float,
    normalDeviationWeight : float,
    roundnessWeight : float,
    straightnessWeight : float,
    normalSeamWeight : float,
    textureSeamWeight : float,
    maxCost : float,
    maxIterations : u32,
    useInputMeshUvs : bool,
    fixWinding : bool,
}

PackOptions :: struct {
    maxChartSize : u32,
    padding : u32,
    texelsPerUnit : float,
    resolution : u32,
    bilinear : bool,
    blockAlign : bool,
    bruteForce : bool,
    createImage : bool,
    rotateChartsToAxis : bool,
    rotateCharts : bool,
}

@(default_calling_convention="c", link_prefix = "xatlas")
foreign xatlas {
    Create :: proc() -> ^Atlas ---
    Destroy :: proc(atlas : ^Atlas) ---
    AddMesh :: proc(atlas : ^Atlas, meshDecl : ^MeshDecl, meshCountHint : u32) -> AddMeshError ---
    AddMeshJoin :: proc(atlas : ^Atlas) ---
    AddUvMesh :: proc(atlas : ^Atlas, decl : ^UvMeshDecl) -> AddMeshError ---
    ComputeCharts :: proc(atlas : ^Atlas, chartOptions : ^ChartOptions) ---
    PackCharts :: proc(atlas : ^Atlas, packOptions : ^PackOptions) ---
    Generate :: proc(atlas : ^Atlas, chartOptions : ^ChartOptions, packOptions : ^PackOptions) ---
    SetProgressCallback :: proc(atlas : ^Atlas, progressFunc : ProgressFunc, progressUserData : rawptr) ---
    SetAlloc :: proc(reallocFunc : ReallocFunc, freeFunc : FreeFunc) ---
    SetPrint :: proc(print : PrintFunc, verbose : bool) ---
    AddMeshErrorString :: proc(error : AddMeshError) -> cstring ---
    ProgressCategoryString :: proc(category : ProgressCategory) -> cstring ---
    MeshDeclInit :: proc(meshDecl : ^MeshDecl) ---
    UvMeshDeclInit :: proc(uvMeshDecl : ^UvMeshDecl) ---
    ChartOptionsInit :: proc(chartOptions : ^ChartOptions) ---
    PackOptionsInit :: proc(packOptions : ^PackOptions) ---
}
