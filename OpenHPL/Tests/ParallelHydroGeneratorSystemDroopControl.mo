within OpenHPL.Tests;
model ParallelHydroGeneratorSystemDroopControl "This is parallel operation of hydro powers for droop control mechanism."
  extends Modelica.Icons.Example;
  //Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation(
  //  Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  //OpenHPL.HydroPower.Aggregate aggregate annotation(
  //  Placement(visible = true, transformation(extent = {{-4, -6}, {16, 14}}, rotation = 0)));
  Waterway.SurgeTank surgeTank(D = 4, H = 80, L = 80, h_0 = 70) annotation (
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression f(y = gen.f) annotation (
    Placement(visible = true, transformation(extent = {{-88, 42}, {-68, 62}}, rotation = 0)));
  Waterway.Pipe discharge(D_i = 7,H = 5, L = 700) annotation (
    Placement(visible = true, transformation(extent = {{50, -10}, {70, 10}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen gen(J = 5e5, UseFrequencyOutput = true, k_b = 0, theta_e = 1) annotation (
    Placement(visible = true, transformation(extent = {{16, -44}, {36, -24}}, rotation = 0)));
  Waterway.Reservoir tail(H_r = 5, Input_level = false) annotation (
    Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  ElectroMech.Turbines.Turbine turbine(C_v = 3.7, ConstEfficiency = false, H_n = 370, V_dot_n = 40, ValveCapacity = false) annotation (
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant f_ref(k = 50) annotation (
    Placement(visible = true, transformation(extent = {{-88, 72}, {-68, 92}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID controller(Ni = 0.1, Td = 1, Ti = 5, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.SteadyState, k = 0.1, limitsAtInit = true, yMax = 1, yMin = 0.01) annotation (
    Placement(visible = true, transformation(extent = {{-48, 72}, {-28, 92}}, rotation = 0)));
  Waterway.Reservoir reservoir(H_r = 50) annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.Pipe penstock(D_i = 4, H = 300, L = 500, vertical = true) annotation (
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp load(duration = 0, height = 0.3 * 130e6, offset = 0.5 * 130e6, startTime = 20) annotation (
    Placement(visible = true, transformation(origin = {-12, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(D_i = 7, H = 20, L = 4500)  annotation (
    Placement(visible = true, transformation(origin = {-58, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//connect(turbine.P_out, aggregate.P_in) annotation(
//  Line(points = {{-3.8, 34}, {2, 34}, {2, 14}, {2, 14}}, color = {0, 0, 127}));
//connect(load.y, aggregate.u) annotation(
//  Line(points = {{-19, 4}, {-12.5, 4}, {-12.5, 4}, {-4, 4}}, color = {0, 0, 127}));
  connect(penstock.n, turbine.p) annotation (
    Line(points = {{10, 30}, {14.95, 30}, {14.95, 10}, {20, 10}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-20, 30}, {-10, 30}}, color = {28, 108, 200}));
  connect(f.y, controller.u_m) annotation (
    Line(points = {{-67, 52}, {-38, 52}, {-38, 70}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
  connect(turbine.P_out, gen.P_in) annotation (
    Line(points={{30,-1},{26,-1},{26,-22},{26,-22}},        color = {0, 0, 127}));
  connect(controller.u_s, f_ref.y) annotation (
    Line(points = {{-50, 82}, {-67, 82}}, color = {0, 0, 127}));
  connect(gen.u, load.y) annotation (
    Line(points = {{16, -34}, {-1, -34}}, color = {0, 0, 127}));
  connect(controller.y, turbine.u_t) annotation (
    Line(points={{-27,82},{30,82},{30,22},{30,22}},          color = {0, 0, 127}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{40, 10}, {44, 10}, {44, 0}, {50, 0}}, color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-80, 30}, {-68, 30}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-48, 30}, {-40, 30}, {-40, 30}, {-40, 30}}, color = {28, 108, 200}));
  annotation (
    experiment(StartTime = -100, StopTime = 100, Tolerance = 1e-06, Interval = 0.004));
end ParallelHydroGeneratorSystemDroopControl;
