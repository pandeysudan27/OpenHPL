within OpenHPL.HydroPVWind;
model SimpleCellPV "Simple cell with load resistor"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(origin = {-44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimpleCell cell(constantIrradiance = 200, moduleData = moduleData, useConstantIrradiance = true) annotation (
    Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  parameter PhotoVoltaics.Records.SHARP_NU_S5_E3E moduleData annotation (
    Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression current(y = resistor1.p.i)  annotation(
    Placement(visible = true, transformation(origin = {-32, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = resistor1.p.v) annotation(
    Placement(visible = true, transformation(origin = {-32, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {2, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1)  annotation(
    Placement(visible = true, transformation(origin = {-8, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(resistor1.n, ground.p) annotation(
    Line(points = {{2, 12}, {4, 12}, {4, -14}, {-44, -14}, {-44, -20}, {-44, -20}}, color = {0, 0, 255}));
  connect(cell.p, resistor1.p) annotation(
    Line(points = {{-44, 10}, {-28, 10}, {-28, 12}, {-18, 12}}, color = {0, 0, 255}));
  connect(realExpression1.y, product1.u2) annotation(
    Line(points = {{-20, -70}, {-12, -70}, {-12, -68}, {-10, -68}}, color = {0, 0, 127}));
  connect(current.y, product1.u1) annotation(
    Line(points = {{-20, -52}, {-12, -52}, {-12, -56}, {-10, -56}}, color = {0, 0, 127}));
  connect(ground.p, cell.n) annotation(
    Line(points = {{-44, -20}, {-44, -10}}, color = {0, 0, 255}));
  annotation (
    defaultComponentName = "moduleData",
    defaultComponentPrefixes = "parameter",
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    Diagram(coordinateSystem(initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
    __OpenModelica_simulationFlags(jacobian = "coloredNumerical", nls = "newton", s = "dassl", lv = "LOG_STATS"));
end SimpleCellPV;
