within OpenHPL;
package MIC2020 "Model created for MIC2020 paper."
extends Modelica.Icons.ExamplesPackage;

  model TorpaHPPAirCushionTest
    "Test case for air cushion surge tank from Torpa hydro power plant."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=200)
                                                 annotation (Placement(visible=true, transformation(
          origin={-90,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.Waterway.Pipe intake(
      H=245,
      L=9350,
      D_i=6.56,
      SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-70,22},
              {-50,42}},                                                                                              rotation=0)));
    OpenHPL.Waterway.Pipe discharge(
      H=5,
      L=10000,
      D_i=6.56)                                   annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
    OpenHPL.Waterway.Reservoir tail(H_r=20,Input_level=false) annotation (Placement(visible=true, transformation(
          origin={90,0},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    OpenHPL.Waterway.Pipe penstock(
      D_i=6.56,
      D_o=6.56,
      H=10,
      L=300,
      vertical=true,
      p_eps=0.005)   annotation (Placement(visible=true, transformation(
          origin={0,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.Waterway.SurgeTank surgeTank(
      SurgeTankType=OpenHPL.Types.SurgeTank.STAirCushion,
      H=25,
      L=10,
      D=50,
      p_eps=0.005,
      SteadyState=true,
      h_0=2,
      p_ac=4100000,
      T_ac(displayUnit="K") = 287)                 annotation (Placement(visible=true, transformation(
          origin={-26,34},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    ElectroMech.Turbines.Turbine turbine1(
      ValveCapacity=false,
      C_v=3.7,
      H_n=445,
      Vdot_n=17.5,
      ConstEfficiency=false) annotation (Placement(visible=true, transformation(
          origin={30,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    ElectroMech.Turbines.Turbine turbine2(
      ValveCapacity=false,
      C_v=3.7,
      H_n=445,
      Vdot_n=17.5,
      ConstEfficiency=false)                                             annotation (Placement(visible=true, transformation(
          origin={28,-24},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.CombiTimeTable valve2(
      columns={2},
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://OpenHPL/Resources/Tables/valve2Torpa.txt"),
      tableName="valve2",
      tableOnFile=true,
      startTime=0) annotation (Placement(visible=true, transformation(
          origin={-36,-8},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.CombiTimeTable valve1(
      columns={2},
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://OpenHPL/Resources/Tables/valve1Torpa.txt"),
      tableName="valve1",
      tableOnFile=true,
      startTime=0) annotation (Placement(visible=true, transformation(
          origin={2,70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
  equation
    connect(turbine1.o, discharge.i) annotation (Line(points={{40,10},{44,10},{
            44,0},{50,0}}, color={28,108,200}));
    connect(penstock.o, turbine1.i) annotation (Line(points={{10,30},{12.95,30},
            {12.95,10},{20,10}}, color={28,108,200}));
    connect(reservoir.o, intake.i) annotation (
      Line(points={{-80,30},{-76,30},{-76,32},{-70,32}},                            color = {28, 108, 200}));
    connect(intake.o, surgeTank.i) annotation (
      Line(points={{-50,32},{-44,32},{-44,34},{-36,34}},                            color = {28, 108, 200}));
    connect(surgeTank.o, penstock.i) annotation (
      Line(points={{-16,34},{-14,34},{-14,30},{-10,30}},                            color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
    connect(turbine2.i, turbine1.i) annotation (Line(points={{18,-24},{8,-24},{
            8,10},{20,10}}, color={28,108,200}));
    connect(turbine2.o, discharge.i) annotation (Line(points={{38,-24},{40,-24},
            {40,0},{50,0}}, color={28,108,200}));
    connect(turbine1.u_t, valve1.y[1]) annotation (Line(points={{30,22},{22,22},
            {22,70},{13,70}}, color={0,0,127}));
    connect(turbine2.u_t, valve2.y[1]) annotation (Line(points={{28,-12},{2,-12},
            {2,-8},{-25,-8}}, color={0,0,127}));
    annotation (
      experiment(
        StopTime=14300,
        Interval=1,
        __Dymola_Algorithm="Rkfix4"));
  end TorpaHPPAirCushionTest;

  model TorpaHPPAirCushionTestOnly1
    "Test case for air cushion surge tank from Torpa hydro power plant."
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=200)
                                                 annotation (Placement(visible=true, transformation(
          origin={-90,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.Waterway.Pipe intake(
      H=230,
      L=9350,
      D_i=6.56)                        annotation (Placement(visible=true, transformation(extent={{-70,22},
              {-50,42}},                                                                                              rotation=0)));
    OpenHPL.Waterway.Pipe discharge(
      H=5,
      L=10000,
      D_i=6.56)                                   annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
    OpenHPL.Waterway.Reservoir tail(H_r=20,Input_level=false) annotation (Placement(visible=true, transformation(
          origin={90,0},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    OpenHPL.Waterway.Pipe penstock(
      D_i=6.56,
      D_o=6.56,
      H=10,
      L=300,
      vertical=true,
      p_eps=0.005)   annotation (Placement(visible=true, transformation(
          origin={0,30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OpenHPL.Waterway.SurgeTank surgeTank(
      SurgeTankType=OpenHPL.Types.SurgeTank.STAirCushion,
      H=25,
      L=10,
      D=50,
      p_eps=0.005,
      h_0=2,
      p_ac=4100000,
      T_ac(displayUnit="K") = 287)                 annotation (Placement(visible=true, transformation(
          origin={-26,34},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    ElectroMech.Turbines.Turbine turbine1(
      ValveCapacity=false,
      C_v=3.7,
      H_n=445,
      Vdot_n=17.5,
      ConstEfficiency=false) annotation (Placement(visible=true, transformation(
          origin={30,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.CombiTimeTable valve1(
      columns={2},
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://OpenHPL/Resources/Tables/valve1TorpaLowerIndexTest.txt"),
      tableName="valve1",
      tableOnFile=true) annotation (Placement(visible=true, transformation(
          origin={4,70},
          extent={{-10,-10},{10,10}},
          rotation=0)));

  equation
    connect(turbine1.o, discharge.i) annotation (Line(points={{40,10},{44,10},{
            44,0},{50,0}}, color={28,108,200}));
    connect(penstock.o, turbine1.i) annotation (Line(points={{10,30},{12.95,30},
            {12.95,10},{20,10}}, color={28,108,200}));
    connect(reservoir.o, intake.i) annotation (
      Line(points={{-80,30},{-76,30},{-76,32},{-70,32}},                            color = {28, 108, 200}));
    connect(intake.o, surgeTank.i) annotation (
      Line(points={{-50,32},{-44,32},{-44,34},{-36,34}},                            color = {28, 108, 200}));
    connect(surgeTank.o, penstock.i) annotation (
      Line(points={{-16,34},{-14,34},{-14,30},{-10,30}},                            color = {28, 108, 200}));
    connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
    connect(turbine1.u_t, valve1.y[1]) annotation (Line(points={{30,22},{22,22},
            {22,70},{15,70}}, color={0,0,127}));
    annotation (
      experiment(
        StopTime=1010,
        Interval=1,
        __Dymola_Algorithm="Dassl"));
  end TorpaHPPAirCushionTestOnly1;
end MIC2020;
