function scr_playSequence(_seqToPlay){
	// Create sequence if appropriate
	if (_seqToPlay != noone) {
	
		// Set sequence to center of camera view
		var _camX = camera_get_view_x(view_camera[0])+floor(camera_get_view_width(view_camera[0])*0.5);
		var _camY = camera_get_view_y(view_camera[0])+floor(camera_get_view_height(view_camera[0])*0.5);

		//Make sure our sequence doesn't already exist 
		if (instance_exists(obj_control) && !layer_sequence_exists(obj_control.curSeqLayer, _seqToPlay)) {
			if (layer_exists(obj_control.curSeqLayer)) {
				//Create (play) the Sequence
				layer_sequence_create(obj_control.curSeqLayer,_camX,_camY,_seqToPlay);
				//Make sure cutscenes layer is above the action
				layer_depth(obj_control.curSeqLayer, -10000);
			}
			
		
		}

	}
}