using Learn
using Documenter

"""
    doctest_setup()

Importing modules and defining helper functions for doctest 
"""
function doctest_setup()
quote
    using Learn
    # Extract the string representation of the method of f having parameters p
    which_sig(f, p...) = repr(Base.which(f, map(typeof, p))) |> s->split(s," in ") |> first |> strip
end
end

DocMeta.setdocmeta!(Learn, :DocTestSetup, doctest_setup(); recursive=true)
