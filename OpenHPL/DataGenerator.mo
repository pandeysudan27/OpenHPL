within OpenHPL;
package DataGenerator
  "This is a sequential collection of hydropower models to generate the data for finding general expression in terms of nominal head and discharge."

  model PenstockSet "Initial model for Penstock set 1"
    extends Modelica.Icons.Example;
    OpenHPL.Waterway.Reservoir reservoir(H_r=50) annotation (Placement(visible=true, transformation(
          origin={-70,40},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.Ramp control(
      duration=0,
      height=0,
      offset=0.95,
      startTime=0)                                                                                          annotation (
      Placement(visible = true, transformation(origin={-10,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    OpenHPL.Waterway.Reservoir tail(H_r=0, Input_level=false) annotation (Placement(visible=true, transformation(
          origin={50,-20},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    ElectroMech.Turbines.Turbine turbine(
      ValveCapacity=false,               C_v=3.7,
      H_n=60,                                     ConstEfficiency=false) annotation (Placement(visible=true, transformation(
          origin={6,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Waterway.Pipe pipe(H=10, L=10)
      annotation (Placement(transformation(extent={{-40,12},{-20,32}})));
    inner Data data
      annotation (Placement(transformation(extent={{-86,74},{-66,94}})));
  equation
    connect(control.y, turbine.u_t) annotation (
      Line(points={{1,70},{6,70},{6,12}},           color = {0, 0, 127}));
    connect(turbine.i, pipe.o) annotation (Line(points={{-4,0},{-10,0},{-10,22},
            {-20,22}}, color={28,108,200}));
    connect(turbine.o, tail.o) annotation (Line(points={{16,0},{28,0},{28,-20},
            {40,-20}}, color={28,108,200}));
    connect(pipe.i, reservoir.o) annotation (Line(points={{-40,22},{-50,22},{
            -50,40},{-60,40}}, color={28,108,200}));
    annotation (
      experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
  end PenstockSet;
  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end DataGenerator;
