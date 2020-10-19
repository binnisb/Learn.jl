using Learn
using Documenter

DocMeta.setdocmeta!(Learn, :DocTestSetup, :(using Learn; which_sig(f, x, y) = repr(Base.which(f, (typeof(x), typeof(y)))) |> s->split(s," in ") |> first |> strip); recursive=true)
