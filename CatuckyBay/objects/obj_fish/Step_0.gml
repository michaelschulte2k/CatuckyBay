//get the current pos
current_x = x;

//periodically samples the fish x pos 
if waiting == false{
	waiting = true
	alarm[0] = 15
	new_x = x
}

//checks which way the fish is moving and flips the sprite respectively
if (new_x < current_x ) {
	
    image_xscale = 2; // Mirror the sprite horizontally
}

if (new_x > current_x ) {
    image_xscale = -2; // Reset the sprite's scale
}

waiting = true

//If fish is in the set radius move twords the bait
if point_distance(x,y,obj_lure.x,obj_lure.y) <= lureRadius{
	chasing = true
	
	path_end()
	move_towards_point(obj_lure.x,obj_lure.y,1)
	//Displays catch meter
	if (!instance_exists(obj_meter)) instance_create_layer(obj_fishingRod.x,obj_fishingRod.y -36,"Instances",obj_meter);
	if global.meterSuccess{
		instance_destroy(obj_sweetSpot)
		instance_destroy(obj_meterLine)
		instance_destroy(obj_meter)
		move_towards_point(obj_bobber.x,obj_bobber.y,1)
		fade = true
		chasing = false
	
		if counter == 180{
			global.meterSuccess = false
			counter = 0
			global.fishA++
			
		}
		else counter++;
		fade = false
}
	
}


//checks if fish is too far
if (point_distance(x,y,obj_lure.x,obj_lure.y) >= lureRadius+1) and chasing{
		fade = true
		chasing = false
		
		instance_destroy(obj_sweetSpot)
		instance_destroy(obj_meterLine)
		instance_destroy(obj_meter)
	}

//fades the image of the fish and after 10 seconds will respawn the fish
if fade {
	image_alpha = clamp(image_alpha - 0.01, 0, 1);
	if image_alpha == 0{
		disapear = true
		// moves invisable fish away from water
		x = 0
		y = -700
	}
	// 10 second timer
	if disapear{
		if (counter == 600)
		{
			show_debug_message("here")
			path_start(p_fish, 1, path_action_continue, true);
			//start at a random position on the path
			path_position = random_range(0,1)
		    counter = 0;
			disapear = false
			fade = false
			
		}
		else counter++;
	}
}
//fade fish back in
else image_alpha = clamp(image_alpha + 0.01, 0, 1);



