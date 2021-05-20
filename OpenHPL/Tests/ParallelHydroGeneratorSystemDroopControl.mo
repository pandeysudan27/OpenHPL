within OpenHPL.Tests;
model ParallelHydroGeneratorSystemDroopControl
  "This is parallel operation of hydro powers for droop control mechanism."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir headrace(H_r=50) annotation (Placement(visible=
          true, transformation(
        origin={-84,-4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-66,-14},
            {-46,6}},                                                                                               rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{42,-14},
            {62,6}},                                                                                                         rotation=0)));
  OpenHPL.Waterway.Reservoir tailrace(H_r=5) annotation (Placement(visible=true,
        transformation(
        origin={78,-4},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={0,-4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=40)                                      annotation (Placement(visible=true, transformation(
        origin={-28,-4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  //Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation(
  //  Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  //OpenHPL.HydroPower.Aggregate aggregate annotation(
  //  Placement(visible = true, transformation(extent = {{-4, -6}, {16, 14}}, rotation = 0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={26,-4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants DataOpenHPL annotation (Placement(visible=true,
        transformation(
        origin={-76,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Generators.SimpleGen Gen(J=5e5)
    annotation (Placement(transformation(extent={{16,-44},{36,-24}})));
  Modelica.Blocks.Sources.Ramp load(
    duration=10,
    height=0.3*60e6,
    offset=0.5*60e6,
    startTime=100) annotation (Placement(visible=true, transformation(
        origin={-12,-34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant f_ref(k=50)
    annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
  Modelica.Blocks.Continuous.LimPID Controller(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=10000,
    yMax=1,
    yMin=0.01,
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{-14,38},{6,58}})));
  Modelica.Blocks.Sources.RealExpression f(y=Gen.f)
    annotation (Placement(transformation(extent={{-54,8},{-34,28}})));
equation
  connect(discharge.n, tailrace.n)
    annotation (Line(points={{62,-4},{68,-4}}, color={28,108,200}));
  //connect(turbine.P_out, aggregate.P_in) annotation(
  //  Line(points = {{-3.8, 34}, {2, 34}, {2, 14}, {2, 14}}, color = {0, 0, 127}));
  //connect(load.y, aggregate.u) annotation(
  //  Line(points = {{-19, 4}, {-12.5, 4}, {-12.5, 4}, {-4, 4}}, color = {0, 0, 127}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{10,-4},{16,-4}},                                               color = {28, 108, 200}));
  connect(headrace.n, intake.p)
    annotation (Line(points={{-74,-4},{-66,-4}}, color={28,108,200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-46,-4},{-38,-4}},                                              color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-18,-4},{-10,-4}},                                              color = {28, 108, 200}));
  connect(turbine.n, discharge.p)
    annotation (Line(points={{36,-4},{42,-4}}, color={28,108,200}));
  connect(turbine.P_out, Gen.P_in)
    annotation (Line(points={{26,-15},{26,-22}},
                                               color={0,0,127}));
  connect(Controller.u_s, f_ref.y)
    annotation (Line(points={{-16,48},{-33,48}}, color={0,0,127}));
  connect(Controller.y, turbine.u_t)
    annotation (Line(points={{7,48},{26,48},{26,8}}, color={0,0,127}));
  connect(f.y, Controller.u_m)
    annotation (Line(points={{-33,18},{-4,18},{-4,36}}, color={0,0,127}));
  connect(Gen.u, load.y)
    annotation (Line(points={{16,-34},{-1,-34}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=2000,
      __Dymola_NumberOfIntervals=10000,
      __Dymola_Algorithm="Dassl"));
end ParallelHydroGeneratorSystemDroopControl;
