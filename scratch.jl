using Pkg
Pkg.activate(".")

using Revise, Rasterize

Rasterize.run()

Rasterize.run_benchmark()

using Plots
heatmap(Rasterize.run(), bins=64*64)
