using Learn
using Documenter

"""
    doctest_setup()

Importing modules and defining helper functions for doctest 
"""
function doctest_setup()
quote
    using Learn
    which_sig(f, x, y) = repr(Base.which(f, (typeof(x), typeof(y)))) |> s->split(s," in ") |> first |> strip
end
end

DocMeta.setdocmeta!(Learn, :DocTestSetup, doctest_setup(); recursive=true)
