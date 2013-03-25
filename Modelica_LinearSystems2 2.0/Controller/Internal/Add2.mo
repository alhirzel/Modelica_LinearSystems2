within Modelica_LinearSystems2.Controller.Internal;
model Add2

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-20,22},{20,-18}},
          lineColor={0,0,127},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(
          visible=fromLeft,
          points={{-100,0},{-20,0}},
          color={0,0,127}),
        Line(points={{20,0},{100,0}}, color={0,0,127}),
        Line(points={{0,100},{0,22}}, color={0,0,127}),
        Line(
          visible=not fromLeft,
          points={{0,-18},{0,-60}},
          color={0,0,127}),
        Text(
          extent={{32,62},{92,18}},
          lineColor={0,0,255},
          textString="%name")}));
  parameter Boolean fromLeft = true "true if second input is left (else below)"
                                                                                 annotation(Dialog(choices(checkBox=true)));
  parameter Integer n(min=1)=1 "number of inputs = number of outputs";

  Modelica.Blocks.Interfaces.RealInput u1[n]
                                          annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,80})));
  Modelica.Blocks.Interfaces.RealInput u2[n] if fromLeft
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[n]
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.RealInput u2b[n] if not fromLeft
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Add add[n] annotation (Placement(transformation(extent={{10,-10},{30,10}})));
equation
//y = if fromLeft then u1+u2 else u1+u2b;

  connect(add.u2, u2b) annotation (Line(
      points={{12,0},{0,0},{0,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u2, u2) annotation (Line(
      points={{12,0},{-80,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u1, u1) annotation (Line(
      points={{20,8},{20,40},{0,40},{0,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, y) annotation (Line(
      points={{29,0},{56,0},{56,0},{90,0}},
      color={0,0,127},
      smooth=Smooth.None));
end Add2;
