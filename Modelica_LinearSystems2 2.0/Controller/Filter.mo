within Modelica_LinearSystems2.Controller;
block Filter
  "Continuous or discretized analog low or high pass IIR-filter (CriticalDamping/Bessel/Butterworth/Chebyshev)"
  import Modelica_LinearSystems2.Types;
  extends ZerosAndPoles(final system=system3);
  parameter Modelica_LinearSystems2.Types.AnalogFilter analogFilter=
      Modelica_LinearSystems2.Types.AnalogFilter.CriticalDamping
    "Analog filter characteristics (CriticalDamping/Bessel/Butterworth/Chebyshev)";
  parameter Modelica_LinearSystems2.Types.FilterType filterType=
      Modelica_LinearSystems2.Types.FilterType.LowPass
    "Type of filter (LowPass/HighPass)";
  parameter Integer order(min=1) = 2 "Order of filter";
  parameter Modelica.SIunits.Frequency f_cut=1 "Cut-off frequency";
  parameter Real gain=1.0
    "Gain (= amplitude of frequency response at zero frequency)";
  parameter Boolean normalized=true
    "= true, if amplitude of low pass filter at f_cut is 1/sqrt(2) (=3db)";
  parameter Real A_ripple(unit="dB") = 0.5
    "Pass band ripple for Chebyshev filter (otherwise not used)" annotation(Dialog(enable=analogFilter==Modelica_LinearSystems2.Types.AnalogFilter.Chebyshev));

protected
  parameter Modelica_LinearSystems2.ZerosAndPoles.Internal.ZerosAndPoles
    system2 =                                                                    Modelica_LinearSystems2.ZerosAndPoles.Internal.filter(
      analogFilter=analogFilter,
      filterType=filterType,
      order=order,
      f_cut=f_cut,
      gain=gain,
      A_ripple=A_ripple,
      normalized=normalized) "Filter"          annotation(Hide=true);

  parameter Modelica_LinearSystems2.ZerosAndPoles system3(
    k=system2.k,
    n1=system2.n1,
    n2=system2.n2,
    d1=system2.d1,
    d2=system2.d2);

  annotation (
    defaultComponentName="filter",
    Window(
      x=0.27,
      y=0.1,
      width=0.57,
      height=0.75),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-96,98},{96,-94}},
          lineColor={230,230,255},
          fillColor={230,230,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-80,-88}}, color={192,192,192}),
        Polygon(
          points={{-80,92},{-88,70},{-72,70},{-80,90},{-80,92}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-78},{82,-78}}, color={192,192,192}),
        Polygon(
          points={{90,-78},{68,-70},{68,-86},{90,-78}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,88},{90,38}},
          lineColor={192,192,192},
          textString="filter"),
        Text(
          extent={{-150,-110},{150,-140}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="f_cut=%f_cut"),
        Line(points={{22,10},{14,18},{6,22},{-12,28},{-80,28}}, color={0,0,127}),

        Rectangle(
          extent={{-80,-78},{22,10}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Line(points={{22,10},{30,-2},{36,-20},{40,-32},{44,-58},{46,-78}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Documentation(info="<HTML>
<p>
This block has to be improved for discrete mode. At present, this function seems not to be reliable.
Please use \"criticalDamping instead
</p>
</HTML>
"));

end Filter;
