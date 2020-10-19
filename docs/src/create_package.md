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
        GitHubActions(; x86=false),
        Codecov(),
        Documenter{GitHubActions}(),
        Develop(),
        Citation(;readme=true)
    ],
)
t("Learn")
```

Create the GitHub reopository `Learn.jl` and push master to it.

To be able to push the docs to GitHub pages, I needed to follow [DocumenterTools.genkeys](https://juliadocs.github.io/Documenter.jl/stable/lib/public/#DocumenterTools.genkeys) and create the deploy key and `DOCUMENTER_KEY` secret.

To run DocTests within `src/*.jl` files you need to add a line to [docs/make.jl]:

```julia
DocMeta.setdocmeta!(Learn, :DocTestSetup, :(using Learn); recursive=true)
```

which makes the Learn module available in all Docstrings in the julia files. If you create submodules, that might need some extra manipulations to get that working.

I also chaged the `.github/workflows/ci.yml` to call a file `make_doctest.jl` for running the tests, and then calling `make.jl` to build the docs and deploy. I refactored out the library calls and setup needed for both.

Then from terminal:

```bash
# From the Learn.jl folder
julia --project=docs  docs/make_doctest.jl  # Runs the Doctests
julia --project=docs  docs/make.jl  # Builds documents and runs the Doctests
julia --project=.  test/runtests.jl  # Runs the test suite for Learn
```
