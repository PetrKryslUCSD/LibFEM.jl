
"""
    AbstractShapeType

Abstract shape type (simplex, or cuboid, of various manifold dimension)
"""
abstract type AbstractShapeType end

struct P1Shape <: AbstractShapeType
    manifdim::Int64
    nnodes::Int64
    nfacets::Int64
    facets::SMatrix{0, 1, Int64, 0}
end

const P1 = P1Shape(0, 1, 0, SMatrix{0, 1}([]))

struct L2Shape <: AbstractShapeType
    manifdim::Int64
    nnodes::Int64
    nfacets::Int64
    facets::SMatrix{1, 2, Int64, 2}
end

const L2 = L2Shape(1, 2, 2, SMatrix{1, 2}([1 2]))

struct Q4Shape <: AbstractShapeType
    manifdim::Int64
    nnodes::Int64
    nfacets::Int64
    facets::SMatrix{2, 4, Int64, 8}
end

const Q4 = Q4Shape(2, 4, 4, SMatrix{2, 4}([1 2; 2 3; 3 4; 4 1]))

struct H8Shape <: AbstractShapeType
    manifdim::Int64
    nnodes::Int64
    nfacets::Int64
    facets::SMatrix{4, 6, Int64, 24}
end

const H8 = H8Shape(3, 8, 6, SMatrix{4, 6}(
[1 4 3 2;
1 2 6 5;
2 3 7 6;
3 4 8 7;
4 1 5 8;
6 7 8 5]))

struct T3Shape <: AbstractShapeType
    manifdim::Int64
    nnodes::Int64
    nfacets::Int64
    facets::SMatrix{2, 3, Int64, 6}
end

const T3 = T3Shape(2, 3, 3, SMatrix{2, 3}(
[1 2; 2 3; 3 1]))

struct T4Shape <: AbstractShapeType
    manifdim::Int64
    nnodes::Int64
    nfacets::Int64
    facets::SMatrix{3, 4, Int64, 12}
end

const T4 = T4Shape(3, 4, 4, SMatrix{3, 4}([1 3 2; 1 2 4; 2 3 4; 1 4 3]))

struct Shapes{S <: AbstractShapeType, N, T}
    shapetype::S
    connectivity::Vector{SVector{N, T}}
end

connectivity(shapes::Shapes{S, N, T}, i::I) where {S, N, T, I} = shapes.connectivity[i]

@generated function connectivity(shapes::Shapes{S, N, T}, I::SVector) where {S, N, T}
    nidx = length(I)
    expr = :(())
    for i in 1:nidx
        push!(expr.args, :(shapes.connectivity[I[$i]]))
    end
    return :(SVector($expr))
end

manifdim(shapes::Shapes{S, N, T}) where {S, N, T} = shapes.shapetype.manifdim
nnodes(shapes::Shapes{S, N, T}) where {S, N, T} = shapes.shapetype.nnodes
nfacets(shapes::Shapes{S, N, T}) where {S, N, T} = shapes.shapetype.nfacets
facets(shapes::Shapes{S, N, T}) where {S, N, T} = shapes.shapetype.facets