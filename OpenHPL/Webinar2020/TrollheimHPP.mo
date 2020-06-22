within OpenHPL.Webinar2020;
model TrollheimHPP
extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r = 50)  annotation (
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(D_i = 6, D_o = 6,H = 20, L = 4500, SteadyState = true)  annotation (
    Placement(visible = true, transformation(origin = {-40, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.SurgeTank surgeTank(D = 4, H = 80, L = 80, SteadyState = true, SurgeTankType = OpenHPL.Types.SurgeTank.STSimple, h_0 = 20)  annotation (
    Placement(visible = true, transformation(origin = {-6, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe penstock(D_i = 4, D_o = 4, H = 300, L = 500)  annotation (
    Placement(visible = true, transformation(origin = {20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ElectroMech.Turbines.Turbine turbine(ConstEfficiency = true, H_n = 371, ValveCapacity = false, Vdot_n = 37)  annotation (
    Placement(visible = true, transformation(origin = {44, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tailrace(H_r = 5)  annotation (
    Placement(visible = true, transformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OpenHPL.Waterway.Pipe tailTunnel(D_i = 4, D_o = 4, H = 0, L = 700)  annotation (
    Placement(visible = true, transformation(origin = {64, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp valveSiganlTurbine(duration = 0, height = 0.45, offset = 0.5, startTime = 300)  annotation (
    Placement(visible = true, transformation(origin = {10, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(reservoir.o, intake.i) annotation (
    Line(points = {{-60, 50}, {-50, 50}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points = {{-30, 50}, {-16, 50}, {-16, 50}, {-16, 50}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points = {{4, 50}, {10, 50}, {10, 30}, {10, 30}, {10, 30}}, color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation (
    Line(points = {{30, 30}, {34, 30}, {34, 16}, {34, 16}}, color = {28, 108, 200}));
  connect(turbine.o, tailTunnel.i) annotation (
    Line(points = {{54, 16}, {54, -10}}, color = {28, 108, 200}));
  connect(tailTunnel.o, tailrace.o) annotation (
    Line(points = {{74, -10}, {80, -10}}, color = {28, 108, 200}));
  connect(valveSiganlTurbine.y, turbine.u_t) annotation (
    Line(points = {{21, 80}, {44, 80}, {44, 28}}, color = {0, 0, 127}));
end TrollheimHPP;
