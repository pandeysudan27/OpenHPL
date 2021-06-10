within OpenHPL.Controllers;
model TurbineController "Droop controller model PI inside"
  extends OpenHPL.Icons.Governor;
  //// control parameters of turbine controller
  parameter Integer ng = 2 "Number of Synchronous generators" annotation (
    Dialog(group = "Controller parameter"));
  parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency of the system" annotation (
    Dialog(group = "Controller parameter"));
  parameter Modelica.SIunits.Power P_r[ng] = fill(130e6,ng) "Rated power of the synchronous generators in Watts" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real D[ng] = fill(4,ng) "Droop characteristics of the synchronous generators in percentage" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real Kp[ng] = fill(0.003,ng) "Kp values for PI controllers" annotation (
   Dialog(group = "Controller parameter"));
  parameter Real Ti[ng] = fill(3,ng) "Ti values for PI controllers" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real uMax=1,uMin=0.01;
  Real x[ng](each start=0) "ng initial states for PI controller";

  Modelica.Blocks.Interfaces.RealInput f_grid
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput uv[ng]
    "Vector outputs for turbine valve signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    Real err[ng],lim[ng];
equation
  for i in 1:ng loop
    // droop control
    err[i] = -(P_r[i]/1e6)/(D[i]/100)*((f_grid-f_ref)/(f_ref));
    // pi controller
    der(x[i]) = err[i]/Ti[i];
    lim[i] = Kp[i]*(x[i] + err[i]);
    // limiter
    uv[i] = smooth(0,if lim[i] > uMax then uMax else if lim[i] < uMin then uMin else lim[i]);
  end for;
  annotation (
    Documentation(info="<html>
<p>This is a simple model of the governor that controls the guide vane oppening in the turbine based on the reference power production.</p>
<p><br><br>This is a simple model of a droop controller that determines the dynamic reference power to the PI controller for generating turbine valve signal for controlling the flow.</p>
<p>The model is taken from:&nbsp;<a href=\"Resources/Report/Generator_model.pdf\">Resources/Report/Generator_model.pdf</a></p>
</html>"));
end TurbineController;
