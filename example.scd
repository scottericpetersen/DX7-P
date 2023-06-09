/*

Example usage of the DX7 Clone, DX7-P

---------------------------------------------------------------------
Original author: Aziz Ege Gonul (www.egegonul.com)
Edits and additions: Scott Eric Petersen (www.scottericpetersen.com)
Version: 1.1
License: GNU GPL 3 as per SuperCollider license
---------------------------------------------------------------------

The below code demonstrates how to audition presets, post synthdefs for the various presets to the post window, and write both the synthdefs and analysis of the algorithm to a local file. Preset names can be found in the DX7-SC PDF document included in the main folder.

Basic Usage:

Audition presets by running 1. below, then running the fork expression under 2. You can enter a flag, or leave it blank to audition presets. Entering the \def or \write flags will post two SynthDefs to the post window. You can copy these to a new file, or in the case of \write, they are written to a file for you. You can then use them in your own code. To use the code effectively you must:

1) Be sure the buses exist (by running 1. first)
2) Instantiate the \InfEfx_nnn synth first
3) Instantiate the \DX7_nnn synth being sure to add it to the tail of the group.

The code in examples 3 and 4 below demonstrate use.

*/


/* -- 1 -- Initialize the generation functions */

( // init
s.waitForBoot {
	~busMeAmp = Bus.audio(s, 1); // private buses used for LFO pitch and amplitudes
	~busMePitch = Bus.audio(s, 1); // " "
	~mainCaller = ("./DX7-P.scd").loadRelative.wrapAt(-1).postln; // for testing only
}
)

/* -- 2 -- Audition presets: choose a MIDI note number (pitch), velocity, and preset number here.

The following will generate synthdef parameters and register those synthdefs based on your preset.

To audition sounds (only hear presets), do not pass a flag option. The preset will play for 3 seconds and then be freed.

Otherwise, you can pass the following options (as symbols) for the flag argument:

\def = generate human-readable synthdefs and post them for copying/saving/changing. Enables use cases shown below in --3-- and --4--.

\analysis = print analysis of the CM configuration to the window, and plot the envelopes used in the DX7_NNN synth for each operator.

\write = generate synthdefs, post analysis information, and write all data to a the analysis folder in the same directory as this one. Analysis are all separate documents and time-stamped to avoid overwriting.

*/

// -- 2.a AUDITION PRESETS (no flag)
(
fork {
	// MIDI number, velocity, preset #
	~mainCaller.value(55, 90, 386);
	3.wait;
	// Note Off message
	~mainCaller.value(55, 0);
}
)


// -- 2.b POST SYNTHDEFS TO POST WINDOW

~mainCaller.value(55, 90, 406, \def);

// -- 2.c POST SYNTHDEF ANALYSIS TO POST WINDOW

~mainCaller.value(55, 90, 406, \analysis);

// -- 2.d POST SYNTHDEFS AND ANALYSIS TO POST WINDOW AND WRITE TO FILE

~mainCaller.value(55, 90, 406, \write);


/* -- 3 -- Once you run the above, you can call for your LFO (fx) and DX7 synths as below. Be sure the preset number you enter above is used below. Here, we use preset 406. You can use the synths normally, just be sure the DX7 synth is after (tail) the lfo (InfEfx) synth.

*/
(
Synth('InfEfx_406');
Synth('DX7_406', [\pitch, 60.midicps], addAction:'addToTail');
)

/* -- 4 -- Pattern example.  */

(
var scale = Scale.major.degrees + 48;
Synth('InfEfx_406');
Pbind(\instrument, \DX7_406, \pitch, Prand((scale).midicps,inf), \sustain, 1, \dur, 0.5, \addAction, 1).play;
Pbind(\instrument, \DX7_406, \pitch, Prand((scale ++ Rest() + 12).midicps,inf), \sustain, 2, \dur, 1, \addAction, 1).play;
Pbind(\instrument, \DX7_406, \pitch, Prand((scale - 12).midicps,inf), \sustain, 1, \dur, 0.5, \addAction, 1).play;
)

