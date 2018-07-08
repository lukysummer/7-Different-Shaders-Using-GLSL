precision mediump float; // It is required to set a floating point precision in all fragment shaders.

// Interpolated values from vertex shader
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Interpolated view vector

// uniform values remain the same across the scene
uniform float Ka;   // Ambient reflection coefficient
uniform float Kd;   // Diffuse reflection coefficient
uniform float Ks;   // Specular reflection coefficient
uniform float shininessVal; // Shininess

// Material color
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;

uniform vec3 lightPos; // Light position in camera space

// HINT: Use the built-in variable gl_FragCoord to get the screen-space coordinates


void main() {

  // normalize normalInterp 
  vec3 N = normalize(normalInterp);
  
  // light direction (s vector)
  vec3 L = normalize(lightPos - vertPos);

  // Diffuse Component 
  float lambertian = max(dot(L,N), 0.0);
  
  float frequency = 10.0;
  vec2 newCoord = mat2(0.707, -0.707, 0.707, 0.707) * gl_FragCoord.xy;
  vec2 nearest = 2.0*fract(frequency * newCoord) - 1.0;
  float dist = length(nearest);
  vec3 black = vec3(0.0, 0.0, 0.0);
  
  if(lambertian < 0.12){ 
    float radius = 1.1; 
    vec3 fragcolor = mix(black, diffuseColor, step(radius, dist));
    gl_FragColor = vec4(fragcolor, 1.0);
  }
  
  else if(lambertian < 0.17) {
    float radius = 1.0;
    vec3 fragcolor = mix(black, diffuseColor, step(radius, dist));
    gl_FragColor = vec4(fragcolor, 1.0);
  }
  
  else if(lambertian < 0.6){
    float radius = 0.5;
    vec3 fragcolor = mix(black, diffuseColor, step(radius, dist));
    gl_FragColor = vec4(fragcolor, 1.0);
  }
  
  else if(lambertian < 0.7){
    float radius = 0.35;
    vec3 fragcolor = mix(black, diffuseColor, step(radius, dist));
    gl_FragColor = vec4(fragcolor, 1.0);
  }
  
  else{
    float radius = 0.2;
    vec3 fragcolor = mix(black, diffuseColor, step(radius, dist));
	gl_FragColor = vec4(fragcolor, 1.0);
	
  }

  // no specular component
}