using JuliaLearn
using Documenter

makedocs(;
    modules=[JuliaLearn],
    authors="Brynjar Smári Bjarnason <binni@binnisb.com> and contributors",
    repo="https://github.com/binnisb/JuliaLearn.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaLearn.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://binnisb.github.io/JuliaLearn.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/binnisb/JuliaLearn.jl",
)
