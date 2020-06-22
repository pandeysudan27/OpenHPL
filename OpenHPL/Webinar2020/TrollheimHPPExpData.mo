within OpenHPL.Webinar2020;
model TrollheimHPPExpData
extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=70)    annotation (
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(D_i = 6, D_o = 6,
    H=30,                                               L = 4500, SteadyState = true)  annotation (
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
  Modelica.Blocks.Sources.CombiTimeTable servo_pos(
    columns={2},
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://OpenHPL/Resources/Tables/Servo_pos.txt"),
    tableName="position",
    tableOnFile=true)                                                                                                                                                                        annotation (
    Placement(visible = true, transformation(origin={-70,90},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain per_gain(k=1/100)     annotation (
    Placement(visible = true, transformation(origin={10,90},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(
    limitsAtInit=true,
    uMax=100,
    uMin=0.001)                                                                             annotation (
    Placement(visible = true, transformation(origin={-32,90},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable P_outMWmeasurement(
    columns={2},
    fileName="C:/Users/bruker/Desktop/PowerOutput.txt",
    tableName="power",
    tableOnFile=true) annotation (Placement(visible=true, transformation(
        origin={-70,-70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression powerOutput(y=turbine.P_out)
    annotation (Placement(transformation(extent={{-82,-26},{-62,-6}})));
  Modelica.Blocks.Math.Division P_outMWSimulated
    annotation (Placement(transformation(extent={{-44,-32},{-24,-12}})));
  Modelica.Blocks.Sources.Constant const(k=1e6)
    annotation (Placement(transformation(extent={{-82,-46},{-62,-26}})));
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
  connect(limiter1.y,per_gain. u) annotation (
    Line(points={{-21,90},{-2,90}},                                 color = {0, 0, 127}));
  connect(servo_pos.y[1],limiter1. u) annotation (
    Line(points={{-59,90},{-44,90}},                                            color = {0, 0, 127}, thickness = 0.5));
  connect(servo_pos.y[1], limiter1.u)
    annotation (Line(points={{-59,90},{-44,90}}, color={0,0,127}));
  connect(turbine.u_t, per_gain.y)
    annotation (Line(points={{44,28},{44,90},{21,90}}, color={0,0,127}));
  connect(powerOutput.y, P_outMWSimulated.u1)
    annotation (Line(points={{-61,-16},{-46,-16}}, color={0,0,127}));
  connect(P_outMWSimulated.u2, const.y) annotation (Line(points={{-46,-28},{-54,
          -28},{-54,-36},{-61,-36}}, color={0,0,127}));
  annotation (experiment(
      StopTime=3600,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end TrollheimHPPExpData;
