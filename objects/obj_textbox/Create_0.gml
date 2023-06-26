/// @description Variables and setup

//Textbox Variables
textToShow = "Put whatever you want in here, it's a String!";
textWidth = 450;
lineHeight = 28;
fadeMe = 0;
fadeSpeed = 0.1;
image_alpha = 0;
sequenceToShow = noone;

global.playerControl = false;

// Play UI Sound
audio_play_sound(snd_pop01,1,0);

// Dismiss any visible prompts
scr_dismissPrompt(obj_prompt,0);

