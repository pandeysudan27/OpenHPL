within OpenHPL.SIMS20202Models;
model TrollheimSTThrottleValveST
  "Model of Trollheim HPP with throttle valve type surge tank."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=50) annotation (Placement(visible=true, transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(
    duration=15,
    height=0.9,
    offset=0.5,
    startTime=0)                                                                                          annotation (
    Placement(visible = true, transformation(origin={-10,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(
    H=20,
    L=4500,
    D_i=6,
    D_o=6)                           annotation (Placement(visible=true, transformation(extent={{-70,20},{-50,40}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=0,
    L=700,
    D_i=6,
    D_o=6)                                      annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(
    ValveCapacity=false,               C_v=3.7,
    H_n=370,
    Vdot_n=40,                                  ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank STThrottleValve(
    SurgeTankType=OpenHPL.Types.SurgeTank.STThrottleValve,
    H=80,
    L=80,
    D=4,
    D_so=1.5,
    D_t=1.5,
    L_t=20,
    h_0=50) annotation (Placement(transformation(extent={{-42,20},{-22,40}})));
  inner Data data
    annotation (Placement(transformation(extent={{-94,76},{-74,96}})));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{40,10},{44,10},{44,0},{50,0}},            color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{1,70},{30,70},{30,22}},         color = {0, 0, 127}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{10,30},{14.95,30},{14.95,10},{20,10}},                         color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}},                                              color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  connect(intake.o, STThrottleValve.i)
    annotation (Line(points={{-50,30},{-42,30}}, color={28,108,200}));
  connect(penstock.i, STThrottleValve.o)
    annotation (Line(points={{-10,30},{-22,30}}, color={28,108,200}));
  annotation (
    experiment(
      StartTime=-2000,
      StopTime=1000,
      Interval=0.4,
      __Dymola_Algorithm="Dassl"));
end TrollheimSTThrottleValveST;
