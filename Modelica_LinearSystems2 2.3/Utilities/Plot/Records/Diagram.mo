within Modelica_LinearSystems2.Utilities.Plot.Records;
record Diagram
  "Properties of a diagram in a figure containing one or more curves"
  extends Modelica.Icons.Record;

  Modelica_LinearSystems2.Utilities.Plot.Records.Curve curve[:]
    "Properties of the curves in one diagram of the figure"    annotation(Dialog);

  String heading="" "Heading displayed above diagram" annotation(Dialog);
  Real heightRatio = 0.45 "Height of diagram = heightRatio*diagramWidth" annotation(Dialog);
  Boolean grid=true "True, if grid is shown" annotation(Dialog,  choices(__Dymola_checkBox=true));

  /* group "Axes" (Axes properties) */
  String xLabel=" " "String displayed at horizontal axis" annotation(Dialog(group="Axes"));
  String yLabel=" " "String displayed at vertical axis" annotation(Dialog(group="Axes"));
  Boolean logX = false "True, if logarithmic scale of x-axis" annotation(Dialog(group="Axes"),choices(__Dymola_checkBox=true));
  Boolean logY = false "True, if logarithmic scale of y-axis" annotation(Dialog(group="Axes"),choices(__Dymola_checkBox=true));
  Boolean uniformScaling = false
    "True, if same vertical and horizontal axis increment"
    annotation(Dialog(group="Axes"),choices(__Dymola_checkBox=true));

  /* group "Legend" (Legend properties) */
  Boolean legend = true "True, if legend is shown" annotation(Dialog(group="Legend"),choices(__Dymola_checkBox=true));
  Boolean legendFrame=false "True, if frame around legend"
    annotation(Dialog(group="Legend"),   choices(__Dymola_checkBox=true));
  Boolean legendHorizontal=true
    "True, if horizontal legend (provided it is meaningful)"
    annotation(Dialog(group="Legend"),choices(__Dymola_checkBox=true));
  Modelica_LinearSystems2.Utilities.Plot.Types.LegendLocation legendLocation=
    Modelica_LinearSystems2.Utilities.Plot.Types.LegendLocation.Above
    "Legend placement" annotation(Dialog(group="Legend"));

end Diagram;
