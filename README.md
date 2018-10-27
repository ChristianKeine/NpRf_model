# NpRf model to determine synaptic parameters

- calculates synaptic parameters by fitting synaptic currents from train stimulation to NpRf model. Estimates N (RRP size), p (initial release probability), R (replenishment), and f (synaptic facilitation). This model was developed in [*"Thanawala MS, Regehr WG (2016) Determining Synaptic Parameters Using High-Frequency Activation. J Neurosci Methods 264:136–152."*](http://dx.doi.org/10.1016/j.jneumeth.2016.02.021)

### How to use:

- **Input:** EPSC/IPSC amplitudes from train stimulation, units are not important, but the estimated RRP will be in the same units
- **Output:** Struct containing estimated values for N, p, R, and f

- When using, please cite the original publication:
[*"Thanawala MS, Regehr WG (2016) Determining Synaptic Parameters Using High-Frequency Activation. J Neurosci Methods 264:136–152."*](http://dx.doi.org/10.1016/j.jneumeth.2016.02.021)

- requires Optimization Toolbox and Curve Fitting Toolbox in Matlab (tm).
