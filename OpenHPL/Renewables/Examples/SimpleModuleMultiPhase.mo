within OpenHPL.Renewables.Examples;
model SimpleModuleMultiPhase "Simple module supplies transient three phase AC grid with maximum power tracker"

  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground groundDC annotation (
    Placement(visible = true, transformation(origin={-60,0},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
    Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{70,-96},{90,-76}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-100,
    duration=2,
    offset=1000,
    startTime=1)                                                                                 annotation (
    Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant powerfactor(k=-acos(0.9))
    annotation (Placement(transformation(extent={{-30,-52},{-10,-32}})));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimpleModuleSymmetric module(
    moduleData=moduleData,
    useConstantIrradiance=false,
    T=298.15) annotation (Placement(visible=true, transformation(
        origin={-60,30},
        extent={{-10,10},{10,-10}},
        rotation=-90)));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(VmpRef=moduleData.VmpRef, ImpRef=moduleData.ImpRef,
    samplePeriod=0.1)                                                                                           annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  PhotoVoltaics.Components.Converters.MultiPhaseConverter converter annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  parameter PhotoVoltaics.Records.SHARP_NU_S5_E3E moduleData annotation (Placement(transformation(extent={{60,60},{80,80}})));

  Modelica.SIunits.Power powerDC = powerSensor.power "DC power";
  Modelica.SIunits.Power powerAC = powerSensorGrid.power "AC real power";
  Modelica.SIunits.ApparentPower aparrentPowerAC = powerFactorActual.u2 "AC apparent power";
  Real powerFactorAC = powerFactorActual.y "Actual power factor";
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 0.01)  annotation(
    Placement(visible = true, transformation(origin = {62, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = resistor1.p.i)  annotation(
    Placement(visible = true, transformation(origin = {118, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y = resistor1.p.v)  annotation(
    Placement(visible = true, transformation(origin = {118, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {158, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(resistor1.n, ground.p) annotation(
    Line(points = {{72, 32}, {80, 32}, {80, -76}, {80, -76}}, color = {0, 0, 255}));
  connect(converter.ac, resistor1.p) annotation(
    Line(points = {{10, 30}, {52, 30}, {52, 32}, {52, 32}}, color = {0, 0, 255}));
  connect(realExpression2.y, product1.u2) annotation(
    Line(points = {{130, -84}, {144, -84}, {144, -74}, {146, -74}}, color = {0, 0, 127}));
  connect(realExpression1.y, product1.u1) annotation(
    Line(points = {{130, -56}, {144, -56}, {144, -62}, {146, -62}}, color = {0, 0, 127}));
  connect(powerSensor.pc, powerSensor.pv) annotation(
    Line(points = {{-40, 50}, {-40, 60}, {-30, 60}}, color = {0, 0, 255}));
  connect(powerSensor.nv, groundDC.p) annotation(
    Line(points = {{-30, 40}, {-30, 40}, {-30, 12}, {-30, 10}, {-60, 10}}, color = {0, 0, 255}));
  connect(module.variableIrradiance, ramp.y) annotation(
    Line(points = {{-72, 30}, {-76, 30}, {-79, 30}}, color = {0, 0, 127}));
  connect(module.n, groundDC.p) annotation(
    Line(points = {{-60, 20}, {-60, 15}, {-60, 10}}, color = {0, 0, 255}));
  connect(module.p, powerSensor.pc) annotation(
    Line(points = {{-60, 40}, {-60, 50}, {-40, 50}}, color = {0, 0, 255}));
  connect(converter.dc_p, powerSensor.nc) annotation(
    Line(points = {{-10, 40}, {-10, 50}, {-20, 50}}, color = {0, 0, 255}));
  connect(converter.dc_n, groundDC.p) annotation(
    Line(points = {{-10, 20}, {-10, 10}, {-60, 10}}, color = {0, 0, 255}));
  connect(mpTracker.power, powerSensor.power) annotation(
    Line(points = {{-32, -10}, {-38, -10}, {-38, 39}}, color = {0, 0, 127}));
  connect(mpTracker.vRef, converter.vDCRef) annotation(
    Line(points = {{-9, -10}, {-6, -10}, {-6, 18}}, color = {0, 0, 127}));
  connect(powerfactor.y, converter.phi) annotation(
    Line(points = {{-9, -42}, {6, -42}, {6, 18}}, color = {0, 0, 127}));
  annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), experiment(StopTime=5, Interval=0.0001));
end SimpleModuleMultiPhase;
