
"""
    Vertices{N, T}

Vertices of the mesh.
"""
struct Vertices{N, T}
    coordinates::Vector{SVector{N, T}}
end

"""
    Vertices(xyz::Array{T, 2}) where {T}

Construct from a 2D array, one vertex per row.
"""
function Vertices(xyz::Array{T, 2}) where {T}
    N = size(xyz, 2)
    Vertices([SVector{N, T}(xyz[i, :]) for i in 1:size(xyz, 1)])
end

nvertices(v::Vertices{N, T}) where {N, T} = length(v.coordinates)

"""
    coordinates(nodes::Vertices{N, T}, I::SVector) where {N, T}

Access coordinates of selected vertices.
"""
@generated function coordinates(nodes::Vertices{N, T}, I::SVector) where {N, T}
    nidx = length(I)
    expr = :(())
    for i in 1:nidx
        push!(expr.args, :(nodes.coordinates[I[$i]]))
    end
    return :(SVector($expr))
end
