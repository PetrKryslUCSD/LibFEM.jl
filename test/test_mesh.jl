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
using LibFEM
using LibFEM.Mesh
using Test
function test()
        xyz = [0.0 0.0; 633.3333333333334 0.0; 1266.6666666666667 0.0; 1900.0 0.0; 0.0 400.0; 633.3333333333334 400.0; 1266.6666666666667 400.0; 1900.0 400.0; 0.0 800.0; 633.3333333333334 800.0; 1266.6666666666667 800.0; 1900.0 800.0]
        @show Mesh.Nodes(xyz)
        true
end
end
using .mmesh2
mmesh2.test()
