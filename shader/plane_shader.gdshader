shader_type spatial;
render_mode unshaded;

uniform sampler2D gradient;
uniform vec3 lightPos = vec3(-2.7, 2.097, 0.0);
// sorry i need a way to get the light obj's position still.
// be careful of floating point values, it failed earlier bc of that :(

varying vec3 normal; // varying to pass the var from vertex to frag
// https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/shading_language.html#varyings
varying vec3 lightVector;
varying vec3 world_position;

void vertex(){
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	// got ^ from https://www.reddit.com/r/godot/comments/gok070/need_help_getting_world_coordinates_in_shader/
	normal = normalize(NORMAL);
	//lightVector = normalize(vec3(lightPos.x - world_position.x, lightPos.y - world_position.y, lightPos.z - world_position.z));
	lightVector = normalize(vec3(lightPos.x - NODE_POSITION_WORLD.x, lightPos.y - NODE_POSITION_WORLD.y, lightPos.z - NODE_POSITION_WORLD.z));
	
}

void fragment() {
	//float dotProduct = dot(lightVector, vec3(0, 0, 1));
	float dotProduct = dot(lightVector, normal);
	ALBEDO = texture(gradient, vec2(dotProduct, 0.0)).rgb;
	// got help from https://www.gdquest.com/tutorial/godot/shaders/gradient-map/
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
