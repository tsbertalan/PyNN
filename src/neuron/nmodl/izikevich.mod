: Izhikevich artificial neuron model from 
: EM Izhikevich "Simple Model of Spiking Neurons"
: IEEE Transactions On Neural Networks, Vol. 14, No. 6, November 2003 pp 1569-1572
: v is the voltage analog, u controls 

NEURON {
  POINT_PROCESS Izikevich
  RANGE a, b, vreset, d
  NONSPECIFIC_CURRENT i
}

UNITS {
    (mV) = (millivolt)
}

INITIAL {
  vm = -65
  u = 0.2*vm
  i = 0
  net_send(0,1)
}

PARAMETER {
  a       = 0.02
  b       = 0.2
  vreset  = -65 (mV)   : reset potential after a spike
  d       = 2
  vthresh = 30  (mV)   : spike threshold
}

STATE { 
  u (mV)
  vm
}

ASSIGNED {
    i (nA)
}

BREAKPOINT {
  SOLVE states METHOD derivimplicit
}

DERIVATIVE states {
  vm' = 0.04*vm*vm + 5*vm + 140 - u + i
  u' = a*(b*vm-u) 
  i  = 0
}

NET_RECEIVE (weight) {
  if (flag == 1) {
    WATCH (vm>vthresh) 2
  } else if (flag == 2) {
    net_event(t)
    vm = vreset
    u = u+d
  } else { : synaptic activation
    i = weight
  }
}
