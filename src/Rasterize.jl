module Rasterize

export prepare_arguments, run, rasterize!

### IMPORTS  ###
using StaticArrays
using LinearAlgebra
using BenchmarkTools
################

### INCLUDES ###
include("types.jl")
################



function run()
    output, triangle = prepare_arguments()
    rasterize!(output, triangle)
end # function run

function run_benchmark()
    output, triangle = prepare_arguments()
    @benchmark rasterize!($output, $triangle)
end # function run_benchmark

function prepare_arguments()
    t = Triangle([Vertex(20, 20, 0); Vertex(40, 10, 0); Vertex(50, 50, 0)])
    output = @MMatrix zeros(UInt32, 64, 64)
    return (output, t)
end # function prepare_arguments

function rasterize!(output::MMatrix{64, 64, UInt32}, t::Triangle)

    p1 = 0.0f0
    p2 = 0.0f0


    tv11 = t.vertices[1].x
    tv21 = t.vertices[1].y
    tv12 = t.vertices[2].x
    tv22 = t.vertices[2].y
    tv13 = t.vertices[3].x
    tv23 = t.vertices[3].y

    @inbounds for i in 1:size(output)[1]
        p1 += 1.0f0
        p2 = 0.0f0
        @inbounds for j in 1:size(output)[2]
            p2 += 1.0f0

            e = true

            e &= edge_fun(p1, p2, tv11, tv21, tv12, tv22)
            e &= edge_fun(p1, p2, tv12, tv22, tv13, tv23)
            e &= edge_fun(p1, p2, tv13, tv23, tv11, tv21)

            if e
                output[j, i] = 0xFFFFFFFF
            end
        end
    end
    output
end # function rasterize!

@inline function edge_fun(p1::Float32, p2::Float32, u1::Float32, u2::Float32, v1::Float32, v2::Float32)
    return (p1-u1)*(v2-u2)-(p2-u2)*(v1-u1) <= 0
end

end # module
