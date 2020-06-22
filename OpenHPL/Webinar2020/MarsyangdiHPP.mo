within OpenHPL.Webinar2020;

model MarsyangdiHPP
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r = 20)  annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe headTunnel(D_i = 6.4, H = 10, L = 7199)  annotation(
    Placement(visible = true, transformation(origin = {-58, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.SurgeTank surgeTank(D = 20.5, H = 60, L = 60, h_0 = 20)  annotation(
    Placement(visible = true, transformation(origin = {-28, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe penstock(D_i = 5, H = 60, L = 75)  annotation(
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbineUnit1(ConstEfficiency = true, H_n = 90, ValveCapacity = false, Vdot_n = 30.5)  annotation(
    Placement(visible = true, transformation(origin = {30, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbineUnit2(ConstEfficiency = true, H_n = 90, ValveCapacity = false, Vdot_n = 30.95)  annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbineUnit3(ConstEfficiency = true, H_n = 90, ValveCapacity = false, Vdot_n = 30.5)  annotation(
    Placement(visible = true, transformation(origin = {30, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe tailTunnel(D_i = 6, H = 0, L = 500)  annotation(
    Placement(visible = true, transformation(origin = {68, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tailrace(H_r = 5)  annotation(
    Placement(visible = true, transformation(origin = {90, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 0.5, offset = 0.5, startTime = 200)  annotation(
    Placement(visible = true, transformation(origin = {10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(reservoir.o, headTunnel.i) annotation(
    Line(points = {{-80, 50}, {-68, 50}}, color = {28, 108, 200}));
  connect(headTunnel.o, surgeTank.i) annotation(
    Line(points = {{-48, 50}, {-38, 50}, {-38, 50}, {-38, 50}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation(
    Line(points = {{-18, 50}, {-20, 50}, {-20, -10}, {-20, -10}}, color = {28, 108, 200}));
  connect(turbineUnit3.i, penstock.o) annotation(
    Line(points = {{20, -52}, {0, -52}, {0, -10}}, color = {28, 108, 200}));
  connect(penstock.o, turbineUnit2.i) annotation(
    Line(points = {{0, -10}, {20, -10}}, color = {28, 108, 200}));
  connect(penstock.o, turbineUnit1.i) annotation(
    Line(points = {{0, -10}, {0, -10}, {0, 32}, {20, 32}, {20, 32}}, color = {28, 108, 200}));
  connect(turbineUnit1.o, tailTunnel.i) annotation(
    Line(points = {{40, 32}, {58, 32}, {58, -10}}, color = {28, 108, 200}));
  connect(turbineUnit2.o, tailTunnel.i) annotation(
    Line(points = {{40, -10}, {58, -10}}, color = {28, 108, 200}));
  connect(turbineUnit3.o, tailTunnel.i) annotation(
    Line(points = {{40, -52}, {58, -52}, {58, -10}, {58, -10}}, color = {28, 108, 200}));
  connect(tailTunnel.o, tailrace.o) annotation(
    Line(points = {{78, -10}, {78, -10}, {78, -28}, {70, -28}, {70, -48}, {80, -48}, {80, -48}}, color = {28, 108, 200}));
  connect(ramp.y, turbineUnit1.u_t) annotation(
    Line(points = {{22, 90}, {30, 90}, {30, 44}, {30, 44}}, color = {0, 0, 127}));
  connect(turbineUnit2.u_t, ramp.y) annotation(
    Line(points = {{30, 2}, {30, 2}, {30, 12}, {68, 12}, {68, 90}, {22, 90}, {22, 90}}, color = {0, 0, 127}));
  connect(turbineUnit3.u_t, ramp.y) annotation(
    Line(points = {{30, -40}, {30, -40}, {30, -28}, {-32, -28}, {-32, 30}, {-6, 30}, {-6, 60}, {20, 60}, {20, 90}, {22, 90}}, color = {0, 0, 127}));
end MarsyangdiHPP;
