function main()
    
    io = open("argon.txt", "w");
    io_lp = open("argon_low_pressure.txt", "w");

    B1 = 20332.29e-8 
    B2 = 34458.31e-8 
    C1 = 206.12e-6*(1e-6)^2
    C2 = 8.066e-3*(1e-6)^2
    p0 = 1
    k0(λ) = 2π/λ
    a = 14.9e-6
    T = 273+20
    T0 = 273
    λ0 = 800e-9
    δ(λ) = T0 / T * (B1 * λ^2/(λ^2 - C1) + B2 * λ^2 / (λ^2 - C2))
    
    n(λ, p, u) = sqrt(1 + δ(λ)*p/p0 - (u / k0(λ) / a)^2 )
    
    λs = range(400e-9, 1000e-9, length=2000)

    e11 = 2.405 
    e12 = 5.52
    e13 = 8.6573
    e23 = 10.1735
    e33 = 11.6198
    e43 = 13.0152 


    for λ in λs
        p = 5.1
        p2 = 0.1
        res11 = (n(λ, p, e11) - n(λ/3, p, e11)) * 10^4
        res11_lp = (n(λ, p2, e11) - n(λ/3, p2, e11)) * 10^4
        res12 = (n(λ, p, e11) - n(λ/3, p, e12)) * 10^4
        res13 = (n(λ, p, e11) - n(λ/3, p, e13)) * 10^4
        res23 = (n(λ, p, e11) - n(λ/3, p, e23)) * 10^4
        res33 = (n(λ, p, e11) - n(λ/3, p, e33)) * 10^4
        res43 = (n(λ, p, e11) - n(λ/3, p, e43)) * 10^4
        write(io, "$(λ*10^9) \t $res11 \t $res12 \t $res13 \t $res23 \t $res33 \t $res43 \n")
        write(io_lp, "$(λ*10^9) \t $res11_lp\n")
    end
    close(io)
    close(io_lp)
end
main()
