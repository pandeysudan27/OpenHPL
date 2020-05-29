within OpenHPL;
package Paper2New "Model created for paper 2"
extends Modelica.Icons.ExamplesPackage;

  model TLRSimple "Model of Trollheim HPP with sharp orifice surge tank."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r = 50) annotation(
      Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Ramp control(duration = 0, height = -0.99, offset = 1, startTime = 1500) annotation(
      Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    OpenHPL.Waterway.Pipe intake(H = 20, L = 4500, D_i = 6, D_o = 6) annotation(
      Placement(visible = true, transformation(extent = {{-70, 20}, {-50, 40}}, rotation = 0)));
    OpenHPL.Waterway.Pipe discharge(H = 0, L = 700, D_i = 6, D_o = 6) annotation(
      Placement(visible = true, transformation(extent = {{50, -10}, {70, 10}}, rotation = 0)));
    OpenHPL.Waterway.Reservoir tail(H_r = 5, Input_level = false) annotation(
      Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    OpenHPL.Waterway.Pipe penstock(D_i = 4, D_o = 4, H = 300, L = 500, vertical = true) annotation(
      Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ElectroMech.Turbines.Turbine turbine(ValveCapacity = false, C_v = 3.7, H_n = 370, Vdot_n = 40, ConstEfficiency = false) annotation(
      Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    OpenHPL.Waterway.SurgeTankTest surgetank(D = 4, D_so = 2, D_t = 2, H = 80, L = 80, L_t = 20, h_0 = 50) annotation(
      Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(surgetank.o, penstock.i) annotation(
      Line(points = {{-20, 30}, {-10, 30}, {-10, 30}, {-10, 30}}, color = {28, 108, 200}));
    connect(intake.o, surgetank.i) annotation(
      Line(points = {{-50, 30}, {-40, 30}, {-40, 30}, {-40, 30}}, color = {28, 108, 200}));
    connect(turbine.o, discharge.i) annotation(
      Line(points = {{40, 10}, {44, 10}, {44, 0}, {50, 0}}, color = {28, 108, 200}));
    connect(control.y, turbine.u_t) annotation(
      Line(points = {{1, 70}, {30, 70}, {30, 22}}, color = {0, 0, 127}));
    connect(penstock.o, turbine.i) annotation(
      Line(points = {{10, 30}, {14.95, 30}, {14.95, 10}, {20, 10}}, color = {28, 108, 200}));
    connect(reservoir.o, intake.i) annotation(
      Line(points = {{-80, 30}, {-70, 30}}, color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation(
      Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
    annotation(
      experiment(StartTime = -2000, StopTime = 1000, Interval = 0.4, __Dymola_Algorithm = "Dassl"));
  end TLRSimple;

end Paper2New;
