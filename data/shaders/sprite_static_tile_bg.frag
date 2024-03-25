#version 110
#define PIXEL_ART_FILTER

uniform sampler2D tex;
uniform sampler2D tex_mask;
uniform sampler2D tex_noise;
uniform vec2 tex_size;
uniform vec2 tex_mask_size_world_pixels;
uniform float mask_threshold;
uniform vec2 supersample_size;


// generates a pixel art friendly texture coordinate ala https://csantosbh.wordpress.com/2014/01/25/manual-texture-filtering-for-pixelated-games-in-webgl/
// NOTE: texture filtering mode must be set to bilinear for this trick to work
vec2 pixel_art_filter_uv( vec2 uv, vec2 tex_size_pixels )
{
	const vec2 alpha = vec2(0.08); // 'alpha' affects the size of the smoothly filtered border between virtual (art) pixels.

	uv *= tex_size_pixels;

  	vec2 x = fract(uv);
  	x = clamp(0.5 / alpha * x, 0.0, 0.5) + clamp(0.5 / alpha * (x - 1.0) + 0.5, 0.0, 0.5);
	uv = floor(uv) + x;

	uv /= tex_size_pixels;

	return uv;
}

// reads the mask texture on a pixel art style grid and returns 0 or 1 based on the mask value
float mask_read( vec2 uv )
{
	uv = pixel_art_filter_uv( uv, tex_mask_size_world_pixels ).xy;
	float mask = texture2D( tex_mask, uv ).r;
	return step( mask_threshold, mask );
}

// the naive mask_read would have pretty bad aliasing on the edges
float mask_read_supersample8x( vec2 uv )
{
	// Note( Olli ): this is silly
	// if some math genius has ideas for an analytical anti-aliased implementation, please contact support@nollagames.com.
	// it probably involves fwidth and smoothstep, but dunno.

	// sample in N-rooks pattern - looks clearly better than an even grid
	float s = 0.0;
	s += mask_read( uv + vec2(-4,-4 ) * supersample_size );
	s += mask_read( uv + vec2(-3, 1 ) * supersample_size );
	s += mask_read( uv + vec2(-2, 4 ) * supersample_size );
	s += mask_read( uv + vec2(-1,-2 ) * supersample_size );
	s += mask_read( uv + vec2( 1, 2 ) * supersample_size );
	s += mask_read( uv + vec2( 2,-3 ) * supersample_size );
	s += mask_read( uv + vec2( 3, 3 ) * supersample_size );
	s += mask_read( uv + vec2( 4,-1 ) * supersample_size );
	s *= 0.125;
	return s;
}

void main()
{
	vec2 uv = gl_TexCoord[0].xy;
	vec2 mask_uv = gl_TexCoord[0].zw + vec2(0.007,0.007);

#ifdef PIXEL_ART_FILTER
	vec4 color = texture2D( tex, pixel_art_filter_uv( uv, tex_size ) );
	float mask = mask_read_supersample8x( mask_uv );
#else
	vec4 color = texture2D( tex, uv );
	float mask = mask_read( mask_uv );
#endif

	gl_FragColor = color * gl_Color * mask;
}
