module mmesh1
using LibFEM
using LibFEM.Mesh
using Test
function test()
    @test Mesh.P1.manifdim == 0
    @test Mesh.L2.nfacets == 2
    true
end
end
using .mmesh1
mmesh1.test()

module mmesh2
using StaticArrays
using LibFEM
using LibFEM.Mesh: Vertices, nvertices, coordinates
using Test
function test()
    xyz = [0.0 0.0; 633.3333333333334 0.0; 1266.6666666666667 0.0; 1900.0 0.0; 0.0 400.0; 633.3333333333334 400.0; 1266.6666666666667 400.0; 1900.0 400.0; 0.0 800.0; 633.3333333333334 800.0; 1266.6666666666667 800.0; 1900.0 800.0]
    v =  Vertices(xyz)
    @test nvertices(v) == 12
    x = coordinates(v, SVector{2}([2, 4]))
    @test x[1] == SVector{2}([633.3333333333334 0.0])
    true
end
end
using .mmesh2
mmesh2.test()

module mmesh3
using StaticArrays
using LibFEM
using LibFEM.Mesh: L2, Q4, Shapes, connectivity, manifdim, nnodes, nfacets, facettype
using Test
function test()
    shapetype = Q4
    c = [(1, 2, 6, 5), (5, 6, 10, 9), (2, 3, 7, 6), (6, 7, 11, 10), (3, 4, 8, 7), (7, 8, 12, 11)]
    cc = [SVector{shapetype.nnodes}(c[idx]) for idx in 1:length(c)]
    shapes = Shapes(shapetype, cc)
    @test connectivity(shapes, 3)[3] == 7
    @test connectivity(shapes, SVector{2}([2, 4]))[1][4] == 9
    @test manifdim(shapes) == 2
    @test nnodes(shapes) == 4
    @test facettype(shapes) == L2
    @test nfacets(shapes) == 4
    true
end
end
using .mmesh3
mmesh3.test()
