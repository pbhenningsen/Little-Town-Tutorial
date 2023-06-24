/// @description Deal with sequences by state

// Control Sequences
switch sequenceState {
	case seqState.playing: {
		global.playerControl = false;	
		}; break;
	case seqState.finished: {
		//Remove sequence
		if (layer_sequence_exists(curSeqLayer, curSeq)) {
			layer_sequence_destroy(curSeq);	
			}
		//Restore control to player, reset
		global.playerControl = true;
		sequenceState = seqState.notPlaying;
		curSeq = noone;
	}; break;
}
