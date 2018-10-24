# NpRf_model

- calculates synaptic parameters by fitting synaptic currents from train stimulation to NpRf model. Estimates N (RRP size), p (initial release probability), R (replenishment), and f (synaptic facilitation).

- Input arguments: EPSC/IPSC amplitudes from train stimulation
- Output arguments: Struct containing estimated values for N, p, R, and f

- To use run NpRfModel with PSC amplitudes as input arguments.

- When using, please cite the original publication:
"Thanawala MS, Regehr WG (2016) Determining Synaptic Parameters Using High-Frequency Activation. J Neurosci Methods 264:136–152."


- requires Optimization Toolbox and Curve Fitting Toolbox in Matlab.
