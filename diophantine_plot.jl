using Plots

function diophantine_m2(a::Int64, b::Int64)
    return a^2 + b^2
end

function main()

    plot()

    for j in 1:5
        xs = Vector{Int64}()
        for i in 1:100
            append!(xs,diophantine_m2(i,j))
        end
        plot!(1:100,xs, yaxis=:log)
        println(xs)
    end

    plot!()


end

main()
