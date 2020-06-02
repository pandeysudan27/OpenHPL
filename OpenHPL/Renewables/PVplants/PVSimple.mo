within OpenHPL.Renewables.PVplants;

model PVSimple "Simple cell PV model."
  parameter Real P_PV = 10 "Rated power of PV in MW" annotation(
    Dialog(group = "PV rating"));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimpleCell cell(useConstantIrradiance = false) annotation(
    Placement(visible = true, transformation(origin = {-44, 66}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 0.01372) annotation(
    Placement(visible = true, transformation(origin = {-2, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression i_cell(y = resistor.p.i) annotation(
    Placement(visible = true, transformation(origin = {-12, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression v_cell(y = resistor.p.v) annotation(
    Placement(visible = true, transformation(origin = {-12, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-50, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput P_pv "Connector of Real output signal" annotation(
    Placement(visible = true, transformation(origin = {121, 1}, extent = {{-21, -21}, {21, 21}}, rotation = 0), iconTransformation(origin = {110, 7.77156e-16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput k "Solar irradiance value; constant or vector data in W/m^2." annotation(
    Placement(visible = true, transformation(extent = {{-128, -20}, {-88, 20}}, rotation = 0), iconTransformation(origin = {-110, -4.44089e-16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter PhotoVoltaics.Records.SHARP_NU_S5_E3E moduleData annotation(
    Placement(visible = true, transformation(origin = {68, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu = 4) annotation(
    Placement(visible = true, transformation(origin = {32, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant MW(k = 1e6) annotation(
    Placement(visible = true, transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = P_PV) annotation(
    Placement(visible = true, transformation(origin = {-12, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(multiProduct.y, P_pv) annotation(
    Line(points = {{44, -16}, {102, -16}, {102, 2}, {122, 2}}, color = {0, 0, 127}));
  connect(const.y, multiProduct.u[4]) annotation(
    Line(points = {{0, -80}, {22, -80}, {22, -16}, {22, -16}}, color = {0, 0, 127}));
  connect(MW.y, multiProduct.u[3]) annotation(
    Line(points = {{1, -50}, {10, -50}, {10, -17.75}, {22, -17.75}}, color = {0, 0, 127}));
  connect(k, cell.variableIrradiance) annotation(
    Line(points = {{-108, 0}, {-56, 0}, {-56, 66}, {-56, 66}}, color = {0, 0, 127}));
  connect(cell.p, resistor.p) annotation(
    Line(points = {{-44, 76}, {-12, 76}, {-12, 72}, {-12, 72}}, color = {0, 0, 255}));
  connect(cell.n, ground.p) annotation(
    Line(points = {{-44, 56}, {-50, 56}, {-50, 32}, {-50, 32}}, color = {0, 0, 255}));
  connect(resistor.n, ground.p) annotation(
    Line(points = {{8, 72}, {8, 32}, {-50, 32}}, color = {0, 0, 255}));
  connect(i_cell.y, multiProduct.u[1]) annotation(
    Line(points = {{-1, 6}, {10, 6}, {10, -10.75}, {22, -10.75}}, color = {0, 0, 127}));
  connect(v_cell.y, multiProduct.u[2]) annotation(
    Line(points = {{-1, -16}, {10, -16}, {10, -14.25}, {22, -14.25}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Bitmap(origin = {5, 26}, extent = {{-77, -70}, {45, 38}}, fileName = "modelica://OpenHPL/Resources/Images/PVplants.svg"), Rectangle(origin = {0, -1}, lineColor = {170, 0, 255}, lineThickness = 0.5, extent = {{-100, 101}, {100, -99}}), Text(origin = {-95, 7}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-11, 7}, {29, -17}}, textString = "k"), Text(origin = {79, -9}, lineColor = {0, 0, 255}, extent = {{-21, 23}, {5, -3}}, textString = "P_pv"), Text(origin = {-56, 147}, lineColor = {28, 108, 200}, extent = {{-42, 15}, {138, -37}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end PVSimple;
