within OpenHPL.Tests;
model HydroCordModelDraftTube3 "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=418.5 - 372, UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={-192, 56},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake1(
    D_i=6.3,
    D_o=6.3,
    H=372 - 363,
    L=81.5,
    p_eps=0.1) annotation (Placement(visible=true, transformation(extent={{-174, 24}, {-154, 44}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge1(
    D_i=6.3,
    D_o=6.3,
    H=17.5 - 14,
    L=601,
    p_eps=0.075) annotation (Placement(visible=true, transformation(extent={{-24, 18}, {-4, 38}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(
    H_r=24.5 - 22.6,
    Input_level=true,
    UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={60, 2},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock1(
    D_i=4.7,
    D_o=4.7,
    H=356 - 123,
    L=363,
    p_eps=0.0005) annotation (Placement(visible=true, transformation(
        origin={-90, 42},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    D=3.4,
    H=431.5 - 356,
    L=87,
    p_eps=0.1,
    h_0=62.5) annotation (Placement(visible=true, transformation(
        origin={-102, 58},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=6.5, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={-66, -14},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake2(
    D_i=6.3,
    D_o=6.3,
    H=363 - 365,
    L=395,
    p_eps=0.1) annotation (Placement(visible=true, transformation(
        origin={-146, 58},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake3(
    D_i=6.3,
    D_o=6.3,
    H=365 - 356,
    L=4020,
    p_eps=0.5) annotation (Placement(visible=true, transformation(
        origin={-124, 52},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe penstock2(
    D_i=3.3,
    D_o=3.3,
    H=123 - 20.5 + 2.5,
    L=145,
    p_eps=0.0005) annotation (Placement(visible=true, transformation(
        origin={-80, 2},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Modelica.Blocks.Sources.CombiTimeTable servo_pos(columns = {2}, fileName = "D:/OpenHPL/OpenHPL/Resources/Tables/Servo_pos.txt", tableName = "position", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-12, 72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable tail_level(columns = {2}, fileName = "D:/OpenHPL/OpenHPL/Resources/Tables/Tail_level.txt", tableName = "level", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-50, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain per_gain(k = 1 / 100) annotation (
    Placement(visible = true, transformation(origin = {-68, 72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 100, uMin = 0.001) annotation (
    Placement(visible = true, transformation(origin = {-40, 72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
    Placement(visible = true, transformation(origin = {-22, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_level(k = 22.6) annotation (
    Placement(visible = true, transformation(origin = {-72, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe draftTube(
    D_i=2.2,
    D_o=3.04,
    H=12,
    L=draftTube.H,
    p_eps=0.001) annotation (Placement(visible=true, transformation(extent={{-52, -24}, {-32, -4}}, rotation=0)));
  OpenHPL.Waterway.Fitting fitting1(D_i = 4.7)  annotation(
    Placement(visible = true, transformation(origin = {-104, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OpenHPL.Waterway.Pipe pipe1(D_i = 6.3, H = 14 - 22.6, L = 21, p_eps = 0.05)  annotation(
    Placement(visible = true, transformation(origin = {14, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pipe1.i, discharge1.o) annotation(
    Line(points = {{4, -16}, {4, -4}, {-4, -4}, {-4, 28}}, color = {28, 108, 200}));
  connect(draftTube.o, discharge1.i) annotation(
    Line(points = {{-32, -14}, {-32, -7}, {-24, -7}, {-24, 28}}, color = {28, 108, 200}));
  connect(tail.o, pipe1.o) annotation(
    Line(points = {{50, 2}, {24, 2}, {24, -16}}, color = {28, 108, 200}));
  connect(fitting1.i, penstock2.i) annotation(
    Line(points = {{-104, 10}, {-82, 10}, {-82, 12}, {-80, 12}}, color = {28, 108, 200}));
  connect(penstock1.o, fitting1.o) annotation(
    Line(points = {{-90, 32}, {-90, 31}, {-104, 31}, {-104, 30}}, color = {28, 108, 200}));
  connect(turbine.o, draftTube.i) annotation(
    Line(points = {{-56, -14}, {-52, -14}}, color = {28, 108, 200}));
  connect(const_level.y, add1.u2) annotation(
    Line(points = {{-61, -58}, {-34, -58}}, color = {0, 0, 127}));
  connect(tail_level.y[1], add1.u1) annotation(
    Line(points = {{-39, -46}, {-34, -46}}, color = {0, 0, 127}, thickness = 0.5));
  connect(add1.y, tail.Level_in) annotation(
    Line(points = {{-11, -52}, {72, -52}, {72, 7}}, color = {0, 0, 127}));
  connect(limiter1.y, per_gain.u) annotation(
    Line(points = {{-51, 72}, {-56, 72}}, color = {0, 0, 127}));
  connect(servo_pos.y[1], limiter1.u) annotation(
    Line(points = {{-23, 72}, {-28, 72}}, color = {0, 0, 127}, thickness = 0.5));
  connect(per_gain.y, turbine.u_t) annotation(
    Line(points = {{-79, 72}, {-86, 72}, {-86, 52}, {-66, 52}, {-66, -2}}, color = {0, 0, 127}));
  connect(turbine.i, penstock2.o) annotation(
    Line(points = {{-76, -14}, {-80, -14}, {-80, -8}, {-80, -8}}, color = {28, 108, 200}));
  connect(intake3.o, surgeTank.i) annotation(
    Line(points = {{-114, 52}, {-112, 52}, {-112, 58}, {-112, 58}}, color = {28, 108, 200}));
  connect(intake2.o, intake3.i) annotation(
    Line(points = {{-136, 58}, {-134, 58}, {-134, 52}, {-134, 52}}, color = {28, 108, 200}));
  connect(intake1.o, intake2.i) annotation(
    Line(points = {{-154, 34}, {-156, 34}, {-156, 58}, {-156, 58}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock1.i) annotation(
    Line(points = {{-92, 58}, {-90, 58}, {-90, 52}, {-90, 52}}, color = {28, 108, 200}));
  connect(reservoir.o, intake1.i) annotation(
    Line(points = {{-182, 56}, {-174, 56}, {-174, 34}}, color = {28, 108, 200}));
  connect(discharge2.n, tail.n) annotation(
    Line(points = {{82, 6}, {82, 12.9}, {84, 12.9}, {84, 14}}, color = {28, 108, 200}));
  connect(discharge1.n, discharge2.p) annotation(
    Line(points = {{80, -10}, {80, -3}, {62, -3}, {62, 6}}, color = {28, 108, 200}));
  connect(draftTube.n, discharge1.p) annotation(
    Line(points = {{58, -18}, {58, -14}, {60, -14}, {60, -10}}, color = {28, 108, 200}));
  connect(turbine.n, draftTube.p) annotation(
    Line(points = {{42, -6}, {42, -12}, {38, -12}, {38, -18}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock1.p) annotation(
    Line(points = {{6, 66}, {8, 66}, {8, 60}}, color = {28, 108, 200}));
  connect(penstock1.n, fitting1.p) annotation(
    Line(points = {{8, 40}, {11.9, 40}, {11.9, 40}, {14, 40}}, color = {28, 108, 200}));
  connect(turbine.p, penstock2.n) annotation(
    Line(points = {{22, -6}, {22, 0}, {18, 0}}, color = {28, 108, 200}));
  connect(fitting1.n, penstock2.p) annotation(
    Line(points = {{14, 20}, {17.9, 20}, {17.9, 20}, {18, 20}}, color = {28, 108, 200}));
  connect(intake3.n, surgeTank.p) annotation(
    Line(points = {{-16, 60}, {-14, 60}, {-14, 66}}, color = {28, 108, 200}));
  connect(intake2.n, intake3.p) annotation(
    Line(points = {{-38, 66}, {-36, 66}, {-36, 60}}, color = {28, 108, 200}));
  connect(intake1.n, intake2.p) annotation(
    Line(points = {{-60, 60}, {-58, 60}, {-58, 66}}, color = {28, 108, 200}));
  connect(reservoir.n, intake1.p) annotation(
    Line(points = {{-84, 64}, {-79.95, 64}, {-79.95, 60}, {-80, 60}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 3600, StartTime = 0, Tolerance = 0.0001, Interval = 1),
    Diagram(graphics = {Rectangle(origin = {-81, 2}, extent = {{1, -2}, {-1, 2}})}, coordinateSystem(initialScale = 0.1)));
end HydroCordModelDraftTube3;
