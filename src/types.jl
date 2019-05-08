struct Vertex
    x::Float32
    y::Float32
    z::Float32
end

struct Triangle
    vertices::SVector{3, Vertex}
end # struct Triangle
