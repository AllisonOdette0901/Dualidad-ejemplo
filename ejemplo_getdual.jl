# Programa que recibe como parámetro un problema en
# formato canónico de maximización y regresa su solución óptima del dual

using JuMP, CPLEX

# primero un ejemplo

# Dado un problema en formato canónico de maximización:
c7 = [2;3;5];
b7 = [8;6];
A7 = [1 2 3; 1 -2 2];

model7 = Model(CPLEX.Optimizer)
m7 = size(A7,1) # número de renglones de A
n7 = size(A7,2) # columnas de A
@variable(model7,0 <= x7[1:n7]); # variables
@objective(model7,Max,sum(c7[j]*x7[j] for j in 1:n7)); #funcion objetivo (Maximizar)
@constraint(model7,constraint7[i=1:m7],sum(A7[i,j]*x7[j] for j = 1:n7) <= b7[i]); #restricciones
optimize!(model7)
# visualizando el modelo construido
print(model7)

# Parte dual
has_duals(model7) #verifica si hay variables duales
println("Optimal Solutions 7:")
for i=1:n7
  println("x[$i] = ", getvalue(x7[i]))
end

println("Dual Variables 7:")
# poner nombres a las restricciones
for j=1:m7
  println("dual[$j] = ", getdual(constraint7[j]))
end

# valor objetivo del modelo primal
getobjectivevalue(model7)


#--- Ahora si la función
