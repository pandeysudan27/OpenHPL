within OpenHPL.Renewables.Examples;
model HydroEulerSimple "A hydro power plant with euler turbine."
  extends Modelica.Icons.Example;
  OpenHPL.Renewables.PVplants.PVSimple pVSimple(P_PV = 300)  annotation (
    Placement(visible = true, transformation(origin={-17, -61},  extent={{-13,-13},
            {13,13}},                                                                            rotation = 0)));
  Waterway.Reservoir         reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake(H=23) annotation (Placement(visible=true, transformation(extent={{-70,30},
            {-50,50}},                                                                                              rotation=0)));
  Waterway.Pipe         discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{50,30},
            {70,50}},                                                                                                         rotation=0)));
  Waterway.Reservoir         tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={86,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v = 4, ConstEfficiency=false, ValveCapacity = true) annotation (Placement(visible=true, transformation(
        origin={32,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank STSimple
    annotation (Placement(transformation(extent={{-42,30},{-22,50}})));
  OpenHPL.Controllers.VarController varController annotation(
    Placement(visible = true, transformation(origin = {72, -71}, extent = {{-32, -31}, {32, 31}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression eta(y = turbine.theta_h)  annotation(
    Placement(visible = true, transformation(origin = {26, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression C_v(y = turbine.C_v)  annotation(
    Placement(visible = true, transformation(origin = {30, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression H_n(y = turbine.H_n)  annotation(
    Placement(visible = true, transformation(origin = {30, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant P_w(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-42, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 48e5) annotation(
    Placement(visible = true, transformation(origin = {-8, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 1, uMin = 0.01)  annotation(
    Placement(visible = true, transformation(origin = {146, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Noise.UniformNoise uniformNoise1(samplePeriod = 15, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = 200, y_min = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-78, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Noise.UniformNoise uniformNoise2(samplePeriod = 5, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = 320e6, y_min = 300e6) annotation(
    Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(eta.y, varController.eta) annotation(
    Line(points = {{37, -10}, {64, -10}, {64, -40}, {66, -40}}, color = {0, 0, 127}));
  connect(uniformNoise2.y, varController.P_load) annotation(
    Line(points = {{-54, -2}, {40, -2}, {40, -52}, {40, -52}}, color = {0, 0, 127}));
  connect(uniformNoise1.y, pVSimple.k) annotation(
    Line(points = {{-67, -60}, {-32, -60}}, color = {0, 0, 127}));
  connect(limiter.u, varController.u_v) annotation(
    Line(points = {{134, 4}, {110, 4}, {110, -72}, {110, -72}}, color = {0, 0, 127}));
  connect(limiter.y, turbine.u_t) annotation(
    Line(points = {{158, 4}, {172, 4}, {172, 62}, {32, 62}, {32, 52}, {32, 52}, {32, 52}}, color = {0, 0, 127}));
  connect(const.y, varController.dp) annotation(
    Line(points = {{4, -22}, {52, -22}, {52, -40}, {52, -40}}, color = {0, 0, 127}));
  connect(varController.P_wind, P_w.y) annotation(
    Line(points = {{40, -90}, {-30, -90}, {-30, -86}, {-30, -86}}, color = {0, 0, 127}));
  connect(pVSimple.P_pv, varController.P_pv) annotation(
    Line(points = {{-3, -61}, {12, -61}, {12, -72}, {40, -72}, {40, -70}}, color = {0, 0, 127}));
  connect(C_v.y, varController.C_v) annotation(
    Line(points = {{42, 4}, {78, 4}, {78, -40}, {78, -40}}, color = {0, 0, 127}));
  connect(H_n.y, varController.H_n) annotation(
    Line(points = {{42, 18}, {90, 18}, {90, -40}, {92, -40}}, color = {0, 0, 127}));
  connect(turbine.o, discharge.i) annotation(
    Line(points = {{42, 40}, {50, 40}}, color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation(
    Line(points = {{10, 40}, {22, 40}}, color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation(
    Line(points = {{-80, 40}, {-70, 40}}, color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation(
    Line(points = {{70, 40}, {76, 40}}, color = {28, 108, 200}));
  connect(intake.o, STSimple.i) annotation(
    Line(points = {{-50, 40}, {-42, 40}}, color = {28, 108, 200}));
  connect(penstock.i, STSimple.o) annotation(
    Line(points = {{-10, 40}, {-22, 40}}, color = {28, 108, 200}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HydroEulerSimple;
