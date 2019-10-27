set
i "mine index" /mine1, mine2/,
j "type of copper grade" /highgrade,mediumgrade,lowgrade/;

Parameter
c(i)   "cost of production ($/tonne)"
/
mine1 22000,
mine2 18000
/,


d(j)   "minimum total quantity of copper required per grade type (tonne)"
/
highgrade 1000,
mediumgrade 400,
lowgrade    1500
/,

p(i)   "total production of copper per mine (tonne)"
/
mine1 1200
mine2 1200
/,

f      "total amount of sulfure that both mine cannot exceed (equal to 2.5%)" /2.5/
;

table s(i,j) "sulfur amount by mine by copper grade (percentage)"
$ondelim
$include indatasulfur.csv
$offdelim

table a(i,j) "production by mine by type of copper grade (tonne)"
$ondelim
$include indataproduction.csv
$offdelim

Positive Variables
x(i) "total number of operated hours per mines (hours)";

Variables X "Objective function value (hours)";

Equations
ObjFn "computed objective function value",
Plant_req "minimum amount of materials to be sent to the plant from both mine",
Sulfur_req "maximum sulfu allowed from each copper grade by each mine",
Nonnegativity_req " Hours of production of each mine cannot be negative"
;

ObjFn..   X =e= sum(i,(c(i)*x(i)));
Plant_req sum ((i,j), a(i,j)*x(i)) =g=
            d(j);
Sulfur_req.. sum ((i,j), a(i,j)*x(i)*s(i,j)) / sum (i, p(i)*x(i))=l=
            f;
Nonnegativity_req.. x(i) =g= 0 ;

Model workshop /all/;

solve workshop using lp minimizing X ;

parameter rep "reporting";

rep("hours") =  sum(i,c(i) * x.l(i));

display rep;

execute_unload "alldata.gdx";



