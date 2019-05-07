using Pkg
Pkg.activate(".")

using Revise, Rasterize

Rasterize.run()

using Plots
heatmap(Rasterize.run(), bins=64*64)
