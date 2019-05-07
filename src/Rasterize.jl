module Rasterize

export prepare_arguments, run, rasterize!

### IMPORTS  ###
using StaticArrays
################

### INCLUDES ###
include("types.jl")
################



function run()
    output, triangle = prepare_arguments()
    rasterize!(output, triangle)
end # function run

function prepare_arguments()
    t = Triangle([20 32 44; 20 20 44])
    output = @MMatrix zeros(UInt32, 64, 64)
    return (output, t)
end # function prepare_arguments

function rasterize!(output::MMatrix{64, 64, UInt32}, t::Triangle)
    for i in 1:size(output)[1]
        for j in 1:size(output)[2]

            e1 = edge_fun(t.vertices[:,1], t.vertices[:,2], [i j])
            e2 = edge_fun(t.vertices[:,2], t.vertices[:,3], [i j])
            e3 = edge_fun(t.vertices[:,3], t.vertices[:,1], [i j])

            if e1 == true && e2 == true && e3 == true
                output[j, i] = 0xFFFFFFFF
            end
        end
    end
    return output
end # function rasterize!

function edge_fun(a, b, c)
    return 0 >= ( (c[1] - a[1]) * (b[2] - a[2]) - (c[2] - a[2]) * (b[1] - a[1]))
end

end # module
