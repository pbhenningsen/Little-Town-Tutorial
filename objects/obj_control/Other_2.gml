/// @description Game Variables

//Game variables
global.playerControl = true;
townBGMVolume = audio_sound_get_gain(snd_townBGM);
townAmbienceVolume = audio_sound_get_gain(snd_townAmbience);
global.gameOver = false;
global.gameStart = false;

// Player states
enum playerState {
	idle,
	walking,
	pickingUp,
	carrying,
	carryIdle,
	puttingDown,
}

//Item States
enum itemState {
	idle,
	taken,
	used,
	puttingBack,
}

// Sequence States
enum seqState {
	notPlaying,
	waiting,
	playing,
	finished,
}
// Sequence variables
sequenceState = seqState.notPlaying;
curSeqLayer = noone;
curSeq = noone;


// NPC states
enum npcState {
	normal,
	done,
}