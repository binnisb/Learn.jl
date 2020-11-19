using Dates, Learn, BusinessDays

struct HolidaysParsed
    weekday::String
    date::Date
    name::String
    swedishname::String
    holidaytype::String
    comments::String
end
# HolidaysParsed(weekday, date, name, swedishname, holidaytype, comments) = begin
#     date = Date(date.children[1].attributes["datetime"])
#     HolidaysParsed(nodeText(weekday), date, nodeText(name), nodeText(swedishname), nodeText(holidaytype), nodeText(comments))
# end

# How I got the testcases for sweden

# using HTTP, Gumbo, Cascadia
# HolidaysParsed(weekday, date, name, swedishname, holidaytype, comments) = begin
#     date = Date(date.children[1].attributes["datetime"])
#     HolidaysParsed(nodeText(weekday), date, nodeText(name), nodeText(swedishname), nodeText(holidaytype), nodeText(comments))
# end

# function fetch_holidays(yr::Year)
#     url = "https://www.officeholidays.com/countries/sweden/$(yr.value)"
#     r = HTTP.get(url; require_ssl_verification=false)
#     page = parsehtml(String(r.body))
#     rows = eachmatch(sel".country-table tr", page.root)[2:end]

#     holidays = [HolidaysParsed(eachmatch(sel"td", row)...) for row in rows]
#     [h for h in holidays if h.holidaytype == "National Holiday"]
# end

# hs = [((fetch_holidays(Year(yr)) for yr in 2015:2022)...)...]

# open(joinpath(@__DIR__,"./testSwedishHolidays.txt"), "w") do io
#     for h in hs
#         println(io, "$(h.weekday),$(h.date),$(h.name),$(h.swedishname),$(h.holidaytype),$(h.comments)")
#     end
# end

HolidaysParsed(weekday, date, name, swedishname, holidaytype, comments) = begin
    date = Date(date)
    HolidaysParsed(String(weekday), date, String(name), String(swedishname), String(holidaytype), String(comments))
end

hs = open(joinpath(@__DIR__,"./testSwedishHolidays.txt")) do io
    readlines(io) .|> x -> split(x,",") |> x->HolidaysParsed(x...)
end

holidays = Dict(h.date=>h for h in hs)

@testset "SwedishHolidays" begin
    for d ∈ Date(2015,1,1):Day(1):Date(2022,12,31)
        @test BusinessDays.isweekend(d) || ((d ∉ holidays.keys) == isbday(SwedenCalendar(),d))
    end
end