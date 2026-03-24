shader_type canvas_item;

uniform vec4 original_main_color: source_color;
uniform vec4 original_shaded_color: source_color;
uniform vec4 original_highlight_color: source_color;
uniform vec4 original_outline_color: source_color;
uniform vec4 new_main_color: source_color;
uniform vec4 new_shaded_color: source_color;
uniform vec4 new_highlight_color: source_color;
uniform vec4 new_outline_color: source_color;
uniform bool show_outline;

const float precision = 0.1;

void vertex() {
	// Called for every vertex the material is visible on.
}

vec4 swap_color( vec4 color) {
  if ( distance( color, original_main_color ) <= precision ) {
    return new_main_color;
  }
  if ( distance( color, original_shaded_color ) <= precision ) {
    return new_shaded_color;
  }
  if ( distance( color, original_highlight_color ) <= precision ) {
    return new_highlight_color;
  }
  
  if (show_outline) {
    if ( distance( color, original_outline_color ) <= precision ) {
      return new_outline_color;
    }
  }
  
  return color;
}

void fragment() {
	COLOR = swap_color( texture( TEXTURE, UV ));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
