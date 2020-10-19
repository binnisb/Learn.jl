using Learn
using Documenter

DocMeta.setdocmeta!(Learn, :DocTestSetup, :(using Learn); recursive=true)

makedocs(;
    modules=[Learn],
    authors="Brynjar Smári Bjarnason <binni@binnisb.com> and contributors",
    repo="https://github.com/binnisb/Learn.jl/blob/{commit}{path}#L{line}",
    sitename="Learn.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://binnisb.github.io/Learn.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/binnisb/Learn.jl",
)
