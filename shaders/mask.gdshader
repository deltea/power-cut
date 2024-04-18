shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	COLOR.a = texture(TEXTURE, UV).a;
}