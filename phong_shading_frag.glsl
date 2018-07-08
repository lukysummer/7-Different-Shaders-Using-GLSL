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

  // normalize normalInterp 
  vec3 N = normalize(normalInterp);
  
  // light direction (s vector)
  vec3 L = normalize(lightPos - vertPos);
  
  // reflected ray direction (r = -s + 2*dot(N, L)*N)
  vec3 R = normalize(-L + 2.0*dot(N,L)*N);
  
  // camera direction
  vec3 B = normalize(viewVec);
  
  // 1. Ambient Component: included in "gl_FragColor" variable below
  
  // 2. Diffuse Component 
  // get lambertian
  float lambertian = max(dot(L,N), 0.0);
  
  // 3. Specular Component 
  // specular factor
  float specular = max(dot(R,B), 0.0);
  float specular_factor = pow(specular, shininessVal);  
  
  gl_FragColor = vec4(Ka * ambientColor  +  Kd * lambertian * diffuseColor  +  Ks * specular_factor * specularColor, 1.0);
}
