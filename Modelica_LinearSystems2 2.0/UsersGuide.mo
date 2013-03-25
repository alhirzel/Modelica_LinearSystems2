within Modelica_LinearSystems2;
package UsersGuide "Users Guide"

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <b>Modelica_LinearSystems2</b> is a Modelica package
providing different representations of linear, time invariant differential and
difference equation systems, as well as typical operations on these
system descriptions. Additionally, data structures and operations for
Complex numbers and for Polynomials are provided. These are utilized
above, but are, of course, also useful for other purposes.
</p>

<p>
This package contains the <b>users guide</b> for
the library and has the following content:
</p>
<ol>
<li><a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.GettingStarted\">Getting started</a>
    contains an introduction to the most important features and how
    to use them at hand of examples.</li>
<li><a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.Literature\">Literature</a>
    provides references that have been used to design and implement this
    library.</li>
<li><a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the differences between different versions of this library.</li>
<li><a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.ModelicaLicense2\">Modelica License 2</a>
    is the legal license text und which this library is submitted.</li>
<li><a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.Requirements\">Requirements</a>
    scetches the requirements on a Modelica tool, in order that this library
    can be utilized.</li>
<li><a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.Contact\">Contact</a>
    provides information about the author of the library as well as
    acknowledgments.</li>
</ol>


</html>"));
  class GettingStarted "Getting started"

    annotation (Documentation(info="<html>
<p>
In this section, a first introduction to the Modelica_LinearSystems2
library is given at hand of several examples.
The library consists of four main parts that
are described in the following sections:
</p>
<ol>
<li> Section <a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.GettingStarted.ComplexNumbers\">Complex numbers</a>
     introduces the Modelica_LinearSystems2.Math.Complex record that provides a
     data struture for Complex numbers and arrays and also the most
     important (scalar) operations on them. Read this section first,
     because the structuring of records as well as operator overloading
     is explained that is also the basis for the other parts of the
     library.</li>

<li> Section <a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.GettingStarted.Polynomials\">Polynomials</a>
     describes the Modelica_LinearSystems2.Math.Polynomials record that
     provides a data structure for Polynomials with real coefficients
     and operations such as evaluation, fitting, integration.
     The Complex and Polynomial data structures are basic
     building blocks for the other parts of the library.</li>

<li> <a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.GettingStarted.LinearSystemDataStructures\">Linear system data structures</a>
     are records on the top level of Modelica_LinearSystems2 that define
     data structures for different representations of
     linear, time invariant, continuous and discrete systems,
     e.g., record StateSpace. Furthermore, operations are provided
     on these data structures, e.g., to connect linear systems together
     or plot a frequency response.</li>

</ol>

</html>
"));

    class ComplexNumbers "Complex numbers"

      annotation (Documentation(info="<html>
<p>
<b>Complex</b> numbers are defined via record Modelica_LinearSystems2.Math.Complex.
Basically, the record consists of the real and imaginary part of a
complex number and functions stored in the record that operate
on Complex numbers. A screenshot of the record and its content
is given in the next figure:
</p>

<blockquote>
<img src=\"../Extras/Images/UsersGuide/Complex.png\">
</blockquote>
<p>
Switch to an interactive Modelica environment
(e.g., Dymola command window)
and type in the following commands:
</p>

<pre>
   import Modelica_LinearSystems2.Math.Complex;
</pre>

<p>
This import statement defines a convenient abbreviation, so that
in the following, we have only to type \"Complex\" and no longer
\"Modelica_LinearSystems2.Complex\".<br>
Since the Modelica language has been extended to support the concept of operator overloading,
the definition of record Complex allows to write the following commands:
</p>
<pre>
  import Modelica_LinearSystems2.Math.Complex;

  j  = Complex.j();
  c1 = 1 + 3*j;
  c2 = 1 - 5*j;
  c3 = c1 + c2;

</pre>
<p>
The original generation of complex numbers by using the record-constructor and calling operation functions is still possible and described at <a href=\"Modelica://Modelica_LinearSystems2.UsersGuide.GettingStarted.ComplexNumbers.FunctionsAndOperators\">Functions and operators</a>
</p>
The overloading concept also includes the build in function 'String', i.e. typing
</p>
<pre>
  import Modelica_LinearSystems2.Math.Complex;

  j  = Complex.j();
  c1 = 1 + 3*j;
  Modelica.Utilities.Streams.print(\"c1 = \"+String(c1));

</pre>
results in
<p><pre>
  c1 = 1 + 3j
</pre></p>


<p>
Besides the basic operations, the most important specific
functions for Complex numbers are also available, e.g.,
exp(), sin() or conj() to compute
<pre>

  exp(z)  = exp(Re(z)*(cos(Im(z)) + j sin(Im(z)))
  sin(z)  = 1/(2j)*(exp(zj) - exp(-zj))
  conj(z) = Re(z) - jIm(z)

</pre>
respectively.
</p>
Function arg() returns the phase angle of the Complex number.
The phase angle is not unique. Via the optional second argument phi0,
the desired range can be defined, such that
</p>

<pre>

  -pi &lt; arg(c,phi0) - phi0 &lt; pi.

</pre>

<p>
For example:
</p>

<pre>

  Complex.arg( 1+j*0.5, 4*pi );  // = 4*pi+pi/4 = 13.351...

</pre>

Note that the operators 'abs'(), 'sqrt'(), and 'max'() in this version of Modelica_LinearSystems2 are not supported by the overloading operator concept yet. Therefore, the original way of function calling, e.g.
<pre>

  a = Complex.'abs'(3 + j*4)

</pre>
has to be applied.

</html>
"));
      class FunctionsAndOperators "Functions and operators"
        annotation (Documentation(info="<html>
<p>
The definition of a <b>Complex</b> number represented by the record Modelica_LinearSystems2.Math.Complex was originally defined by calling constructor function
\"Complex.constructor()\". Constructor function calls can
be abbreviated by \"ThisRecord()\", i.e., \"constructor()\" need not
to be given. Hence, in the case of <b>Complex</b> a complex number, e.g. c = 1 + 2j would be generated by
<pre>
  c = Complex(1, 2)

</pre>
wheras the constructor-funtion is simply defined by
<p><pre>
  function constructor
  \"Default constructor for a complex number\"
    import Modelica_LinearSystems2.Math.Complex;
    input Real re \"Real part of complex number\";
    input Real im=0 \"Imaginary part of complex number\";
    output Complex result \"Complex number\";
  algorithm
    result.re :=re;
    result.im :=im;
  end constructor;
</pre></p>
</p>
<p>
In a similar manner the mathematical operations on complex numbers were defined by operator functions. Addition of two complex numbers for example was defined by a function
<p><pre>
  function '+' \"Add two complex numbers\"
    import Modelica_LinearSystems2.Math.Complex;

      input Complex c1 \"Complex number 1\";
      input Complex c2 \"Complex number 2\";
      output Complex c3 \"= c1 + c2\";

  algorithm
    c3 := Complex(c1.re + c2.re, c1.im + c2.im);
end '+';

</pre></p>
and applicated by a function call
<p><pre>
   c3 := Complex.'+'(c1,c2)
</pre></p>
<p>
Although, the underlying principle is intelligibly it results in a very inconvenient way for the usage of complex numbers.<br>
Since support of operation overloading has been enabled in the Modelica language, the procedures described above are still the base of the mathematical operations but can be used in a much more convenient way.
The principle is that if there is an operation \"c1 + c2\" for which
the operation '+' is not defined, it will be determined whether
\"c1\" is a record type and, if it is, if it contains a
function '+'. If applicable, this function call then
replaces the above operation, i.e,. \"c1 + c2\" is interpreted
as Complex.'+'(c1,c2). In other words, an operation like c3 = c1 + c2 can now be realized by
<p><pre>
 import Modelica_LinearSystems2.Math.Complex;

  j  = Complex.j();    // same as Complex(0,1);
  c1 = 1 + 3*j;        // = Complex.'+'(Complex(1),Complex.'*'(Complex3,j));
  c2 = 1 - 5*j;
  c3 = c1 + c2;
</pre></p>
and
 Modelica.Utilities.Streams.print(\"c3 = \"+String(c3));

</pre>
results in
<p><pre>
  c1 = 2 - 2j
</pre></p>
</p>
<p>
A necessary extension to the Modelica language to realize overloading operators for constructors, conversions, and operations has been the introduction
of the \"operator\" keyword, i.e.
<p><pre>
  operator 'constructor'
    function fromReal
      input Real re;
      output Complex result = Complex(re=re, im=0.0);
      annotation(Inline=true);
    end fromReal;
  end'constructor';
</pre></p>
and
<p><pre>
  operator function '+'
    input Complex c1;
    input Complex c2;
    output Complex result \"= c1 + c2\";
    annotation(Inline=true);
    algorithm
      result := Complex(c1.re + c2.re, c1.im + c2.im);
  end '+';
</pre></p>
<p>
For details see
<a href=\"http://www.modelica.org/documents/ModelicaSpec31.pdf\">Modelica Language Specification version 3.1</a> (chapter 14) from June 2009.
</p>
</p>

</html>
"));
      end FunctionsAndOperators;
    end ComplexNumbers;

    class Polynomials "Polynomials"

      annotation (Documentation(info="<html>
<p>Polynomials with real coefficients are defined via record Modelica_LinearSystems2.Math.Polynomial. Read first the previous section about Complex numbers to understand how records, functions in records and the coming operator overloading technique works. The Polynomial record is equivalent to the Complex record. A screenshot is shown in the next figure: </p>
<blockquote>
   <p><img src=\"../Extras/Images/UsersGuide/Polynomial1.png\"/> </p>
</blockquote>
<p>A Polynomial is constructed by the command Polynomial(coefficientVector), where the input argument provides the polynomial coefficients in descending order. In the following figure, a typical session in the command window is shown (try it, e.g., in Dymolas command window): </p>
<blockquote>
   <p><img src=\"../Extras/Images/UsersGuide/Polynomial2.png\"/> </p>
</blockquote>
<p>After defining the import statement to get Polynomial as an abbreviation for Modelica_LinearSystems2.Polynomial, the coefficients are given as vector input to \"Polynomial()\". Via the operator-'String' function (called by String(p)) Polynomial p is pretty printed. Besides all elementary operations, such as operator '+', '*', functions to compute the integral or the derivative are provide. With function \"evaluate(..)\" the Polynomial is evaluated for a given value x. With function \"roots\", the roots of the Polynomial are evaluated and are returned as a Vector of Complex numbers. If the optional second input agument printRoots is set to true, the roots are at once also nicely printed. </p>
<p>With function \"fitting\", a polynomial can be determined that approximates given table values. Finally with function \"plot\", the interesting range of x is automatically determined (via calculating the roots of the polynomial and of its derivative) and plotted. A typical plot is shown in the next figure: </p>
<blockquote>
   <p><img src=\"../Extras/Images/UsersGuide/Polynomial3.png\"/> </p>
</blockquote>
<p>Several other examples of Polynomial are available in Polynomial.Examples. In Dymola, select the function with the right mouse button and click \"Ok\" on the resulting menu which provides the possibility to define all the input arguments. Since the Examples function do not have any input arguments, only the \"Ok\" button is present: </p>
<blockquote>
   <p><img src=\"../Extras/Images/UsersGuide/Polynomial4.png\"/> </p>
</blockquote>
</html>"));
    end Polynomials;

    class LinearSystemDataStructures "Linear system data structures"

      annotation (Documentation(info="<html>
<p>
At the top level of the Modelica_LinearSystems2 library,
data structures are provided as Modelica
records defining different representations of
linear, time invariant differential and difference
equation systems. In the record definitions,
functions are provided that operate on the
corresponding data structure. Currently, the following
linear system representations are available:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td>record&nbsp;<a href=\"Modelica://Modelica_LinearSystems2.StateSpace\">StateSpace</a></td>
      <td>Multi input, multi output, linear differential equation systems in state space form:
<pre>    <b>der</b>(<b>x</b>) = <b>A</b> * <b>x</b> + <b>B</b> * <b>u</b>
        <b>y</b>  = <b>C</b> * <b>x</b> + <b>D</b> * <b>u</b>

</pre>
      </td>
  </tr>
  <tr><td>record&nbsp;<a href=\"Modelica://Modelica_Control.LinearSystems.TransferFunction\">TransferFunction</a></td>
      <td>Single input, single output, transfer functions defined via a numerator
          and a denominator polynomial n(s) and d(s) respectively:
<pre>        n(s)                                2*s+3
   y = ------ * u,  for example:   y = ----------------- * u
        d(s)                            4*s^2 + 5*s + 6

</pre>
      </td>
  </tr>
  <tr><td>record&nbsp;<a href=\"Modelica://Modelica_LinearSystems2.ZerosAndPoles\">ZerosAndPoles</a></td>
      <td> Single input, single output, transfer function defined via the products of
           its zeros z and poles p, respectively;
<pre>
         product(s - z[i])
  y = k*------------------- * u
         product(s - p[i])
</pre>

A description with zeros and poles is problematic: For example,
a small change in the imaginary part of a conjugate complex pole pair,
leads no longer to a transfer function with real coefficients.
If the same zero or pole is present twice or more, then a diagonal state space
form is no longer possible. This means that the structure is
very sensitive if zeros or poles are close together.
For this and other reasons, internally, this data structure
stores the zeros and poles as first and second order
polynomials with real coefficients:
<pre>         product(s+n1[i]) * product(s^2+n2[i,1]*s+n2[i,2])
  y = k*---------------------------------------------------
         product(s+d1[i]) * product(s^2+d2[i,1]*s+d2[i,2])

</pre></td>
  </tr>
  <tr><td>record&nbsp;<a href=\"Modelica://Modelica_Control.LinearSystems.DiscreteStateSpace\">DiscreteStateSpace</a></td>
      <td> Multi input, multi output, linear difference equation system
          in state space form:
<pre>     <b>x</b>(Ts*(k+1)) = <b>A</b> * <b>x</b>(Ts*k) + <b>B</b> * <b>u</b>(Ts*k)
     <b>y</b>(Ts*k)     = <b>C</b> * <b>x</b>(Ts*k) + <b>D</b> * <b>u</b>(Ts*k)
     <b>x</b>_continuous(Ts*k) = <b>x</b>(Ts*k) + <b>B2</b> * <b>u</b>(Ts*k)
</pre>
with <b>Ts</b> the sample time and <b>k</b>
the index of the actual sample instance (k=0,1,2,3,...).
<b>x</b>(t) is the discrete state vector and <b>x</b>_continuous(t)
is the state vector of the continuous system from which the
discrete block has been derived by a state transformation,
in order to remove dependencies of past values of <b>u</b>.</td>
  </tr>
</table>

<p>
It is planned to add linear system descriptions such as
DiscreteTransferFunction,
DiscreteFactorized, FrequencyResponse, and DiscreteFrequencyResponse,
in the future. Furthermore, several useful functions are not yet
available in the records above. They will also be added in the future.
</p>

<p>
Below, a typical session in the command window is shown:
</p>

<blockquote>
<img src=\"../Extras/Images/UsersGuide/TransferFunction1.png\">
</blockquote>

<p>
The last command (plotBode) results in the following frequency response:
</p>

<blockquote>
<img src=\"../Extras/Images/UsersGuide/TransferFunction2.png\">
</blockquote>

<p>
Note, the interesting frequency range is automatically determined
(it can be fairly good deduced from the phase information of
poles and zeros).
</p>

<p>
Transfer function tf3 can be transformed into a state
space description with command
ss=StateSpace(tf3) and an poles-and-zeros plot and print out is then available via StateSpace.Plot.polesAndZeros(ss)
</p>

<blockquote>
<img src=\"../Extras/Images/UsersGuide/TransferFunction4.png\">
</blockquote>

<p>
resulting in:
</p>

<blockquote>
<img src=\"../Extras/Images/UsersGuide/TransferFunction3.png\">
</blockquote>

<p>
It is also possible to linearize any Modelica model at
the start time (after initialization has been performed).
This is especially useful if the model is initialized in
steady state. For example, the command
StateSpace.Import.fromModel(\"xxx\") results in:
</p>

<blockquote>
<img src=\"../Extras/Images/UsersGuide/TransferFunction5.png\">
</blockquote>

<p>
Also several
<a href=\"Modelica://Modelica_LinearSystems2.ZerosAndPoles.Design.filter\">filters</a>
are provided in. Typical frequency responses
are shown in the next figure:
</p>

<blockquote>
<img src=\"../Extras/Images/LowPassOrder4Filters.png\">
</blockquote>

<p>
The step responses of the same low pass filters are shown in the next figure,
starting from a steady state initial filter with initial input = 0.2:
</p>

<blockquote>
<img src=\"../Extras/Images/LowPassOrder4FiltersStepResponse.png\">
</blockquote>

</html>
"));
    end LinearSystemDataStructures;

  end GettingStarted;

  class Literature "Literature"

    annotation (Documentation(info="<html>
<p>
This library is based on the following references:
</p>
<dl>
<dt>Astr&ouml;m K.J., Wittenmark B. (1997):</dt>
<dd> <b>Computer Controlled Systems: Theory and Design</b>.
     Prentice Hall. 3rd edition.<br>&nbsp;</dd>

<dt>Datta B. N. (2004):</dt>
<dd> <b>Numerical Methods for linear control systems</b>.
     Elsevier Academic Press<br>&nbsp;</dd>

<dt>Goloub G.H., Van Loan C.F. (1996):</dt>
<dd> <b>Matrix Computations</b>.
     Johns Hopkins University Press 3rd edition.<br>&nbsp;</dd>

<dt>Tietze U., and Schenk C. (2002):</dt>
<dd> <b>Halbleiter-Schaltungstechnik</b>.
     Springer Verlag, 12. Auflage, S. 815-852.<br>&nbsp;</dd>
</dl>


</html>
"));
  end Literature;

  package ReleaseNotes "Release notes"
    class Version_2_0 "Version 2.0 (September 2, 2009)"

      annotation (Documentation(info="<html>
<p>
This is a new library. It is based on library Modelica_LinearSystems2 (version 0.95)
but is not backwards compatible to this library due to many changes (e.g. the system
data structures include strings for signals names whereas the 0.95 version does not
have these names in the records). Most important improvements with respect to version 0.95:
</p>

<ul>
<li> The library has been extended and contains now about 180 functions and a lot of examples for the analysis and design of linear control systems in different description forms.</li>
<li> The library has been restructured and the functions are now organized in sub packages.</li>
<li>  Documentation has been upgraded and improved.</li>
<li>  Operator overloading concept has been fully utilized.</li>
<li>  Analysis functions like tests for controllability, observability, stabilizability, and detectability have been added.</li>
<li>      The analyse-function to determine the characteristic of a system and to analyse the relation of the system states to the dynamics of the uncoupled modal states is provided.</li>
<li>      Calculation of invariant zeros for arbitrary systems (i.e. systems with different numbers of inputs and outputs) is now provided.</li>
<li>      The Design package contains functions for controller design, i.e. pole assignment, LQ controller, Kalman Filter, and LQG controller.</li>
<li>      Since the design of optimal controllers is based on the solution of algebraic Riccati equation, a solver for those equations is provided in Math.Matrices. Also an algorithm to solve Lyapunov equations has been added.</li>
<li>      The package Sampled was renamed to Controller. All blocks are now available in a discrete representation,
          especially also the \"Filter\" block (was only available in a continuous representation in 0.95)</li>
<li>      The Controller package contains a sub package Template which provides standard controller structures (e.g. a state-feedback-control-structure and a two degree of freedom controller template with an inverse system model in the feed forward loop) with replaceable components.</li>
<li>      The besselFilter coefficients have been recalculated with high precision calculation up to order 41.</li>
<li>      LimPID, comprising P, PI, PD, and PID controller with limited output, anti-windup compensation and input weighting (setpoint and measured value) added.</li>
<li>      Improved new generic plot functions are used for time and frequency plots.</li>
<li> New system transformations (similarity transformation, canonical forms).</li>
<li> New transformations between system descriptions added, especially from
     ZerosAndPoles to StateSpace and from TransferFunction to StateSpace.</li>
<li> Generate condensed forms like Hessenberg description </li>
<li> Controllability/Observability forms</li>
<li> Time response with plot (step, ramp, impulse)</li>
<li> Bode plots improved, since the transformation from StateSpace to ZerosAndPoles
     uses a better algorithm from the newest LAPACK version.</li>
<li> Based on a newer LAPACK version 3.1.1.</li>
</ul>

</html>
"));
    end Version_2_0;

    class Version_0_95 "Version 0.95 (Feb. 11, 2008)"

      annotation (Documentation(info="<html>

<p>
Adapted the library to the Modelica Standard Library 3.0 and
to the new restrictions of the Modelica Language Version 3.0.
</p>

</html>
"));
    end Version_0_95;

    class Version_0_93 "Version 0.93 (Feb. 11, 2008)"

      annotation (Documentation(info="<html>

<p>
The following new components have been added:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
  <tr><td colspan=\"2\"><b>Modelica_LinearSystems2.StateSpace.</b></td></tr>
  <tr><td valign=\"top\"> plotBodeMIMO </td>
      <td valign=\"top\"> Plot bode plot of all transfer functions of a state space system.</td>
  </tr>

  <tr><td valign=\"top\"> plotBodeSISO </td>
      <td valign=\"top\"> Plot bode plot of transfer function from input iu to output iy
                        of a state space system.</td>
  </tr>

  <tr><td colspan=\"2\"><b>Modelica_LinearSystems2.StateSpace.Examples.</b></td></tr>
  <tr><td valign=\"top\"> bodePlotMIMO<br>
                        bodePlotSISO </td>
      <td valign=\"top\"> Demonstrate the new Bode plot possibilities.</td>
  </tr>

  <tr><td colspan=\"2\"><b>Modelica_LinearSystems2.TransferFunction.</b></td></tr>
  <tr><td valign=\"top\"> fromStateSpaceSISO<br>
                        fromStateSpaceMIMO </td>
      <td valign=\"top\"> Generate transfer functions of a state space system.</td>
  </tr>

  <tr><td colspan=\"2\"><b>Modelica_LinearSystems2.ZerosAndPoles.</b></td></tr>
  <tr><td valign=\"top\"> fromStateSpaceSISO<br>
                        fromStateSpaceMIMO </td>
      <td valign=\"top\"> Generate ZerosAndPoles from a state space system.</td>
  </tr>

</table>

</html>
"));
    end Version_0_93;

    class Version_0_9 "Version 0.9 (Oct. 17, 2005)"

      annotation (Documentation(info="<html>
<p>
First Beta-Version of the library.
</p>
<p>
The Modelica_LinearSystems2.Controller library (previously called Modelica_LinearSystems.Sampled) is based on the
Sampled library from Nico Walther (master thesis
from the electrical engineering at the HTWK-Leipzig,
supervised by Prof. M&uuml;ller, HTWK, and Prof. Martin Otter, DLR).
Based on the experience in using the Sampled library,
new features in Modelica as well as in Dymola,
the Sampled library was considerably restructured, and
newly implemented. The following main changes have been
performed:
</p>
<ul>
<li> The library is based on the input/output signal connectors
     of the Modelica standard library 2.1 (and higher). Previously,
     it was based on version 1.6. Similar as in 2.1, all blocks
     have been de-vectorized (more convenient for the user in the
     standard case. Modelica allows now easy vectorization of
     blocks).</li>
<li> The previous parameter \"method\" was split into \"blockType\" (continuous/discrete)
     and \"methodType\" (discretization method). It is therefore
     easier to switch between a continuous and a discrete representation because
     one does not have to remember which discretization method was used
     previously when switching from a continuous to a discrete representation.</li>
<li> The main options (blockType, methodType, sampleTime, initType) are set
     globally in component SampleClock via inner/outer and no longer in every
     component. The default defined in SampleClock can be changed in every
     component. Since in many cases just the defaults are used, it is now
     much more convenient to define the sampling setting and
     switch between different representations.</li>
<li> In every component, the Integer parameter sampleFactor is present that
     defines the sampling time of this component as a \"sampleFactor\"
     multiple of the base sample time defined in sampleClock.
     This allows a more easier definition of standard multi-rate
     systems (in the previous version, in every component the actual
     sample time had to be defined). In the future, more advanced
     sampling options might be added, e.g., via user definable
     trigger signals.</li>
<li> The previous Filter sublibrary was replaced by two components
     <b>Filter</b> and <b>FilterFIR</b> that model IIR and FIR filter.
     There are now more options for IIR filters (additional Bessel
     filter + normalized/non-normalized filters).</li>
<li> The previous NoiseGenerators sublibrary was replaced by
     component <b>Noise</b>. In most applications only this Noise
     component is needed in sampled data systems and not the other
     variants in the previous NoiseGenerator library. It is then
     easier for a user to just select this component and not
     be forced to first figure out what component to use.</li>
<li> The discrete representations of the blocks are changed such that
     no past values of the input signals u are accessed. For linear systems
     this is always possible via a state transformation. The benefit is
     that it is easier to initialize the block. Previously,
     it was necessary to define somehow the initial values of pre(u).
     This was not always made in a consistent way. Since in the new version
     no pre(u) is present, it need not be initialized.</li>
<li> The sampling definition was changed. Previously, some when clauses have been
     evaluated during initialization and via the sample() operator at the
     initial time again (i.e., the when block was evaluated twice at
     the start time). Some blocks have not been evaluated during initialization and
     therefore in some cases the discrete variables have been not properly
     initialized. In the new version, all when-clauses are active during
     initialization and they are evaluated again at the next sample time:
     <pre>
     <b>when</b> {<b>initial</b>(), <b>sample</b>(Ts,Ts)} <b>then</b>
         // active during initialization and at time = Ts, 2*Ts, 3*Ts, ...
       ...
     <b>end when</b>;
     </pre>
     Furthermore, parameter startTime was removed (= first sample time of
     when-clause after the initialization) since this is nearly never needed
     in a practical application and therefore this parameter could be
     removed (and no longer confuses users).</li>
<li> The continuous representations of all blocks are implemented such that
     as much struture as possible is preserved in order that index reduction
     is possible. For example, if a transfer function has more poles as
     zeros, then the output of the block might be differentiated n times
     (n = number of poles - number of zeros) without introducing derivatives
     in the inputs. A detailed explanation is given at the end of the info
     layer of component
     <a href=\"Modelica://Modelica_LinearSystems2.Controller.ZerosAndPoles\">ZerosAndPoles</a>.
     Previously, transfer functions and especially filters did not have this
     feature. Therefore, it was not possible to use the filters of the previous
     Sampled library as pre-filters in an inverse model. This is now
     possible. In such a case, a Bessel filter is most appropriate, because
     it does not introduce osciallations as the Butterworth and Chebyhev
     filter do and it is faster as the critical damping filter, see the
     description of the <a href=\"Modelica://Modelica_LinearSystems2.ZerosAndPoles.Design.filter\">filter</a>
     function. Previously, a Bessel filter was not supported.
     </li>
<li> Previously, blocks have been implement with a large if-clause in which
     the different representations have been defined. In the new version,
     the discrete representations are defined in a separate block that
     are activated via a conditional declaration, if the block is discrete.
     (conditional declarations have been only recently introduced into
     the Modelica language version 2.2). The benefit is that the implementation
     is simpler and that there is no longer any overhead for the continuous
     block (all equations and variables from the discrete representation
     are removed during translation).</li>
<li> Previously, for all simple blocks (such as FirstOrder) the different
     discrete representations have been specifially derived and implemented.
     In the new version, all blocks are first transformed to
     state space form with a function call and then the
     discrete state space system block is used for the discrete
     representation. This approach is less error prone and
     the implementation is much simpler.</li>
<li> Special data structures for linear systems have been introduced
     in form of records and accompanying functions operating on these
     records. As a result, also the input parameters of some blocks,
     such as StateSpace or TransferFunction are now records instead
     of arrays. It is then possible to generate such system representations
     by appropriate function calls and supply the result as record
     instance to the corresponding block.</li>
</ul>


</html>
"));
    end Version_0_9;
    annotation (Documentation(info="<html>
<p>
This section summarizes the changes that have been performed
on the Modelica LinearSystems library.
</p>

</html>"));
  end ReleaseNotes;

class ModelicaLicense2 "Modelica License 2"

  annotation (Documentation(info="<html>
<p>All files in this directory (Modelica_LinearSystems2) and in all
subdirectories, especially all files that build package \"Modelica_LinearSystems2\"
are licensed by <b><u>DLR</u></b> under the
<b><u>Modelica License 2</u></b>.</p>

<p style=\"margin-left: 40px;\"><b>Licensor:</b><br>
Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Robotik und Mechatronik<br>
Postfach 1116<br>
D-82230 Wessling<br>
Germany<br>
email: Martin.Otter@dlr.de
</p>

<p style=\"margin-left: 40px;\"><b>Copyright notices of the files:</b><br>
Copyright &copy; 2005-2009, DLR Institut f&uuml;r Robotik und Mechatronik.<br>
<br>
</p>


<hr>
<h4><a name=\"ModelicaLicense2\"></a>The Modelica License 2</h4>

<p>
<b>Preamble.</b> The goal of this license is that Modelica related
model libraries, software, images, documents, data files etc. can be
used freely in the original or a modified form, in open source and in
commercial environments (as long as the license conditions below are
fulfilled, in particular sections 2c) and 2d). The Original Work is
provided free of charge and the use is completely at your own risk.
Developers of free Modelica packages are encouraged to utilize this
license for their work.</p>

<p>
The Modelica License applies to any Original Work that contains the
following licensing notice adjacent to the copyright notice(s) for
this Original Work:</p>
<p><b>Licensed
by the Modelica Association under the Modelica License 2</b></p>

<p><b>1. Definitions.</b></p>
<ol>
 <li>&ldquo;License&rdquo; is this Modelica License.</li>

 <li>
 &ldquo;Original Work&rdquo; is any work of authorship, including
 software, images, documents, data files, that contains the above
 licensing notice or that is packed together with a licensing notice
 referencing it.</li>

 <li>
 &ldquo;Licensor&rdquo; is the provider of the Original Work who has
 placed this licensing notice adjacent to the copyright notice(s) for
 the Original Work. The Original Work is either directly provided by
 the owner of the Original Work, or by a licensee of the owner.</li>

 <li>
 &ldquo;Derivative Work&rdquo; is any modification of the Original
 Work which represents, as a whole, an original work of authorship.
 For the matter of clarity and as examples: </li>

 <ol>
  <li>
  Derivative Work shall not include work that remains separable from
  the Original Work, as well as merely extracting a part of the
  Original Work without modifying it.</li>

  <li>
  Derivative Work shall not include (a) fixing of errors and/or (b)
  adding vendor specific Modelica annotations and/or (c) using a
  subset of the classes of a Modelica package, and/or (d) using a
  different representation, e.g., a binary representation.</li>

  <li>
  Derivative Work shall include classes that are copied from the
  Original Work where declarations, equations or the documentation
  are modified.</li>

  <li>
  Derivative Work shall include executables to simulate the models
  that are generated by a Modelica translator based on the Original
  Work (of a Modelica package).</li>
 </ol>

 <li>
 &ldquo;Modified Work&rdquo; is any modification of the Original Work
 with the following exceptions: (a) fixing of errors and/or (b)
 adding vendor specific Modelica annotations and/or (c) using a
 subset of the classes of a Modelica package, and/or (d) using a
 different representation, e.g., a binary representation.</li>

 <li>
 &quot;Source Code&quot; means the preferred form of the Original
 Work for making modifications to it and all available documentation
 describing how to modify the Original Work.</li>

 <li>
 &ldquo;You&rdquo; means an individual or a legal entity exercising
 rights under, and complying with all of the terms of, this License.</li>

 <li>
 &ldquo;Modelica package&rdquo; means any Modelica library that is
 defined with the<br>&ldquo;<FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\"><b>package</b></FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\">
 &lt;Name&gt; ... </FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\"><b>end</b></FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\">
 &lt;Name&gt;;</FONT></FONT>&ldquo; Modelica language element.</li>
</ol>

<p>
<b>2. Grant of Copyright License.</b> Licensor grants You a
worldwide, royalty-free, non-exclusive, sublicensable license, for
the duration of the copyright, to do the following:</p>

<ol>
 <li><p>
 To reproduce the Original Work in copies, either alone or as part of
 a collection.</li></p>
 <li><p>
 To create Derivative Works according to Section 1d) of this License.</li></p>
 <li><p>
 To distribute or communicate to the public copies of the <u>Original
 Work</u> or a <u>Derivative Work</u> under <u>this License</u>. No
 fee, neither as a copyright-license fee, nor as a selling fee for
 the copy as such may be charged under this License. Furthermore, a
 verbatim copy of this License must be included in any copy of the
 Original Work or a Derivative Work under this License.<br>      For
 the matter of clarity, it is permitted A) to distribute or
 communicate such copies as part of a (possible commercial)
 collection where other parts are provided under different licenses
 and a license fee is charged for the other parts only and B) to
 charge for mere printing and shipping costs.</li></p>
 <li><p>
 To distribute or communicate to the public copies of a <u>Derivative
 Work</u>, alternatively to Section 2c), under <u>any other license</u>
 of your choice, especially also under a license for
 commercial/proprietary software, as long as You comply with Sections
 3, 4 and 8 below. <br>      For the matter of clarity, no
 restrictions regarding fees, either as to a copyright-license fee or
 as to a selling fee for the copy as such apply.</li></p>
 <li><p>
 To perform the Original Work publicly.</li></p>
 <li><p>
 To display the Original Work publicly.</li></p>
</ol>

<p>
<b>3. Acceptance.</b> Any use of the Original Work or a
Derivative Work, or any action according to either Section 2a) to 2f)
above constitutes Your acceptance of this License.</p>

<p>
<b>4. Designation of Derivative Works and of Modified Works.
</b>The identifying designation of Derivative Work and of Modified
Work must be different to the corresponding identifying designation
of the Original Work. This means especially that the (root-level)
name of a Modelica package under this license must be changed if the
package is modified (besides fixing of errors, adding vendor specific
Modelica annotations, using a subset of the classes of a Modelica
package, or using another representation, e.g. a binary
representation).</p>

<p>
<b>5. Grant of Patent License.</b>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license,
under patent claims owned by the Licensor or licensed to the Licensor by
the owners of the Original Work that are embodied in the Original Work
as furnished by the Licensor, for the duration of the patents,
to make, use, sell, offer for sale, have made, and import the Original Work
and Derivative Works under the conditions as given in Section 2.
For the matter of clarity, the license regarding Derivative Works covers
patent claims to the extent as they are embodied in the Original Work only.</p>

<p>
<b>6. Provision of Source Code.</b> Licensor agrees to provide
You with a copy of the Source Code of the Original Work but reserves
the right to decide freely on the manner of how the Original Work is
provided.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the matter of clarity, Licensor might provide only a binary
representation of the Original Work. In that case, You may (a) either
reproduce the Source Code from the binary representation if this is
possible (e.g., by performing a copy of an encrypted Modelica
package, if encryption allows the copy operation) or (b) request the
Source Code from the Licensor who will provide it to You.</p>

<p>
<b>7. Exclusions from License Grant.</b> Neither the names of
Licensor, nor the names of any contributors to the Original Work, nor
any of their trademarks or service marks, may be used to endorse or
promote products derived from this Original Work without express
prior permission of the Licensor. Except as otherwise expressly
stated in this License and in particular in Sections 2 and 5, nothing
in this License grants any license to Licensor&rsquo;s trademarks,
copyrights, patents, trade secrets or any other intellectual
property, and no patent license is granted to make, use, sell, offer
for sale, have made, or import embodiments of any patent claims.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No license is granted to the trademarks of
Licensor even if such trademarks are included in the Original Work,
except as expressly stated in this License. Nothing in this License
shall be interpreted to prohibit Licensor from licensing under terms
different from this License any Original Work that Licensor otherwise
would have a right to license.</p>

<p>
<b>8. Attribution Rights.</b> You must retain in the Source
Code of the Original Work and of any Derivative Works that You
create, all author, copyright, patent, or trademark notices, as well
as any descriptive text identified therein as an &quot;Attribution
Notice&quot;. The same applies to the licensing notice of this
License in the Original Work. For the matter of clarity, &ldquo;author
notice&rdquo; means the notice that identifies the original
author(s). <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must cause the Source Code for any Derivative
Works that You create to carry a prominent Attribution Notice
reasonably calculated to inform recipients that You have modified the
Original Work. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In case the Original Work or Derivative Work is not provided in
Source Code, the Attribution Notices shall be appropriately
displayed, e.g., in the documentation of the Derivative Work.</p>

<p><b>9. Disclaimer
of Warranty. <br></b><u><b>The Original Work is provided under this
License on an &quot;as is&quot; basis and without warranty, either
express or implied, including, without limitation, the warranties of
non-infringement, merchantability or fitness for a particular
purpose. The entire risk as to the quality of the Original Work is
with You.</b></u><b> </b>This disclaimer of warranty constitutes an
essential part of this License. No license to the Original Work is
granted by this License except under this disclaimer.</p>

<p>
<b>10. Limitation of Liability.</b> Under no circumstances and
under no legal theory, whether in tort (including negligence),
contract, or otherwise, shall the Licensor, the owner or a licensee
of the Original Work be liable to anyone for any direct, indirect,
general, special, incidental, or consequential damages of any
character arising as a result of this License or the use of the
Original Work including, without limitation, damages for loss of
goodwill, work stoppage, computer failure or malfunction, or any and
all other commercial damages or losses. This limitation of liability
shall not apply to the extent applicable law prohibits such
limitation.</p>

<p>
<b>11. Termination.</b> This License conditions your rights to
undertake the activities listed in Section 2 and 5, including your
right to create Derivative Works based upon the Original Work, and
doing so without observing these terms and conditions is prohibited
by copyright law and international treaty. Nothing in this License is
intended to affect copyright exceptions and limitations. This License
shall terminate immediately and You may no longer exercise any of the
rights granted to You by this License upon your failure to observe
the conditions of this license.</p>

<p>
<b>12. Termination for Patent Action.</b> This License shall
terminate automatically and You may no longer exercise any of the
rights granted to You by this License as of the date You commence an
action, including a cross-claim or counterclaim, against Licensor,
any owners of the Original Work or any licensee alleging that the
Original Work infringes a patent. This termination provision shall
not apply for an action alleging patent infringement through
combinations of the Original Work under combination with other
software or hardware.</p>

<p>
<b>13. Jurisdiction.</b> Any action or suit relating to this
License may be brought only in the courts of a jurisdiction wherein
the Licensor resides and under the laws of that jurisdiction
excluding its conflict-of-law provisions. The application of the
United Nations Convention on Contracts for the International Sale of
Goods is expressly excluded. Any use of the Original Work outside the
scope of this License or after its termination shall be subject to
the requirements and penalties of copyright or patent law in the
appropriate jurisdiction. This section shall survive the termination
of this License.</p>

<p>
<b>14. Attorneys&rsquo; Fees.</b> In any action to enforce the
terms of this License or seeking damages relating thereto, the
prevailing party shall be entitled to recover its costs and expenses,
including, without limitation, reasonable attorneys' fees and costs
incurred in connection with such action, including any appeal of such
action. This section shall survive the termination of this License.</p>

<p>
<b>15. Miscellaneous.</b>
</p>
<ol>
 <li>If any
 provision of this License is held to be unenforceable, such
 provision shall be reformed only to the extent necessary to make it
 enforceable.</li>

 <li>No verbal
 ancillary agreements have been made. Changes and additions to this
 License must appear in writing to be valid. This also applies to
 changing the clause pertaining to written form.</li>

 <li>You may use the
 Original Work in all ways not otherwise restricted or conditioned by
 this License or by law, and Licensor promises not to interfere with
 or be responsible for such uses by You.</li>
</ol>

<p>
<br>
</p>

<hr>

<h4><a name=\"2. Frequently Asked Questions|outline\"></a>
Frequently Asked Questions</h4>
<p>This
section contains questions/answer to users and/or distributors of
Modelica packages and/or documents under Modelica License 2. Note,
the answers to the questions below are not a legal interpretation of
the Modelica License 2. In case of a conflict, the language of the
license shall prevail.</p>

<p><br>
</p>

<p><FONT COLOR=\"#008000\"><FONT SIZE=3><b>Using
or Distributing a Modelica </b></FONT></FONT><FONT COLOR=\"#008000\"><FONT SIZE=3><u><b>Package</b></u></FONT></FONT><FONT COLOR=\"#008000\"><FONT SIZE=3><b>
under the Modelica License 2</b></FONT></FONT></p>

<p><b>What are the main
differences to the previous version of the Modelica License?</b></p>
<ol>
 <li><p>
 Modelica License 1 is unclear whether the licensed Modelica package
 can be distributed under a different license. Version 2 explicitly
 allows that &ldquo;Derivative Work&rdquo; can be distributed under
 any license of Your choice, see examples in Section 1d) as to what
 qualifies as Derivative Work (so, version 2 is clearer).</p>
 <li><p>
 If You modify a Modelica package under Modelica License 2 (besides
 fixing of errors, adding vendor specific Modelica annotations, using
 a subset of the classes of a Modelica package, or using another
 representation, e.g., a binary representation), you must rename the
 root-level name of the package for your distribution. In version 1
 you could keep the name (so, version 2 is more restrictive). The
 reason of this restriction is to reduce the risk that Modelica
 packages are available that have identical names, but different
 functionality.</p>
 <li><p>
 Modelica License 1 states that &ldquo;It is not allowed to charge a
 fee for the original version or a modified version of the software,
 besides a reasonable fee for distribution and support<SPAN LANG=\"en-GB\">&ldquo;.
 Version 2 has a </SPAN>similar intention for all Original Work under
 <u>Modelica License 2</u> (to remain free of charge and open source)
 but states this more clearly as &ldquo;No fee, neither as a
 copyright-license fee, nor as a selling fee for the copy as such may
 be charged&rdquo;. Contrary to version 1, Modelica License 2 has no
 restrictions on fees for Derivative Work that is provided under a
 different license (so, version 2 is clearer and has fewer
 restrictions).</p>
 <li><p>
 Modelica License 2 introduces several useful provisions for the
 licensee (articles 5, 6, 12), and for the licensor (articles 7, 12,
 13, 14) that have no counter part in version 1.</p>
 <li><p>
 Modelica License 2 can be applied to all type of work, including
 documents, images and data files, contrary to version 1 that was
 dedicated for software only (so, version 2 is more general).</p>
</ol>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) as part of my commercial
Modelica modeling and simulation environment?</b></p>
<p>Yes,
according to Section 2c). However, you are not allowed to charge a
fee for this part of your environment. Of course, you can charge for
your part of the environment.
</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) under a different
license?</b></p>
<p>No.
The license of an unmodified Modelica package cannot be changed
according to Sections 2c) and 2d). This means that you cannot <u>sell</u>
copies of it, any distribution has to be free of charge.</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first encrypt the package?</b></p>
<p>No.
Merely encrypting a package does not qualify for Derivative Work and
therefore the encrypted package has to stay under Modelica License 2.</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first add classes to the package?</b></p>
<p>No.
The package itself remains unmodified, i.e., it is Original Work, and
therefore the license for this part must remain under Modelica
License 2. The newly added classes can be, however, under a different
license.
</p>

<p><b>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it </b><u><b>unmodified</b></u><b> in a Modelica package
under a </b><u><b>commercial/proprietary license</b></u><b>?</b></p>
<p>No,
according to article 2c). However, you can include model, block,
function, package, record and connector classes in your Modelica
package under <u>Modelica License 2</u>. This means that your
Modelica package could be under a commercial/proprietary license, but
one or more classes of it are under Modelica License 2.<br>Note, a
&ldquo;type&rdquo; class (e.g., type Angle = Real(unit=&rdquo;rad&rdquo;))
can be copied and included unmodified under a commercial/proprietary
license (for details, see the next question).</p>

<p><b>Can
I copy a type class or </b><u><b>part</b></u><b> of a model, block,
function, record, connector class, out of a Modelica package (under
Modelica License 2) and include it modified or unmodified in a
Modelica package under a </b><u><b>commercial/proprietary</b></u><b>
license</b></p>
<p>Yes,
according to article 2d), since this will in the end usually qualify
as Derivative Work. The reasoning is the following: A type class or
part of another class (e.g., an equation, a declaration, part of a
class description) cannot be utilized &ldquo;by its own&rdquo;. In
order to make this &ldquo;usable&rdquo;, you have to add additional
code in order that the class can be utilized. This is therefore
usually Derivative Work and Derivative Work can be provided under a
different license. Note, this only holds, if the additional code
introduced is sufficient to qualify for Derivative Work. Merely, just
copying a class and changing, say, one character in the documentation
of this class would be no Derivative Work and therefore the copied
code would have to stay under Modelica License 2.</p>

<p><b>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it in </b><u><b>modified </b></u><b>form in a
</b><u><b>commercial/proprietary</b></u><b> Modelica package?</b></p>
<p>Yes.
If the modification can be seen as a &ldquo;Derivative Work&rdquo;,
you can place it under your commercial/proprietary license. If the
modification does not qualify as &ldquo;Derivative Work&rdquo; (e.g.,
bug fixes, vendor specific annotations), it must remain under
Modelica License 2. This means that your Modelica package could be
under a commercial/proprietary license, but one or more parts of it
are under Modelica License 2.</p>

<p><b>Can I distribute a
&ldquo;save total model&rdquo; under my commercial/proprietary
license, even if classes under Modelica License 2 are included?</b></p>
<p>Your
classes of the &ldquo;save total model&rdquo; can be distributed
under your commercial/proprietary license, but the classes under
Modelica License 2 must remain under Modelica License 2. This means
you can distribute a &ldquo;save total model&rdquo;, but some parts
might be under Modelica License 2.</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) in encrypted form?</b></p>
<p>Yes.
Note, if the encryption does not allow &ldquo;copying&rdquo; of
classes (in to unencrypted Modelica source code), you have to send
the Modelica source code of this package to your customer, if he/she
wishes it, according to article&nbsp;6.</p>

<p><b>Can I distribute an
executable under my commercial/proprietary license, if the model from
which the executable is generated uses models from a Modelica package
under Modelica License 2?</b></p>
<p>Yes,
according to article 2d), since this is seen as Derivative Work. The
reasoning is the following: An executable allows the simulation of a
concrete model, whereas models from a Modelica package (without
pre-processing, translation, tool run-time library) are not able to
be simulated without tool support. By the processing of the tool and
by its run-time libraries, significant new functionality is added (a
model can be simulated whereas previously it could not be simulated)
and functionality available in the package is removed (e.g., to build
up a new model by dragging components of the package is no longer
possible with the executable).</p>

<p><b>Is my modification to
a Modelica package (under Modelica License 2) a Derivative Work?</b></p>
<p>It
is not possible to give a general answer to it. To be regarded as &quot;an
original work of authorship&quot;, a derivative work must be
different enough from the original or must contain a substantial
amount of new material. Making minor changes or additions of little
substance to a preexisting work will not qualify the work as a new
version for such purposes.
</p>

<p><br>
</p>
<p><FONT COLOR=\"#008000\"><FONT SIZE=3><b>Using
or Distributing a Modelica </b></FONT></FONT><FONT COLOR=\"#008000\"><FONT SIZE=3><u><b>Document</b></u></FONT></FONT><FONT COLOR=\"#008000\"><FONT SIZE=3><b>
under the Modelica License 2</b></FONT></FONT></p>

<p>This
section is devoted especially for the following applications:</p>
<ol>
 <li><p>
 A Modelica tool extracts information out of a Modelica package and
 presents the result in form of a &ldquo;manual&rdquo; for this
 package in, e.g., html, doc, or pdf format.</p>
 <li><p>
 The Modelica language specification is a document defining the
 Modelica language. It will be licensed under Modelica License 2.</p>
 <li><p>
 Someone writes a book about the Modelica language and/or Modelica
 packages and uses information which is available in the Modelica
 language specification and/or the corresponding Modelica package.</p>
</ol>

<p><b>Can I sell a manual
that was basically derived by extracting information automatically
from a Modelica package under Modelica License 2 (e.g., a &ldquo;reference
guide&rdquo; of the Modelica Standard Library):</b></p>
<p>Yes.
Extracting information from a Modelica package, and providing it in a
human readable, suitable format, like html, doc or pdf format, where
the content is significantly modified (e.g. tables with interface
information are constructed from the declarations of the public
variables) qualifies as Derivative Work and there are no restrictions
to charge a fee for Derivative Work under alternative 2d).</p>

<p><b>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it </b><u><b>unmodified</b></u><b> in my document
(e.g. the Modelica syntax description in the Modelica Specification)?</b></p>
<p>Yes.
In case you distribute your document, the copied parts are still
under Modelica License 2 and you are not allowed to charge a license
fee for this part. You can, of course, charge a fee for the rest of
your document.</p>

<p><b>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it in </b><u><b>modified</b></u><b> form in my
document?</b></p>
<p>Yes,
the creation of Derivative Works is allowed. In case the content is
significantly modified this qualifies as Derivative Work and there
are no restrictions to charge a fee for Derivative Work under
alternative 2d).</p>

<p><b>Can I sell a printed
version of a Modelica document (under Modelica License 2), e.g., the
Modelica Language Specification?</b></p>
<p>No,
if you are not the copyright-holder, since article 2c) does not allow
a selling fee for a (in this case physical) copy. However, mere
printing and shipping costs may be recovered.</p>
</html>
"));

end ModelicaLicense2;

  class Requirements "Requirements"

    annotation (Documentation(info="<html>
<p>
This library is implemented with Modelica 3.1 (especially the
operator overloading features are utilized) and requires the
<a href=\"http://www.netlib.org/clapack/CLAPACK-3.1.1-VisualStudio.zip\">LAPACK 3.1.1</a> object library.
Furthermore, linearization and plotting is implemented
with Dymola API calls. It is planned to move these tool specific calls to the
<a href=\"Modelica://ModelicaServices\">ModelicaServices</a> package
(introduced for the Modelica Standard Library 3.1 for these
purposes), in order that other Modelica tools can provide the same functionality in a clean way.
</p>

</html>
"));
  end Requirements;

  class Contact "Contact"

    annotation (Documentation(info="<html>
<dl>
<dt><b>Main Authors:</b></dt>
<dd>Martin Otter and Marcus Baur<br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=mailto:Martin.Otter@dlr.de>Martin.Otter@dlr.de</A><br></dd>
</dl>
<p><b>Acknowledgements:</b></p>
<ul>
<li> Some functionality of Modelica_LinearSystems2 (e.g.,
     linearizing a Modelica model by
     Modelica_LinearSystems2.StateSpace.Import.fromModel)
     has been originally developed by Sven Erik Mattsson
     from Dynasim.</li>
<li> The Math.Complex, Math.Polynomial, and
     TransferFunction packages are based on
     proposals from Hilding Elmqvist, Dynasim, presented at
     the 33rd Modelica design meeting in Bielefeld (Nov. 2003) and
     the 37th Modelica design meeting in Lund (Jan. 2004).</li>
<li> Several functions of package Complex have been provided
     by Anton Haumer, who also performed a thorough
     test of the package. </li>
<li> The design of the records (such as Math.Complex and
     Math.Polynomial) has been inspired by the discussions
     about operator overloading at various Modelica design
     meetings.</li>
<li> Advice for implementation issues given by Hans Olsson
     from Dynasim, as well as advice for some numerical algorithms
     given by Andras Varga and Dieter Joos from DLR is appreciated.</li>
<li> Financial support of DLR for the development of this library within
     the European Network of Excellence HYCON (Hybrid Control: taming heterogeneity
     and complexity of networked embedded systems;
     contract number: 511368), and within the German BMBF Verbundprojekt
     PAPAS (Plug-And-Play Antriebs- und Steuerungskonzepte f&uuml;r
     die Produktion von Morgen; F&ouml;rderkennzeichen: 02PH2060) is
     highly appreciated.</li>
<li> Since Oct. 2007, the library development was partially funded by BMBF within the
     <a href=\"http://www.itea2.org/public/project_leaflets/EUROSYSLIB_profile_oct-07.pdf\">ITEA2 EUROSYSLIB</a>
      project. </li>
</ul>
</html>
"));
  end Contact;
end UsersGuide;
