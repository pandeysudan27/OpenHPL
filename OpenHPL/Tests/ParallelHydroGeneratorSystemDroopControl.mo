within OpenHPL.Tests;
model ParallelHydroGeneratorSystemDroopControl
  "This is parallel operation of hydro powers for droop control mechanism."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=50) annotation (Placement(visible=true, transformation(
        origin={-90,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-72,40},
            {-52,60}},                                                                                              rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{30,40},
            {50,60}},                                                                                                        rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={70,50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-10,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=40)                                      annotation (Placement(visible=true, transformation(
        origin={-34,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  //Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation(
  //  Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  //OpenHPL.HydroPower.Aggregate aggregate annotation(
  //  Placement(visible = true, transformation(extent = {{-4, -6}, {16, 14}}, rotation = 0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={14,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen Gen(J=5e5)
    annotation (Placement(transformation(extent={{4,0},{24,20}})));
  Modelica.Blocks.Sources.Ramp puLoad(
    duration=20,
    height=0.3,
    offset=0.5,
    startTime=100) annotation (Placement(visible=true, transformation(
        origin={-70,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=60e6)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Constant fref(k=50)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=10000,
    yMax=1,
    yMin=0.01,
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  connect(discharge.n, tail.n) annotation (
    Line(points={{50,50},{60,50}},                                            color = {28, 108, 200}));
  //connect(turbine.P_out, aggregate.P_in) annotation(
  //  Line(points = {{-3.8, 34}, {2, 34}, {2, 14}, {2, 14}}, color = {0, 0, 127}));
  //connect(load.y, aggregate.u) annotation(
  //  Line(points = {{-19, 4}, {-12.5, 4}, {-12.5, 4}, {-4, 4}}, color = {0, 0, 127}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{0,50},{4,50}},                                                 color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-80,50},{-72,50}},                                              color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-52,50},{-44,50}},                                              color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-24,50},{-20,50}},                                              color = {28, 108, 200}));
  connect(turbine.n, discharge.p)
    annotation (Line(points={{24,50},{30,50}}, color={28,108,200}));
  connect(turbine.P_out, Gen.P_in)
    annotation (Line(points={{14,39},{14,22}}, color={0,0,127}));
  connect(puLoad.y, gain.u)
    annotation (Line(points={{-59,10},{-42,10}}, color={0,0,127}));
  connect(Gen.u, gain.y)
    annotation (Line(points={{4,10},{-19,10}}, color={0,0,127}));
  connect(PID.y, turbine.u_t) annotation (Line(points={{41,-30},{96,-30},{96,62},
          {14,62}}, color={0,0,127}));
  connect(PID.u_s, fref.y)
    annotation (Line(points={{18,-30},{-19,-30}}, color={0,0,127}));
  connect(Gen.f, PID.u_m) annotation (Line(points={{25,10},{36,10},{36,-10},{8,
          -10},{8,-50},{30,-50},{30,-42}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=200,
      Interval=0.4,
      __Dymola_Algorithm="Dassl"));
end ParallelHydroGeneratorSystemDroopControl;
