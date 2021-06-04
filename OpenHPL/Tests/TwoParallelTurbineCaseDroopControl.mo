within OpenHPL.Tests;
model TwoParallelTurbineCaseDroopControl
  "This is parallel operation of hydro powers for droop control mechanism."
  extends Modelica.Icons.Example;
  //Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation(
  //  Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  //OpenHPL.HydroPower.Aggregate aggregate annotation(
  //  Placement(visible = true, transformation(extent = {{-4, -6}, {16, 14}}, rotation = 0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin={-210,132},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen Gen(
    J=0.001,
    theta_e=1,
    k_b=0,
    w_0=314) annotation (Placement(transformation(extent={{82,32},{102,52}})));
  Modelica.Blocks.Sources.Ramp puLoad(
    duration=2,
    height=0.3,
    offset=0.5,
    startTime=100) annotation (Placement(visible=true, transformation(
        origin={26,8},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=2*130e6)
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={56,8})));
  Modelica.Blocks.Continuous.LimPID PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.2,
    Ti=5,
    yMax=1,
    yMin=0.01,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
  Waterway.Reservoir         reservoir1(H_r=50)
                                               annotation (Placement(visible=true, transformation(
        origin={-200,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake1(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-182,80},
            {-162,100}},                                                                                            rotation=0)));
  Waterway.Pipe         discharge1(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{-80,80},
            {-60,100}},                                                                                                      rotation=0)));
  Waterway.Reservoir         tail1(H_r=5)
                                         annotation (Placement(visible=true, transformation(
        origin={-40,90},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock1(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-120,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank1(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=70)                                      annotation (Placement(visible=true, transformation(
        origin={-144,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine1(
    ValveCapacity=false,                C_v=4,
    H_n=370,
    V_dot_n=40,                                ConstEfficiency=false)  annotation (Placement(visible=true, transformation(
        origin={-96,88},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir         reservoir2(H_r=50)
                                               annotation (Placement(visible=true, transformation(
        origin={-200,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake2(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-182,16},
            {-162,36}},                                                                                             rotation=0)));
  Waterway.Pipe         discharge2(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{-80,16},
            {-60,36}},                                                                                                       rotation=0)));
  Waterway.Reservoir         tail2(H_r=5)
                                         annotation (Placement(visible=true, transformation(
        origin={-40,26},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock2(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-120,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank2(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=70)                                      annotation (Placement(visible=true, transformation(
        origin={-144,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine2(
    ValveCapacity=false,                C_v=4,
    H_n=370,
    V_dot_n=40,                                ConstEfficiency=false)  annotation (Placement(visible=true, transformation(
        origin={-96,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression G1(y=Gen1.W_g)
    annotation (Placement(transformation(extent={{-20,78},{0,98}})));
  Modelica.Blocks.Sources.RealExpression G2(y=Gen2.W_g)
    annotation (Placement(transformation(extent={{-20,34},{0,54}})));
  Modelica.Blocks.Math.MultiSum PGenTotal(nu=2)
    annotation (Placement(transformation(extent={{34,58},{46,70}})));
  ElectroMech.Generators.SimpleGen Gen1(J=6e5, k_b=0)
    annotation (Placement(transformation(extent={{-106,52},{-86,72}})));
  ElectroMech.Generators.SimpleGen Gen2(J=6e5, k_b=0)
    annotation (Placement(transformation(extent={{-106,-12},{-86,8}})));
  Modelica.Blocks.Sources.RealExpression DeltaP1(y=-130e6/0.04*(Gen.f - 50)/50)
    annotation (Placement(transformation(extent={{-160,52},{-140,72}})));
  Modelica.Blocks.Sources.RealExpression DeltaP2(y=-130e6/0.05*(Gen.f - 50)/50)
    annotation (Placement(transformation(extent={{-160,-12},{-140,8}})));
  Modelica.Blocks.Sources.RealExpression PrefDy1(y=50)
    annotation (Placement(transformation(extent={{12,-68},{32,-48}})));
  Modelica.Blocks.Sources.RealExpression Pg1(y=Gen1.f)
    annotation (Placement(transformation(extent={{12,-82},{32,-62}})));
  Modelica.Blocks.Continuous.LimPID PI2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.2,
    Ti=5,
    yMax=1,
    yMin=0.01,
    Ni=0.9,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{56,-112},{76,-92}})));
  Modelica.Blocks.Sources.RealExpression PrefDy2(y=50)
    annotation (Placement(transformation(extent={{12,-112},{32,-92}})));
  Modelica.Blocks.Sources.RealExpression Pg2(y=Gen2.f)
    annotation (Placement(transformation(extent={{12,-126},{32,-106}})));
  Modelica.Blocks.Sources.RealExpression Cont1(y=PI1.y)
    annotation (Placement(transformation(extent={{-120,108},{-100,128}})));
  Modelica.Blocks.Sources.RealExpression Cont2(y=PI2.y)
    annotation (Placement(transformation(extent={{-160,38},{-140,58}})));
equation
  //connect(turbine.P_out, aggregate.P_in) annotation(
  //  Line(points = {{-3.8, 34}, {2, 34}, {2, 14}, {2, 14}}, color = {0, 0, 127}));
  //connect(load.y, aggregate.u) annotation(
  //  Line(points = {{-19, 4}, {-12.5, 4}, {-12.5, 4}, {-4, 4}}, color = {0, 0, 127}));
  connect(discharge1.n, tail1.n)
    annotation (Line(points={{-60,90},{-50,90}}, color={28,108,200}));
  connect(penstock1.n, turbine1.p) annotation (Line(points={{-110,90},{-108,90},
          {-108,88},{-106,88}}, color={28,108,200}));
  connect(reservoir1.n, intake1.p)
    annotation (Line(points={{-190,90},{-182,90}}, color={28,108,200}));
  connect(intake1.n, surgeTank1.p)
    annotation (Line(points={{-162,90},{-154,90}}, color={28,108,200}));
  connect(surgeTank1.n, penstock1.p)
    annotation (Line(points={{-134,90},{-130,90}}, color={28,108,200}));
  connect(turbine1.n, discharge1.p) annotation (Line(points={{-86,88},{-84,88},
          {-84,90},{-80,90}}, color={28,108,200}));
  connect(discharge2.n, tail2.n)
    annotation (Line(points={{-60,26},{-50,26}}, color={28,108,200}));
  connect(penstock2.n, turbine2.p)
    annotation (Line(points={{-110,26},{-106,26}}, color={28,108,200}));
  connect(reservoir2.n, intake2.p)
    annotation (Line(points={{-190,26},{-182,26}}, color={28,108,200}));
  connect(intake2.n, surgeTank2.p)
    annotation (Line(points={{-162,26},{-154,26}}, color={28,108,200}));
  connect(surgeTank2.n, penstock2.p)
    annotation (Line(points={{-134,26},{-130,26}}, color={28,108,200}));
  connect(turbine2.n, discharge2.p)
    annotation (Line(points={{-86,26},{-80,26}}, color={28,108,200}));
  connect(G1.y, PGenTotal.u[1]) annotation (Line(points={{1,88},{24,88},{24,
          66.1},{34,66.1}}, color={0,0,127}));
  connect(G2.y, PGenTotal.u[2]) annotation (Line(points={{1,44},{24,44},{24,
          61.9},{34,61.9}}, color={0,0,127}));
  connect(turbine1.P_out, Gen1.P_in)
    annotation (Line(points={{-96,77},{-96,74}}, color={0,0,127}));
  connect(turbine2.P_out, Gen2.P_in)
    annotation (Line(points={{-96,15},{-96,10}}, color={0,0,127}));
  connect(PGenTotal.y, Gen.P_in)
    annotation (Line(points={{47.02,64},{92,64},{92,54}}, color={0,0,127}));
  connect(Gen1.u, DeltaP1.y)
    annotation (Line(points={{-106,62},{-139,62}}, color={0,0,127}));
  connect(Gen2.u, DeltaP2.y)
    annotation (Line(points={{-106,-2},{-139,-2}}, color={0,0,127}));
  connect(puLoad.y, gain.u)
    annotation (Line(points={{37,8},{44,8}}, color={0,0,127}));
  connect(Gen.u, gain.y)
    annotation (Line(points={{82,42},{68,42},{68,8},{67,8}}, color={0,0,127}));
  connect(PrefDy1.y, PI1.u_s)
    annotation (Line(points={{33,-58},{52,-58}}, color={0,0,127}));
  connect(PI1.u_m, Pg1.y)
    annotation (Line(points={{64,-70},{64,-72},{33,-72}}, color={0,0,127}));
  connect(PrefDy2.y, PI2.u_s)
    annotation (Line(points={{33,-102},{54,-102}}, color={0,0,127}));
  connect(PI2.u_m, Pg2.y)
    annotation (Line(points={{66,-114},{66,-116},{33,-116}}, color={0,0,127}));
  connect(turbine1.u_t, Cont1.y) annotation (Line(points={{-96,100},{-98,100},{
          -98,118},{-99,118}}, color={0,0,127}));
  connect(turbine2.u_t, Cont2.y) annotation (Line(points={{-96,38},{-108,38},{
          -108,48},{-139,48}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=200,
      Interval=0.4,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-220,-160},{380,140}})),
    Icon(coordinateSystem(extent={{-220,-160},{380,140}})));
end TwoParallelTurbineCaseDroopControl;
