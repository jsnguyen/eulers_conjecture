using DataStructures
using Combinatorics
using Printf

function diophantine_m2(a::Int128, b::Int128, lookup::Array{Int128,1})
    return lookup[a]+lookup[b]
end

function main()
    r = 2
    n = 10000
    
    println("Generating lookup table...")
    exp_lookup = Array{Int128,1}(undef,n)
    for i in 1:n
        exp_lookup[i] = convert(Int128,i)^4
    end

    println("Generating tuple array...")
    tuple_arr = Vector{Vector{Int128}}()
    for el in combinations(1:n,r)
        conv = convert(Vector{Int128},el)
        push!(tuple_arr,conv)
    end

    for i in 1:n
        extra = Vector{Int128}([i,i])
        push!(tuple_arr,extra)
    end

    println("Beginning search...")
    sum_lookup = Dict{Int128, Vector{Int128}}()
    tree = AVLTree{Int128}()
    for el in tuple_arr
        sum = diophantine_m2(el[1], el[2], exp_lookup)

        if haskey(tree, sum)
            delete!(tree,sum)
            stored_tuple = sum_lookup[sum]
            str = @sprintf "%i %i %i %i %i\n" stored_tuple[1] stored_tuple[2] el[1] el[2] sum
            println("Found! ", stored_tuple[1], "^4 + ", stored_tuple[2], "^4 = ", el[1], "^4 + ", el[2], "^4 = " , sum)
            open("results_422.txt", "a") do f
                write(f,str)
            end
        else
            push!(tree,sum)
            sum_lookup[sum] = el
        end

    end

end

main()
