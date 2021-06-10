within OpenHPL.Examples;
model HPSimpleTurbineControl "Droop control for multi turbines."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-70,20},{-50,40}}, rotation=0)));
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
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine t1(
    C_v=3.7,
    ConstEfficiency=false,
    enable_P_out=false) annotation (Placement(visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine t2(C_v=3.7, ConstEfficiency=false) annotation (
      Placement(visible=true, transformation(
        origin={30,-70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Generators.SimpleGen gen1
    annotation (Placement(transformation(extent={{20,34},{40,54}})));
  ElectroMech.Generators.SimpleGen gen2
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  ElectroMech.Generators.SimpleGen grid(enable_f=true)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{-32,66},{-12,86}})));
  Controllers.TurbineController turbineController(Kp={0.005,0.002}, Ti={10,10})
    annotation (Placement(transformation(extent={{-66,-18},{-46,2}})));
  Modelica.Blocks.Sources.Ramp load(height=0.3*100e6, offset=0.1*100e6,
    startTime=1000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,-20})));
equation
  connect(t1.o, discharge.i) annotation (Line(points={{40,10},{44,10},{44,0},{
          50,0}}, color={28,108,200}));
  connect(penstock.o, t1.i) annotation (Line(points={{10,30},{14.95,30},{14.95,
          10},{20,10}}, color={28,108,200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-40,30}},                                              color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-20,30},{-10,30}},                                              color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  connect(gen1.flange, t1.flange)
    annotation (Line(points={{30,44},{30,10}}, color={0,0,0}));
  connect(t2.flange, gen2.flange)
    annotation (Line(points={{30,-70},{30,-30}}, color={0,0,0}));
  connect(gen2.flange, grid.flange) annotation (Line(points={{30,-30},{50,-30},
          {50,-50},{70,-50}}, color={0,0,0}));
  connect(gen1.flange, grid.flange) annotation (Line(points={{30,44},{50,44},{
          50,-50},{70,-50}}, color={0,0,0}));
  connect(gen1.P_load, zero.y)
    annotation (Line(points={{30,56},{30,76},{-11,76}}, color={0,0,127}));
  connect(gen2.P_load, zero.y) annotation (Line(points={{30,-18},{30,-14},{2,
          -14},{2,76},{-11,76}},
                         color={0,0,127}));
  connect(turbineController.uv[1], t1.u_t) annotation (Line(points={{-44,-8},{
          -12,-8},{-12,22},{22,22}}, color={0,0,127}));
  connect(turbineController.uv[2], t2.u_t) annotation (Line(points={{-44,-8},{
          -12,-8},{-12,-58},{22,-58}}, color={0,0,127}));
  connect(grid.f, turbineController.f_grid) annotation (Line(points={{81,-54},{
          98,-54},{98,-92},{-88,-92},{-88,-8},{-68,-8}},
                                       color={0,0,127}));
  connect(t2.i, t1.i)
    annotation (Line(points={{20,-70},{20,10}}, color={28,108,200}));
  connect(t2.o, discharge.i) annotation (Line(points={{40,-70},{44,-70},{44,0},
          {50,0}}, color={28,108,200}));
  connect(grid.P_load, load.y) annotation (Line(points={{70,-38},{94,-38},{94,
          -20},{81,-20}}, color={0,0,127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimpleTurbineControl;
