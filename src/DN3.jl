module DN3

export nihalo, veckratno_nihalo,veckratno_harmonicno_nihalo,nihajni_cas

"""
    odmik = nihalo(l,t,theta0,dtheta0,n)

Računanje kotnega odmika matematičnega nihala dolžine l ob času t pri začetnem odmiku theta0 in začetno kotno hitrosto dtheta0 s pomočjo metode Runge-Kutta 4. stopnje.
"""
function nihalo(l, t, theta0, dtheta0, n)
    g = 9.80665 
    h = t/n
    y = [theta0, dtheta0]

    function f(t,th)
        return [th, -(g / l) * sin(t)]
    end

    for _ in 1:n
        yn = rk4(y[1],y[2], h, f)
        y += yn
    end

    return y[1]
end

"""
    odmiki,hitrosti = veckratno_nihalo(l,t,theta0,dtheta0,n)

Računanje kotnih odmikov in hitrosti matematičnega nihala dolžine l od časa 0 do t pri začetnem odmiku theta0 in začetno kotno hitrosto dtheta0 s pomočjo metode Runge-Kutta 4. stopnje.
"""
function veckratno_nihalo(l, t, theta0, dtheta0, n)
    g = 9.80665 
    h = t/n
    dy = [theta0]
    dty = [dtheta0]
    function f(t,th)
        return [th, -(g / l) * sin(t)]
    end

    for i in 1:n
        yn = rk4(dy[i],dty[i], h, f)
        push!(dy,yn[1] + dy[i])
        push!(dty,yn[2] + dty[i])
    end

    return (dy,dty)
end

"""
    odmiki,hitrosti = veckratno_harmonicno_nihalo(l,t,theta0,dtheta0,n)

Računanje kotnih odmikov in hitrosti harmoničnega nihala dolžine l od časa 0 do t pri začetnem odmiku theta0 in začetno kotno hitrosto dtheta0 s pomočjo metode Runge-Kutta 4. stopnje.
"""
function veckratno_harmonicno_nihalo(l, t, theta0, dtheta0, n)
    g = 9.80665 
    h = t/n
    dy = [theta0]
    dty = [dtheta0]
    function f(t,th)
        return [th, -(g / l) * t]
    end

    for i in 1:n
        yn = rk4(dy[i],dty[i], h, f)
        push!(dy,yn[1] + dy[i])
        push!(dty,yn[2] + dty[i])
    end

    return (dy,dty)
end

"""
    rk4(y, h, f)

Runge-Kutta 4. stopnje za reševanje sistema diferencialnih enačb.
"""
function rk4(t,th, h, f)
    k1 = h * f(t, th)
    k2 = h * f(t + k1[1] / 2, th + k1[2] / 2)
    k3 = h * f(t + k2[1] / 2, th + k2[2] / 2)
    k4 = h * f(t + k3[1], th + k3[2])
    tn = (k1 + 2 * k2 + 2 * k3 + k4) / 6
    return [tn[1],tn[2]]
end

"""
    cas = nihajni_cas(l,t,theta0,dtheta0,n)
Izračunaj nihajni čas na podlagi vektorja odmikov in časov.
"""
function nihajni_cas(l, t, theta0, dtheta0, n)
    g = 9.80665 
    h = t/n
    y = [theta0, dtheta0]
    prvic_mimo = false
    cas = 0
    function f(t,th)
        return [th, -(g / l) * sin(t)]
    end

    for time in 1:n
        yn = rk4(y[1],y[2], h, f)
        y += yn
        if theta0 > y[1] && prvic_mimo == false
            prvic_mimo = true
        end
        if theta0 < y[1] && prvic_mimo
            cas = time
            break
        end
    end

    return cas * (t/10000)
end


end # module DN3
