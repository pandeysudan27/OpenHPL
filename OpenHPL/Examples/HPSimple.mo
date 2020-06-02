within OpenHPL.Examples;
model HPSimple "Model of waterway of the HP system with simplified models for conduits, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90, 30},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(H = 23, SteadyState = true) annotation (Placement(visible=true, transformation(extent={{-70,20},{-50,40}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(SteadyState = true, h_0 = 69.9) annotation (Placement(visible=true, transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v = 3.96, ConstEfficiency=false, ValveCapacity = true) annotation (Placement(visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimpleCell cell(constantIrradiance = 1000, useConstantIrradiance = false)  annotation(
    Placement(visible = true, transformation(origin = {12, -36}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {18, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 0.01372)  annotation(
    Placement(visible = true, transformation(origin = {54, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression icell(y = resistor.p.i)  annotation(
    Placement(visible = true, transformation(origin = {-64, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vcell(y = resistor.p.v)  annotation(
    Placement(visible = true, transformation(origin = {-52, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-18, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 0, height = 0.5, offset = 0.5, startTime = 200)  annotation(
    Placement(visible = true, transformation(origin = {-6, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 0, height = 500, offset = 500, startTime = 50) annotation(
    Placement(visible = true, transformation(origin = {-70, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp2.y, cell.variableIrradiance) annotation(
    Line(points = {{-58, -6}, {-2, -6}, {-2, -36}, {0, -36}}, color = {0, 0, 127}));
  connect(ramp1.y, turbine.u_t) annotation(
    Line(points = {{6, 82}, {30, 82}, {30, 22}, {30, 22}}, color = {0, 0, 127}));
  connect(product1.u2, vcell.y) annotation(
    Line(points = {{-30, -58}, {-40, -58}, {-40, -62}, {-40, -62}}, color = {0, 0, 127}));
  connect(product1.u1, icell.y) annotation(
    Line(points = {{-30, -46}, {-52, -46}, {-52, -40}, {-52, -40}, {-52, -40}}, color = {0, 0, 127}));
  connect(resistor.n, ground.p) annotation(
    Line(points = {{64, -26}, {70, -26}, {70, -80}, {18, -80}}, color = {0, 0, 255}));
  connect(cell.p, resistor.p) annotation(
    Line(points = {{12, -26}, {44, -26}}, color = {0, 0, 255}));
  connect(cell.n, ground.p) annotation(
    Line(points = {{12, -46}, {18, -46}, {18, -80}}, color = {0, 0, 255}));
  connect(reservoir.o, intake.i) annotation(
    Line(points = {{-80, 30}, {-70, 30}}, color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation(
    Line(points = {{40, 10}, {44, 10}, {44, 0}, {50, 0}}, color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation(
    Line(points = {{10, 30}, {14.95, 30}, {14.95, 10}, {20, 10}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation(
    Line(points = {{-50, 30}, {-40, 30}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation(
    Line(points = {{-20, 30}, {-10, 30}}, color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation(
    Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple;
