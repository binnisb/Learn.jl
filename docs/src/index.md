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

Create the GitHub reopository and push master to it.

One also needs to create the `gh-pages` branc on GitHub.

