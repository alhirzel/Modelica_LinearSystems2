within Modelica_LinearSystems2.Controller.Templates;
partial model TwoDOFinverseModelController
  "Template of a controller with two structural degrees of freedom and an inverse plant model in forward path"
  parameter Integer l = 1 "number of measurable outputs";
  parameter Boolean additionalMeasurableOutputs = true;
  Modelica.Blocks.Math.Feedback feedback[plant.l] 
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Controller.Internal.Add2 add 
    annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Controller.Filter filter 
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  replaceable Controller.Interfaces.PartialSISO controller 
    constrainedby Controller.Interfaces.PartialSISO 
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  replaceable Controller.Templates.Internal.Plant_SISO plant(l=l,
      additionalMeasurableOutputs=additionalMeasurableOutputs) constrainedby
    Templates.Internal.PlantTemplate_SISO 
    annotation (Placement(transformation(extent={{90,-20},{110,0}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseModel 
    annotation (Placement(transformation(extent={{-70,10},{-30,30}})));
  replaceable Internal.Plant_SISO plant_inv(l=l,
      additionalMeasurableOutputs=additionalMeasurableOutputs) constrainedby
    Templates.Internal.PlantTemplate_SISO 
    annotation (Placement(transformation(extent={{-45,15},
            {-55,25}})));
equation
  connect(controller.u, feedback[1].y)  annotation (Line(
      points={{8,-10},{-1,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(plant.ym, feedback.u2) annotation (Line(
      points={{100,-21},{100,-40},{-10,-40},{-10,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(plant_inv.y, inverseModel.u2)             annotation (Line(
      points={{-55.5,20},{-66,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(plant_inv.u, inverseModel.y2)             annotation (Line(
      points={{-44,20},{-33,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(feedback.u1, plant_inv.ym)  annotation (Line(
      points={{-18,-10},{-50,-10},{-50,14.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(filter.y, inverseModel.u1)            annotation (Line(
      points={{-79,20},{-72,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(controller.y, add.u2[1]) annotation (Line(
      points={{31,-10},{52,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u1[1], inverseModel.y1) annotation (Line(
      points={{60,-2},{60,20},{-29,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y[1], plant.u) annotation (Line(
      points={{69,-10},{88,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,
            -100},{140,100}}), graphics={Text(
          extent={{-72,44},{-30,32}},
          lineColor={0,0,0},
          textString="inverted system")}),Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-140,-100},{140,100}})),
    Documentation(info="<html>
<p>
Template of a controller with two structural degrees of freedom and an inverse plant model in forward path.
The functionality of such contorl system structures is discribed in [1]
<p>
 
<A name=\"References\"><B><FONT SIZE=\"+1\">References</FONT></B></A> <PRE>
  [1] Looye, G. et al, \"Nonlinear inverse moldes for control\",
      Proceedings Modelica Conference 2005, pp. 267-279, 2005.
</PRE>
 
 
 
</html>"));
end TwoDOFinverseModelController;