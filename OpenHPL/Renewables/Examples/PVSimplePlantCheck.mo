within OpenHPL.Renewables.Examples;
model PVSimplePlantCheck "A simple plant for photovoltaics."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=100)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  ElectroMech.Turbines.Turbine turbine(
    ValveCapacity=false,
    H_n=200,
    Vdot_n=20,
    u_n=0.95) annotation (Placement(transformation(extent={{-16,20},{4,40}})));
  Waterway.Reservoir tailrace(H_r=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,10})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.5,
    offset=0.5,
    startTime=200)
    annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
  Waterway.Pipe penstock(
    H=100,
    L=100,
    D_i=6,
    D_o=6) annotation (Placement(transformation(extent={{-56,40},{-36,60}})));
  Waterway.SurgeTank surgeTank(D=5, h_0=50)
    annotation (Placement(transformation(extent={{-78,40},{-58,60}})));
equation
  connect(turbine.o, tailrace.o) annotation (Line(points={{4,30},{16,30},{16,10},
          {20,10}}, color={28,108,200}));
  connect(ramp.y, turbine.u_t) annotation (Line(points={{-39,78},{-22,78},{-22,
          42},{-6,42}}, color={0,0,127}));
  connect(turbine.i, penstock.o) annotation (Line(points={{-16,30},{-30,30},{
          -30,50},{-36,50}}, color={28,108,200}));
  connect(penstock.i, surgeTank.o)
    annotation (Line(points={{-56,50},{-58,50}}, color={28,108,200}));
  connect(reservoir.o, surgeTank.i)
    annotation (Line(points={{-80,50},{-78,50}}, color={28,108,200}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=500));
end PVSimplePlantCheck;
