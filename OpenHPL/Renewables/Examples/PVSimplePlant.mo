within OpenHPL.Renewables.Examples;
model PVSimplePlant "A simple plant for photovoltaics."
  extends Modelica.Icons.Example;
  OpenHPL.Renewables.PVplants.PVSimple pVSimple(P_PV = 1)  annotation (
    Placement(visible = true, transformation(origin = {49, 15}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  Modelica.Blocks.Noise.UniformNoise signal(samplePeriod = 5, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = 200, y_min = 1000)  annotation (
    Placement(visible = true, transformation(origin = {-71, 15}, extent = {{-23, -21}, {23, 21}}, rotation = 0)));
equation
  connect(signal.y, pVSimple.k) annotation (
    Line(points = {{-46, 15}, {21.5, 15}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVSimplePlant;
