within OpenHPL.Waterway;
model ReservoirChannel "Reservoir model based on open channel model"
  extends OpenHPL.Icons.Reservoir;
  outer Constants Const "using standard class with constants";
  //// reservoir segmentation
  parameter Integer N = 20 "Number of segments";
  //// geometrical parameters of the reservoir
  parameter Modelica.SIunits.Length w = 1000 "Reservoir width";
  parameter Modelica.SIunits.Length L = 5000 "Reservoir length";
  parameter Modelica.SIunits.Height H[2] = {2, 2} "Reservoir bed height from left and right side";
  //// initialization
  parameter Modelica.SIunits.Height h0 = 50 "Initial depth of the reservoir";
  //// condition of steady state
  parameter Boolean SteadyState = Const.Steady "if true - starts from Steady State";
  //// variables
  Real q "flow rate";
  //// conector
  OpenHPL.Interfaces.Contact n annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{68,-32},{134,34}})));
  //// using the open channel exampel from the KP method class
  Internal.KPOpenChannel openChannel(
    N=N,
    w=w,
    H=H,
    h0=ones(N)*h0,
    boundaryValues=[h0 + H[1],q; h0 + H[2],q],
    boundaryCondition=[true,true; false,true],
    SteadyState=SteadyState) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  //// boundaries
  n.m_dot = -q * w * Const.rho;
  n.p = Const.p_a + Const.rho * Const.g * openChannel.h[N];
  annotation (
    Documentation(info="<html>This is a model for the reservoir, based on the open channel (river) model.</p>
<p><em>Has not been tested properly.</em></p>
</html>"));
end ReservoirChannel;
