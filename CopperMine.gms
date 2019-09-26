set
i "mine index",
j "type of copper grade";

Parameter
c(i)   "cost of production ($/tonne)" ,
d(j)   "minimum total quantity of copper required per grade type (tonne)",
a(i,j) "production by mine by type of copper grade (tonne)",
s(i,j) "sulfur amount by mine by copper grade (percentage)",
p(i)   "total production of copper per mine (tonne)",
f      "total amount of sulfure that both mine cannot exceed (equal to 2.5%)" /2.5/
;

Positive Variables
x(i) "total number of operated hours per mines (hours)";

Variables X "Objective function value (hours)";

