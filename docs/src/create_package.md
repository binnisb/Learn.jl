# Create new package

## Creat from template
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
        Git(;manifest=true, ssh=true, jl=true),
        Tests(;project=true),
        GitHubActions(;x86=false),
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

## Tests, Documenter and doctests

The template above creates a GitHub Action to build the docs, and run `doctest`. Out of the box it actually couldn't run doctest with tests defined in doc strings in source files.

How I solved it:

First I created a `docs/make_structure.jl` which imports and setup what is needed for `Documenter` and `doctest`, and then two files `docs/make_docstring.jl` and `docs/make.jl`, where the former only runs doctest, and the latter runs doctest and builds and deploys the docs.

Both cases need some setup code, which lives in `make_structure.jl` and makes the `Learn` module available in all docstrings in the `Learn` module. If you create submodules, that might need some extra manipulations to get that working.

I also chaged the `.github/workflows/ci.yml` to call a file `make_doctest.jl` for running the tests, and then calling `make.jl` to build the docs and deploy.

Then from terminal:

```bash
# From the Learn.jl folder
julia --project=docs  docs/make_doctest.jl  # Runs the Doctests
julia --project=docs  docs/make.jl  # Builds documents and runs the Doctests
julia --project=.  test/runtests.jl  # Runs the test suite for Learn
```
should work.