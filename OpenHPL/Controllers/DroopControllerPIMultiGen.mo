within OpenHPL.Controllers;
model DroopControllerPIMultiGen "Droop controller model PI inside"
  extends OpenHPL.Icons.Governor;
  outer Constants Const "using standard class with constants";
  //// control parameters of the governor
  parameter Integer ng = 2 "Number of Synchronous generators" annotation (
    Dialog(group = "Controller parameter"));
  parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency of the system" annotation (
    Dialog(group = "Controller parameter"));
  parameter Modelica.SIunits.Power P_r[ng] = fill(0,ng) "Rated power of the synchronous generators" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real D[ng] = fill(4,ng) "Droop characteristics of the synchronous generators in percentage" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real Kp[ng] = fill(0.003,ng) "Kp values for PI controllers" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real Ti[ng] = fill(10,ng) "Ti values for PI controllers" annotation (
    Dialog(group = "Controller parameter"));

  Modelica.Blocks.Interfaces.RealInput f_grid
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Continuous.LimPID PIController(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.003,
    Ti=10,
    yMax=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{-28,64},{-8,84}})));
  Modelica.Blocks.Sources.RealExpression PdyRef(y=P_dy_ref[i])
    annotation (Placement(transformation(extent={{-80,64},{-52,86}})));
  Modelica.Blocks.Sources.RealExpression Psg(y=P_sg[i])
    annotation (Placement(transformation(extent={{-80,36},{-52,58}})));
  Modelica.Blocks.Interfaces.RealVectorInput P_sg
    annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
  Modelica.Blocks.Interfaces.RealVectorOutput uv
    "Vector outputs for turbine valve signal"
    annotation (Placement(transformation(extent={{90,-20},{130,20}})));
equation
  for i in 1:ng loop
    P_dy_ref[i] = -(P_r[i]/1e6)/(D[i]/100)*((f_grid-f_ref)/(f_ref))+P_sg[i];
    PIController(); // to do
  end for;
  P_dy_ref = -(P_r/1e6)/(D/100)*((f_grid-f_ref)/(f_ref))+P_sg;
  P_g = P_sg;
  connect(PIController.u_m, Psg.y)
    annotation (Line(points={{-18,62},{-18,47},{-50.6,47}}, color={0,0,127}));
  connect(PdyRef.y, PIController.u_s) annotation (Line(points={{-50.6,75},{-40,75},
          {-40,74},{-30,74}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>This is a simple model of the governor that controls the guide vane oppening in the turbine based on the reference power production.</p>
<p><br><br>This is a simple model of a droop controller that determines the dynamic reference power to the PI controller for generating turbine valve signal for controlling the flow.</p>
<p>The model is taken from:&nbsp;<a href=\"Resources/Report/Generator_model.pdf\">Resources/Report/Generator_model.pdf</a></p>
</html>"));
end DroopControllerPIMultiGen;
