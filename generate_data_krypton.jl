function main()
    
    io = open("krypton.txt", "w");
    B1 = 26102.88e-8
    B2 = 56946.82e-8 
    λ1 = 14.36*10^(-9)
    λ2 = 89.81*10^(-9)
    C1 = 2.01e-6*(1e-6)^2
    C2 = 10.043e-3*(1e-6)^2

    p0 = 1
    k0(λ) = 2π/λ
    a = 14.9e-6
    T = 273+20
    T0 = 273
    λ0 = 800e-9
    δ(λ) = T0 / T * (B1 * λ^2/(λ^2 - C1) + B2 * λ^2 / (λ^2 - C2))
    n(λ, p, u) = sqrt(1 + δ(λ)*p/p0 - (u / k0(λ) / a)^2 )
    
    e11 = 2.405 
    e12 = 5.52
    e13 = 8.6573
    e23 = 10.1735
    e33 = 11.6198
    e43 = 13.0152 

    ps = range(0, 12, length=1000)

    for p in ps
        res13 = (n(λ0, p, e11) - n(λ0/3, p, e13)) * 10^4
        res23 = (n(λ0, p, e11) - n(λ0/3, p, e23)) * 10^4
        res33 = (n(λ0, p, e11) - n(λ0/3, p, e33)) * 10^4
        write(io, "$p \t $res13 \t $res23 \t $res33 \n")
    end
    close(io)
end
main()
