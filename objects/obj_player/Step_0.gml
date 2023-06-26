/// @description Player Movement 

// Check keys for movement
if (global.playerControl == true) {
	moveRight = keyboard_check(vk_right);
	moveLeft = keyboard_check(vk_left);
	moveUp = keyboard_check(vk_up);
	moveDown = keyboard_check(vk_down);
}
if (global.playerControl == false) {
	moveRight = 0;
	moveLeft = 0;
	moveUp = 0;
	moveDown = 0;
}

// Run with Shift key
running = keyboard_check(vk_shift);

//Speed up if running
if (running == true) {
	//Ramp up
	if (runSpeed < runMax) {
		runSpeed += 2; //increase run speed by two every frame	
	}
	// Start creating dust
	if (startDust == 0) {
		alarm[0] = 2;
		startDust = 1;
	}
}

//Slow down if no longer running
if (running == false) {
	//Ramp down
	if (runSpeed > 0) {
		runSpeed -= 1;
	}
	startDust = 0;
}

// Calculate Movement
vx = ((moveRight - moveLeft) * (walkSpeed+runSpeed) * (1-carryLimit));
vy = ((moveDown - moveUp) * (walkSpeed+runSpeed) * (1-carryLimit));

// If idle
if (vx == 0 && vy = 0) {
	//If I'm not picking up or putting down an item
	if (myState != playerState.pickingUp && myState != playerState.puttingDown) {
		// If I don't have an item
		if (hasItem == noone) {
			myState = playerState.idle;
		}
		//If I'm carrying an item
		else {
			myState = playerState.carryIdle;
		}
	}
}
	


// If moving 
if (vx != 0 || vy != 0) {
	if !collision_point(x+vx,y,obj_par_environment,true,true) {
	x += vx;//I think this is the part that actually makes the player move. 
	}
	if !collision_point(x,y+vy,obj_par_environment,true,true) {
	y += vy;
	}


//Change direction based on movement
// right
	if (vx > 0) {
		dir = 0;
	}
// left
	if (vx < 0) {
		dir = 2;
	}
// down
	if (vy > 0) {
		dir = 3;
	}
// up
	if (vy < 0) {
		dir = 1;
	}
	// Set state
	//If we don't have an item
	if (hasItem == noone) {
		myState = playerState.walking;
	}
	else {
		myState = playerState.carrying;
	}
	
	// Move audio listener with me
	audio_listener_set_position(0,x,y,0);
}


//Check for collision with NPCs
nearbyNPC = collision_rectangle(x-lookRange,y-lookRange,x+lookRange,y+lookRange,obj_par_npc,false,true);
if nearbyNPC {
	//Play greeting sound
	if (hasGreeted == false) {
		if !(audio_is_playing(snd_greeting01)){
		audio_play_sound(snd_greeting01,1,0);
		hasGreeted = true;
		}
	}
	//Pop up prompt
	if (npcPrompt == noone || npcPrompt == undefined) {
		npcPrompt = scr_showPrompt(nearbyNPC,nearbyNPC.x,nearbyNPC.y-450);//was 450
	}
	show_debug_message("obj_player has found an NPC!");
}
if !nearbyNPC {
	// Reset greeting
	if (hasGreeted == true) {
		hasGreeted = false;
	}
	// Get rid of prompt
	scr_dismissPrompt(npcPrompt,0);
	show_debug_message("obj_player hasn't found anything!");
}

// Check for collision with items

nearbyItem = collision_rectangle(x-lookRange,y-lookRange,x+lookRange,y+lookRange,obj_par_item,false,true);
if (nearbyItem && !nearbyNPC) {
	//Pop up prompt
	if (itemPrompt == noone || itemPrompt == undefined) {
		show_debug_message("obj_player has found an NPC!");
		itemPrompt = scr_showPrompt(nearbyItem,nearbyItem.x,nearbyItem.y-300);
	}
}
if (!nearbyItem || nearbyNPC) {
	// Get rid of prompt
	scr_dismissPrompt(itemPrompt,1);
}

// If picking up an item
if (myState = playerState.pickingUp) {
	if (image_index >= image_number - 1) {
		myState = playerState.carrying;
		global.playerControl = true;
	}
}

//If putting down an item
if (myState == playerState.puttingDown) {
	//Reset weight
	carryLimit = 0;
	//Reset my state once animation finishes
	if (image_index >= image_number-1) {
		myState = playerState.idle;
		global.playerControl = true;
	}
}



// Depth Sorting
depth = -y;

// Auto choose Sprite based on state and direction
sprite_index = playerSpr[myState][dir];


