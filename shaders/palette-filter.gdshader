shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec4 old_dark : source_color = vec4(0, 0, 0, 1);
uniform vec4 old_light : source_color = vec4(1, 1, 1, 1);
uniform vec4 old_primary : source_color = vec4(1, 0, 0, 1);
uniform vec4 old_secondary : source_color = vec4(0, 0, 1, 1);

uniform vec4 new_dark : source_color = vec4(0, 0, 0, 1);
uniform vec4 new_light : source_color = vec4(1, 1, 1, 1);
uniform vec4 new_primary : source_color = vec4(1, 0, 0, 1);
uniform vec4 new_secondary : source_color = vec4(0, 0, 1, 1);

void fragment() {
	vec4 color = textureLod(screen_texture, SCREEN_UV, 0.0);

	if (color == old_dark) COLOR = new_dark;
	else if (color == old_light) COLOR = new_light;
	else if (color == old_primary) COLOR = new_primary;
	else if (color == old_secondary) COLOR = new_secondary;
	else COLOR = color;
}
