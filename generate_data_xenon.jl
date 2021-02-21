function main()
    
    io = open("xenon.txt", "w");
    io_p = open("xenon_pressure.txt", "w");

    B1 = 103701.61e-8
    B2 = 31228.61e-8 
    C1 = 12.75e-3*(1e-6)^2
    C2 = 0.561e-3*(1e-6)^2

    p0 = 1
    k0(λ) = 2π/λ
    a = 14.9e-6
    T = 293
    T0 = 273
    λ0 = 800e-9
    function δ(λ, T=T)
        return T0 / T * (B1 * λ^2/(λ^2 - C1) + B2 * λ^2 / (λ^2 - C2))
    end

    function n(λ, p, u, T=T)
        return sqrt(1 + δ(λ, T)*p/p0 - (u / k0(λ) / a)^2 )
    end

    e11 = 2.405 
    e12 = 5.52
    e13 = 8.6573
    e23 = 10.1735
    e33 = 11.6198
    e43 = 13.0152 

    ps = range(0, 4, length=1000)
    λs = range(400e-9, 1000e-9, length=1000)

    for p in ps
        res13 = (n(λ0, p, e11) - n(λ0/3, p, e13)) * 10^4
        res23 = (n(λ0, p, e11) - n(λ0/3, p, e23)) * 10^4
        res33 = (n(λ0, p, e11) - n(λ0/3, p, e33)) * 10^4
        write(io_p, "$p \t $res13 \t $res23 \t $res33 \n")
    end

    p = 0.96
    for x in λs
        i = x * 10^9
        res11 = (n(x, p, e11) - n(x/3, p, e11)) * 10^4
        res12 = (n(x, p, e11) - n(x/3, p, e12)) * 10^4
        res13 = (n(x, p, e11) - n(x/3, p, e13)) * 10^4
        res23 = (n(x, p, e11) - n(x/3, p, e23)) * 10^4
        res33 = (n(x, p, e11) - n(x/3, p, e33)) * 10^4
        write(io, "$i \t $res11 \t $res12 \t $res13 \t $res23 \t $res33 \n")
    end


    close(io)
    close(io_p)
end
main()
