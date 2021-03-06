"""
A single IF neuron with exponential, current-based synapses, fed by two
spike sources.

Run as:

$ python IF_curr_exp.py <simulator>

where <simulator> is 'neuron', 'nest', etc

Andrew Davison, UNIC, CNRS
September 2006

"""

from pyNN.utility import get_script_args

simulator_name = get_script_args(1)[0]
exec("from pyNN.%s import *" % simulator_name)

setup(timestep=1.0, min_delay=1.0, max_delay=4.0)

ifcell = create(Izhikevich(a=0.015, d=1.5))

spike_sourceE = create(SpikeSourceArray(spike_times=[float(i) for i in range(5,105,10)]))
#spike_sourceE = create(SpikeSourcePoisson(rate=100.0)
spike_sourceI = create(SpikeSourceArray(spike_times=[float(i) for i in range(155,255,10)]))

connE = connect(spike_sourceE, ifcell, weight=1.5, receptor_type='excitatory', delay=2.0)
connI = connect(spike_sourceI, ifcell, weight=-1.5, receptor_type='inhibitory', delay=4.0)
record('v', ifcell, "Results/Izhikevich_%s.pkl" % simulator_name)
initialize(ifcell, v=-53.2)
run(200)

end()
