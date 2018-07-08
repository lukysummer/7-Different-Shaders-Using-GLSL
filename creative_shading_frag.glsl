
// Fragment shader template for the bonus question

precision mediump float; // It is required to set a floating point precision in all fragment shaders.

// Interpolated values from vertex shader
// NOTE: You may need to edit this section to add additional variables
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Interpolated view vector

// uniform values remain the same across the scene
// NOTE: You may need to edit this section to add additional variables
uniform float Ka;   // Ambient reflection coefficient
uniform float Kd;   // Diffuse reflection coefficient
uniform float Ks;   // Specular reflection coefficient
uniform float shininessVal; // Shininess

// Material color
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;

uniform vec3 lightPos; // Light position in camera space

uniform sampler2D uSampler;	// 2D sampler for the earth texture

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
  // have only 4 discrete values of lambertian
  
  float lambertian = max(dot(L,N), 0.0);
  
  if(lambertian < 0.00005){
	lambertian = 0.4;
  }
  else if(lambertian < 0.005) {
	lambertian = 0.9;
  }
  
  else if(lambertian < 0.01){ // determines the portion of surface area that each of the 4 sections takes up
	lambertian = 0.75; // determines the brightness of each of the 4 sections
  }

  else if(lambertian < 0.1){
	lambertian = 0.65;
  }
  else if(lambertian < 0.15) {
	lambertian = 0.8;
  }
  else if(lambertian < 0.2){
	lambertian = 0.1;
  }
  else if(lambertian < 0.3) {
	lambertian = 0.5;
  }
  else if(lambertian < 0.4){
	lambertian = 0.25;
  }
  else if(lambertian < 0.45) {
	lambertian = 0.88;
  }
  else if(lambertian < 0.5){
	lambertian = 0.619;
  }
  else if(lambertian < 0.55) {
	lambertian = 0.44;
  }
  else if(lambertian < 0.6){
	lambertian = 0.6;
  }
  else if(lambertian < 0.7) {
	lambertian = 0.3;
  }
  else if(lambertian < 0.8){
	lambertian = 0.15;
  }
    else if(lambertian < 0.85) {
	lambertian = 0.98;
  }
  else if(lambertian < 0.9){
	lambertian = 0.619;
  }
  else if(lambertian < 0.95) {
	lambertian = 0.44;
  }
  else{
    lambertian = 0.95;
  }
  
  // 3. Specular Component 
  // specular factor
  float specular = max(dot(R,B), 0.0);
  
  float specular_factor = pow(specular, shininessVal);  
  
  gl_FragColor = vec4(Ka * ambientColor  +  Kd * lambertian * diffuseColor  +  Ks * specular_factor * specularColor, 1.0);
}