{{BEANSCRIPT HEXADECIMAL C+++++SHA#\b

egin{theorem}4234234343423##################################################################
This quest
    

"It is impossible by any procedure, no matter how idealized, to reduce the temperature of any system to zero temperature in a finite number of finite operations". [8]
The reason that T = 0 can not be reached according to the third law is explained as follows: Suppose that the temperature of a substance can be reduced in an isentropic process by changing the parameter X from X2 to X1. One can think of a multistage nuclear demagnetization setup where a magnetic field is switched on and off in a controlled way. [9] If there were an entropy difference at absolute zero, T = 0 could be reached in a finite number of steps. However, at T = 0 there is no entropy difference so an infinite number of steps would be needed. The process is illustrated in Fig.1.
Geometric properties[edit]
A
d
S
n
\mathrm {AdS} _{n} metric with radius 
a\alpha is one of the maximal symmetric n-dimensional spacetimes. It has the following geometric properties:

Riemann curvature tensor:

R
µHow are the symmetries of gµ? reflected in those of Tµ??
up vote
4
down vote
favorite
2
For a homogeneous and the isotropic universe, the spacetime metric ds2 is given by the FRW form in comoving coordinates:
ds2=dt2-a2(t)[dr21-kr2+r2(d?2+sin2?d?2)].
It determines the LHS of the Einstein's field equation.

In Kolb and Turner's Cosmology book, it is said that to be compatible with the symmetries of the metric ds2, the stress-energy tensor Tµ? should be diagonal and by isotropy, the spatial components must be equal.

Questions

How can I see that the symmetries of gµ? must be present in that of Tµ?? It is not obvious to me.

How do the symmetries dictate that the tensor Tµ? is diagonal? All I know is that if a Cartesian tensor Tij is invariant under rotation it will satisfy
T'ij=RikTkl(R-1)lj=Tij
where R is the 3×3 rotation matrix.

general-relativity cosmology symmetry metric-tensor stress-energy-momentum-tensor
shareciteimprove this question
edited Mar 11 at 15:54

AccidentalFourierTransform
23.7k1364117
asked Mar 11 at 12:40

SRS
6,423429104
1
Recall that Tµ?~dSdgµ? – Avantgarde Mar 13 at 14:19
@Avantgarde Nice point. – SRS Mar 13 at 20:08 
add a comment
1 Answer
active oldest votes
up vote
2
down vote
By means of Einstein field equations Tµ? could be expressed through geometric quantities, namely the Einstein tensor, and so it must have the same symmetries as Einstein or Ricci tensor.

The FLRW metric possesses a large group of isometries which is one of SO(4), ISO(3) or SO(3,1) for the values of k=1,0,-1. The orbits of those groups are slices t=const. Under those symmetries R00 (and hence T00) must be a constant scalar, R0i (and T0i) must be an invariant 3-vector field and Rij (Tij) must be a invariant symmetric rank-2 3-tensor field.

There are no invariant 3-vector fields under isometries that include full SO(3) rotations (since rotating a nonzero vector around an axis that is not parallel to it would change it), so T0i=0. And the invariant symmetric tensor Tij must be proportional to the 3-metric (if it's not, than at a given point there is (at least) one eigenvector with eigenvalue different from the rest and so a SO(3) rotation which changes this eigenvector would also alters the tensor).

The structure of stress-energy tensor could be simplified further if we write it with one upper and one lower index (since Tij~dij):
Tµ?=diag(A,B,B,B),
where A and B could depend only on time t.

shareciteimprove this answer
?
a
ß
=
-
    

"It is impossible by any procedure, no matter how idealized, to reduce the temperature of any system to zero temperature in a finite number of finite operations". [8]
The reason that T = 0 can not be reached according to the third law is explained as follows: Suppose that the temperature of a substance can be reduced in an isentropic process by changing the parameter X from X2 to X1. One can think of a multistage nuclear demagnetization setup where a magnetic field is switched on and off in a controlled way. [9] If there were an entropy difference at absolute zero, T = 0 could be reached in a finite number of steps. However, at T = 0 there is no entropy difference so an infinite number of steps would be needed. The process is illustrated in Fig.1.
Geometric properties[edit]
A
d
S
n
\mathrm {AdS} _{n} metric with radius 
a\alpha is one of the maximal symmetric n-dimensional spacetimes. It has the following geometric properties:

Riemann curvature tensor:

R
µ
?
a
ß
=
- 
    

"It is impossible by any procedure, no matter how idealized, to reduce the temperature of any system to zero temperature in a finite number of finite operations". [8]
The reason that T = 0 can not be reached according to the third law is explained as follows: Suppose that the temperature of a substance can be reduced in an isentropic process by changing the parameter X from X2 to X1. One can think of a multistage nuclear demagnetization setup where a magnetic field is switched on and off in a controlled way. [9] If there were an entropy difference at absolute zero, T = 0 could be reached in a finite number of steps. However, at T = 0 there is no entropy difference so an infinite number of steps would be needed. The process is illustrated in Fig.1.
Geometric properties[edit]
A
d
S
n
\mathrm {AdS} _{n} metric with radius 
a\alpha is one of the maximal symmetric n-dimensional spacetimes. It has the following geometric properties:

Riemann curvature tensor:

R
µ
?
a
ß
=
-
    

"It is impossible by any procedure, no matter how idealized, to reduce the temperature of any system to zero temperature in a finite number of finite operations". [8]
The reason that T = 0 can not be reached according to the third law is explained as follows: Suppose that the temperature of a substance can be reduced in an isentropic process by changing the parameter X from X2 to X1. One can think of a multistage nuclear demagnetization setup where a magnetic field is switched on and off in a controlled way. [9] If there were an entropy difference at absolute zero, T = 0 could be reached in a finite number of steps. However, at T = 0 there is no entropy difference so an infinite number of steps would be needed. The process is illustrated in Fig.1.
Geometric properties[edit]
A
d
S
n
\mathrm {AdS} _{n} metric with radius 
a\alpha is one of the maximal symmetric n-dimensional spacetimes. It has the following geometric properties:

Riemann curvature tensor:

R
µ
?
a
ß
=
- 
    

"It is impossible by any procedure, no matter how idealized, to reduce the temperature of any system to zero temperature in a finite number of finite operations". [8]
The reason that T = 0 can not be reached according to the third law is explained as follows: Suppose that the temperature of a substance can be reduced in an isentropic process by changing the parameter X from X2 to X1. One can think of a multistage nuclear demagnetization setup where a magnetic field is switched on and off in a controlled way. [9] If there were an entropy difference at absolute zero, T = 0 could be reached in a finite number of steps. However, at T = 0 there is no entropy difference so an infinite number of steps would be needed. The process is illustrated in Fig.1.
Geometric properties[edit]
A
d
S
n
\mathrm {AdS} _{n} metric with radius 
a\alpha is one of the maximal symmetric n-dimensional spacetimes. It has the following geometric properties:

Riemann curvature tensor:

R
µ
?
a
ß
=
-      QED 2 [10] The Third Law states that Absolute 2 int main.  QED 2 [10] The Third Law states that Absolute 2 int main.  QED 2 [10] The Third Law states that Absolute 2 int main.  QED 2 [10] The Third Law states that Absolute 2 int main.  QED 2 [10] The Third Law states that Absolute 2 int main.





spin4$=token


$ java -versionjava version "1.8.0_45"
Java(TM) SE Runtime Environment (build 1.8.0_45-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.45-b02, mixed mode)
