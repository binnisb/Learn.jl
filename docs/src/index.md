```@meta
CurrentModule = JuliaLearn
```

# JuliaLearn

```@index
```

```@autodocs
Modules = [JuliaLearn]
```


# Create new package
First add PkgTemplates
```julia
(@v1.5) pkg> add PkgTemplates
```
Then use the following template
```julia
using PkgTemplates
t = Template(; 
    user="binnisb",
    julia=v"1.5",
    plugins=[
        Git(; manifest=true, ssh=true, jl=true),
        Tests(;project=true),
        GitHubActions(; x86=true),
        Codecov(),
        Documenter{GitHubActions}(),
        Develop(),
        Citation(;readme=true)
    ],
)
t("JuliaLearn")
```

Create the GitHub reopository `JuliaLearn.jl` and push master to it.

To be able to push the docs to GitHub pages, I needed to follow [DocumenterTools.genkeys](https://juliadocs.github.io/Documenter.jl/stable/lib/public/#DocumenterTools.genkeys) and create the deploy key and `DOCUMENTER_KEY` secret.
