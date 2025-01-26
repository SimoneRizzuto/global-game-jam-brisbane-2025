shader_type spatial;
render_mode cull_disabled;




uniform sampler2D normal;
uniform vec3 color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 pos = (INV_VIEW_MATRIX * vec4(VERTEX,1.)).xyz;

	vec2 coords = pos.xz*0.5;
	NORMAL_MAP = mix(mix(texture(normal,coords*0.15-TIME*0.005).xyz,texture(normal,coords*0.2+TIME*0.01).xyz,0.5),vec3(0.5,0.5,1.),0.8);
	ROUGHNESS = 0.1;
	METALLIC = 0.5;
	ALBEDO = color;
	vec3 viewVector = normalize(pos-CAMERA_POSITION_WORLD);

	float d = clamp((length(CAMERA_POSITION_WORLD-pos)-0.08)/0.05,0.,1.);

	
	//ALPHA = d;//clamp((-abs(-viewVector.y*NORMAL_MAP.z*0.5)+0.8)*2.,0.5,1.)*d;


}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
