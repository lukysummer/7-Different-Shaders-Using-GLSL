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

void main() {

  // normalize normal vector 
  vec3 N = normalize(normalInterp);
  
  // light direction (s vector)
  vec3 L = normalize(lightPos - vertPos);
  
  // reflected ray direction (r = -s + 2*dot(N, L)*N)
  vec3 R = normalize(-L + 2.0*dot(N,L)*N);
  
  // camera direction
  vec3 B = normalize(viewVec);
  
  // NO Specular or Ambient Components
  
  // Diffuse Component 
  // we want to "see through" a non-transparent object --> behind surfaces not visible by other shading models must be visible
  // thus take absolute value of the dot product to keep all values, instead of eliminating <0 values :
  float lambertian = abs(dot(L,N));
   
  
  gl_FragColor = vec4(Kd * lambertian * diffuseColor, 1.0);
}
