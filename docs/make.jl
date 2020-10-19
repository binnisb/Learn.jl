include("make_structure.jl")
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
        "Library" => [
            "Index" => "library/all_index.md"
        ],
        "Create Package" => "create_package.md"
    ],
)

deploydocs(;
    repo="github.com/binnisb/Learn.jl",
)
