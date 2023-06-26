/// @description Destroy me and do things

// Return control to player if no Sequence to load
if (sequenceToShow == noone) {
	global.playerControl = true;	
}

// Create sequence if appropriate
if (sequenceToShow != noone) {
	
	// Set sequence to center of camera view
	var _camX = camera_get_view_x(view_camera[0])+floor(camera_get_view_width(view_camera[0])*0.5);
	var _camY = camera_get_view_y(view_camera[0])+floor(camera_get_view_height(view_camera[0])*0.5);

	//Make sure our sequence doesn't already exist 
	if (instance_exists(obj_control) && !layer_sequence_exists(obj_control.curSeqLayer, sequenceToShow)) {
		if (layer_exists(obj_control.curSeqLayer)) {
			//Create (play) the Sequence
			layer_sequence_create(obj_control.curSeqLayer,_camX,_camY,sequenceToShow);
			//Make sure cutscenes layer is above the action
			layer_depth(obj_control.curSeqLayer, -10000);
		}
			
		
	}

}

//Destroy Me
instance_destroy();
