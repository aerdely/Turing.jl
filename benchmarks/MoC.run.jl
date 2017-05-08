using Distributions
using Turing
using Stan

include(Pkg.dir("Turing")*"/benchmarks/benchmarkhelper.jl")
include(Pkg.dir("Turing")*"/example-models/stan-models/MoC-stan.data.jl")
include(Pkg.dir("Turing")*"/example-models/stan-models/MoC.model.jl")

bench_res = tbenchmark("HMCDA(1000, 0.65, 0.3)", "nbmodel", "data=nbstandata[1]")
bench_res[4].names = ["phi[1]", "phi[2]", "phi[3]", "phi[4]"]
logd = build_logd("Naive Bayes", bench_res...)

include(Pkg.dir("Turing")*"/benchmarks/"*"MoC-stan.run.jl")
logd["stan"] = stan_d
logd["time_stan"] = nb_time

print_log(logd)
