# DX7-P
SuperCollider DX7 Clone with human-readable SynthDefs, analysis, and more.

This project is a pedogogical extension of Aziz Ege Gonul's DX7 clone here: https://github.com/everythingwillbetakenaway/DX7-Supercollider. The primary additions here are: 

1) ability to audition presets as-is
2) ability to register and post human-readable SynthDefs for use in any context
3) ability to generate analysis of the generated synthdefs. Analysis includes:
   a) the control matrix with frequency, phase, and amplitude of all carrier/modulators
   b) CM ratios
   c) the modulation matrix which shows what operators act as modulators and carriers (see FM7.ar documentation for more)
   d) the algorithm number used by the preset (and in the SynthDef)
   e) an array showing which operators are carriers (1s) and which are modulators (0s)
4) ability to write analysis and SynthDefs to file for later use.

# To use:

1) Download or clone this repo.
2) Open the example.scd document in SuperCollider.
3) Run 1) in that document
4) Follow instructions based on what you want to do.

## To-Do

1) Currently, the CM ratios are just the frequencies reduced to multiples of the lowest frequency present in the SynthDef. This will not be CM accurate. A fix will be implemented in a future version where configures will be shown, be they multi-carrier ratios, multi-modulator ratios, or both, where the carrier frequencies are those used for the CM ratios and a meta-ratio for the carriers (if multi-carrier) will be given.
