shader_type canvas_item;
render_mode blend_mix, unshaded;

uniform float radius : hint_range(0.0, 2.0) = 0.8; // где начинается затемнение
uniform float softness : hint_range(0.0, 1.0) = 0.4; // плавность перехода
uniform vec4 edge_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // цвет краёв

void fragment() {
    vec2 viewport_size = vec2(1.0) / SCREEN_PIXEL_SIZE;
    vec2 uv = FRAGCOORD.xy / viewport_size;
    vec2 center = vec2(0.5);

    float dist = distance(uv, center);
    float alpha = smoothstep(radius - softness, radius, dist);

    // В центре прозрачность 0, по краям — 1
    COLOR = vec4(edge_color.rgb, alpha * edge_color.a);
}
