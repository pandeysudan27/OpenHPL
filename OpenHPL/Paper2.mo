within OpenHPL;
package Paper2 "Model created for paper 2"
extends Modelica.Icons.ExamplesPackage;

  model TrollheimSTSimple "Model of Trollheim HPP with simple surge tank."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=50) annotation (Placement(visible=true, transformation(
          origin={-128, 32},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.Waterway.Pipe intake(
      
      D_i=6,
      D_o=6,H=20,
      L=4500, Vdot(fixed = false))               annotation (Placement(visible=true, transformation(extent={{-112, 22}, {-92, 42}}, rotation=0)));
    OpenHPL.Waterway.Pipe discharge(
      
      D_i=6,
      D_o=6,H=0,
      L=700)                                      annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
    OpenHPL.Waterway.Reservoir tail(H_r= 2, Input_level=false) annotation (Placement(visible=true, transformation(
          origin={90,0},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    OpenHPL.Waterway.Pipe penstock(
      D_i= 4,
      D_o=4,
      H=300,
      L=500, SteadyState = true, Vdot(fixed = true),
      vertical=true)
                     annotation (Placement(visible=true, transformation(
          origin={-40, 32},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.ElectroMech.Turbines.Turbine turbine(
      ValveCapacity=false,               C_v=3.7,
      H_n=370,
      Vdot_n=40,                                  ConstEfficiency=false) annotation (Placement(visible=true, transformation(
          origin={-8, 32},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.Waterway.SurgeTank STSimple(
      
      D=4,
      D_so=1,
      D_t=1.5,
      H=80,
      L=80,
      L_t=20,SurgeTankType=OpenHPL.Types.SurgeTank.STSimple,
      h_0=50)
      annotation (Placement(visible = true, transformation(extent = {{-80, 22}, {-60, 42}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(columns = {2},fileName = "D:/OpenHPL/OpenHPL/Resources/Tables/Servo_pos.txt", tableName = "position", tableOnFile = true)  annotation(
      Placement(visible = true, transformation(origin = {-98, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 100, uMin = 1)  annotation(
      Placement(visible = true, transformation(origin = {-58, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1 / 100)  annotation(
      Placement(visible = true, transformation(origin = {2, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.DraftTube draftTube(D_i = 2, D_o = 3, H = -6.5, L = -6.6, p_eps = 0.01, theta = 0)  annotation(
      Placement(visible = true, transformation(origin = {26, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(draftTube.o, discharge.i) annotation(
      Line(points = {{36, 4}, {50, 4}, {50, 0}, {50, 0}}, color = {28, 108, 200}));
    connect(turbine.o, draftTube.i) annotation(
      Line(points = {{2, 32}, {16, 32}, {16, 4}, {16, 4}}, color = {28, 108, 200}));
    connect(penstock.i, STSimple.o) annotation(
      Line(points = {{-50, 32}, {-60, 32}}, color = {28, 108, 200}));
    connect(penstock.o, turbine.i) annotation(
      Line(points = {{-30, 32}, {-18, 32}}, color = {28, 108, 200}));
    connect(gain.y, turbine.u_t) annotation(
      Line(points = {{14, 88}, {20, 88}, {20, 52}, {-8, 52}, {-8, 44}, {-8, 44}}, color = {0, 0, 127}));
    connect(limiter.y, gain.u) annotation(
      Line(points = {{-47, 86}, {-44.5, 86}, {-44.5, 88}, {-10, 88}}, color = {0, 0, 127}));
    connect(combiTimeTable.y[1], limiter.u) annotation(
      Line(points = {{-87, 86}, {-70, 86}}, color = {0, 0, 127}));
    connect(intake.o, STSimple.i) annotation(
      Line(points = {{-92, 32}, {-80, 32}}, color = {28, 108, 200}));
    connect(reservoir.o, intake.i) annotation(
      Line(points = {{-118, 32}, {-112, 32}}, color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation(
      Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
    annotation (
      experiment(
        StopTime=3000,
        Interval=0.4,
        __Dymola_Algorithm="Dassl"));
  end TrollheimSTSimple;

  model TrollheimSTSharpOrifice
    "Model of Trollheim HPP with sharp orifice surge tank."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=50) annotation (Placement(visible=true, transformation(
          origin={-90,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.Ramp control(
      duration=0,
      height=0.45,
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
  Waterway.SurgeTankTest surgeTankTest1(D = 4, D_so = 2, D_t = 2, H = 80, L = 80, L_t = 0, SurgeTankType = OpenHPL.Types.SurgeTank.STSharpOrifice, h_0 = 50)  annotation(
      Placement(visible = true, transformation(origin = {-28, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(surgeTankTest1.o, penstock.i) annotation(
      Line(points = {{-18, 32}, {-12, 32}, {-12, 30}, {-10, 30}, {-10, 30}}, color = {28, 108, 200}));
    connect(intake.o, surgeTankTest1.i) annotation(
      Line(points = {{-50, 30}, {-38, 30}, {-38, 32}, {-38, 32}}, color = {28, 108, 200}));
    connect(turbine.o, discharge.i) annotation(
      Line(points = {{40, 10}, {44, 10}, {44, 0}, {50, 0}}, color = {28, 108, 200}));
    connect(control.y, turbine.u_t) annotation(
      Line(points = {{1, 70}, {30, 70}, {30, 22}}, color = {0, 0, 127}));
    connect(penstock.o, turbine.i) annotation(
      Line(points = {{10, 30}, {14.95, 30}, {14.95, 10}, {20, 10}}, color = {28, 108, 200}));
    connect(reservoir.o, intake.i) annotation(
      Line(points = {{-80, 30}, {-70, 30}}, color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation(
      Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
    annotation (
      experiment(
        StartTime=-2000,
        StopTime=1000,
        Interval=0.4,
        __Dymola_Algorithm="Dassl"));
  end TrollheimSTSharpOrifice;

  model TrollheimSTThrottleValve
    "Model of Trollheim HPP with throttle valve type surge tank."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=50) annotation (Placement(visible=true, transformation(
          origin={-90,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.Ramp control(
      duration=0,
      height=0.45,
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
  Waterway.SurgeTankTest surgeTankTest1(D = 4, D_so = 2, D_t = 2, H = 80, L = 80, L_t = 0.01, SurgeTankType = OpenHPL.Types.SurgeTank.STSimple, h_0 = 50)  annotation(
      Placement(visible = true, transformation(origin = {-28, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(surgeTankTest1.o, penstock.i) annotation(
      Line(points = {{-18, 28}, {-10, 28}, {-10, 30}, {-10, 30}}, color = {28, 108, 200}));
    connect(intake.o, surgeTankTest1.i) annotation(
      Line(points = {{-50, 30}, {-38, 30}, {-38, 28}, {-38, 28}}, color = {28, 108, 200}));
    connect(turbine.o, discharge.i) annotation(
      Line(points = {{40, 10}, {44, 10}, {44, 0}, {50, 0}}, color = {28, 108, 200}));
    connect(control.y, turbine.u_t) annotation(
      Line(points = {{1, 70}, {30, 70}, {30, 22}}, color = {0, 0, 127}));
    connect(penstock.o, turbine.i) annotation(
      Line(points = {{10, 30}, {14.95, 30}, {14.95, 10}, {20, 10}}, color = {28, 108, 200}));
    connect(reservoir.o, intake.i) annotation(
      Line(points = {{-80, 30}, {-70, 30}}, color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation(
      Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
    annotation (
      experiment(
        StartTime=-2000,
        StopTime=1000,
        Interval=0.4,
        __Dymola_Algorithm="Dassl"));
  end TrollheimSTThrottleValve;

  model TorpaSTAirCushion "Model of Torpa HPP with air-cushion surge tank."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=200)
                                                 annotation (Placement(visible=true, transformation(
          origin={-90,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.Ramp control(
      duration=0,
      height=0.45,
      offset=0.5,
      startTime=0)                                                                                          annotation (
      Placement(visible = true, transformation(origin={-10,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    OpenHPL.Waterway.Pipe intake(
      H=235,
      L=9300,
      D_i=7)                           annotation (Placement(visible=true, transformation(extent={{-70,20},{-50,40}}, rotation=0)));
    OpenHPL.Waterway.Pipe discharge(
      H=0,
      L=10000,
      D_i=7,
      D_o=7)                                      annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
    OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
          origin={90,0},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    OpenHPL.Waterway.Pipe penstock(
      D_i=7,
      D_o=7,
      H=10,
      L=200,
      vertical=true) annotation (Placement(visible=true, transformation(
          origin={0,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    ElectroMech.Turbines.Turbine turbine(
      ValveCapacity=false,               C_v=3.7,
      H_n=150,
      Vdot_n=35,                                  ConstEfficiency=false) annotation (Placement(visible=true, transformation(
          origin={30,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Waterway.SurgeTank STAirCushion(
      SurgeTankType=OpenHPL.Types.SurgeTank.STAirCushion,
      H=25,
      L=25,
      D=50,
      D_so=1,
      D_t=1.5,
      L_t=20,
      h_0=5) annotation (Placement(transformation(extent={{-42,20},{-22,40}})));
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
    connect(intake.o, STAirCushion.i)
      annotation (Line(points={{-50,30},{-42,30}}, color={28,108,200}));
    connect(penstock.i, STAirCushion.o)
      annotation (Line(points={{-10,30},{-22,30}}, color={28,108,200}));
    annotation (
      experiment(
        StartTime=-2000,
        StopTime=1000,
        Interval=0.4,
        __Dymola_Algorithm="Dassl"));
  end TorpaSTAirCushion;

  model TrollheimSTSimpleNow "Model of Trollheim HPP with sharp orifice surge tank."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r = 50) annotation(
      Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Ramp control(duration = 0, height = -0.99, offset = 1, startTime = 1500) annotation(
      Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    OpenHPL.Waterway.Pipe intake(H = 20, L = 4500, D_i = 6, D_o = 6) annotation(
      Placement(visible = true, transformation(extent = {{-70, 20}, {-50, 40}}, rotation = 0)));
    OpenHPL.Waterway.Pipe discharge(H = 0, L = 700, D_i = 6, D_o = 6) annotation(
      Placement(visible = true, transformation(extent = {{50, -10}, {70, 10}}, rotation = 0)));
    OpenHPL.Waterway.Reservoir tail(H_r = 5, Input_level = false) annotation(
      Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    OpenHPL.Waterway.Pipe penstock(D_i = 4, D_o = 4, H = 300, L = 500, vertical = true) annotation(
      Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ElectroMech.Turbines.Turbine turbine(ValveCapacity = false, C_v = 3.7, H_n = 370, Vdot_n = 40, ConstEfficiency = false) annotation(
      Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.SurgeTankTest surgetank(D = 4, D_so = 2, D_t = 2, H = 80, L = 80, L_t = 20, h_0 = 50)  annotation(
      Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(surgetank.o, penstock.i) annotation(
      Line(points = {{-20, 30}, {-10, 30}, {-10, 30}, {-10, 30}}, color = {28, 108, 200}));
    connect(intake.o, surgetank.i) annotation(
      Line(points = {{-50, 30}, {-40, 30}, {-40, 30}, {-40, 30}}, color = {28, 108, 200}));
    connect(turbine.o, discharge.i) annotation(
      Line(points = {{40, 10}, {44, 10}, {44, 0}, {50, 0}}, color = {28, 108, 200}));
    connect(control.y, turbine.u_t) annotation(
      Line(points = {{1, 70}, {30, 70}, {30, 22}}, color = {0, 0, 127}));
    connect(penstock.o, turbine.i) annotation(
      Line(points = {{10, 30}, {14.95, 30}, {14.95, 10}, {20, 10}}, color = {28, 108, 200}));
    connect(reservoir.o, intake.i) annotation(
      Line(points = {{-80, 30}, {-70, 30}}, color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation(
      Line(points = {{70, 0}, {80, 0}}, color = {28, 108, 200}));
    annotation(
      experiment(StartTime = -2000, StopTime = 1000, Interval = 0.4, __Dymola_Algorithm = "Dassl"));
  end TrollheimSTSimpleNow;

end Paper2;
