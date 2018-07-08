// Vertex shader template for the bonus question

attribute vec3 position; // Given vertex position in object space
attribute vec3 normal; // Given vertex normal in object space
attribute vec3 worldPosition; // Given vertex position in world space

uniform mat4 projection, modelview, normalMat; // Given scene transformation matrices
uniform vec3 eyePos;	// Given position of the camera/eye/viewer

// These will be given to the fragment shader and interpolated automatically
// NOTE: You may need to edit this section to add additional variables
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Vector from the eye to the vertex

varying vec4 color;
varying vec2 tcoord;

void main(){

  vec4 vertPos4 = modelview * vec4(position, 1.0);
  gl_Position = projection * vertPos4;
  
  vertPos = vec3(vertPos4) / vertPos4.w;
  viewVec = -vertPos;
  
  normalInterp = vec3(normalMat * vec4(normal, 0.0));
 
   // pass on normal to fragment shader
  normalInterp = vec3(normalMat * vec4(normal, 0.0)); 
  
  vec4 vertPos4 = modelview * vec4(position, 1.0);
  gl_Position = projection * vertPos4;
  
  vertPos = vec3(vertPos4) / vertPos4.w;
  viewVec = -vertPos;
  
  // normalize normalInterp 
  vec3 N = normalize(normalInterp);
  
  // light direction (s vector)
  vec3 L = normalize(lightPos - vertPos);
  
  // reflected ray direction (r = -s + 2*dot(N, L)*N)
  vec3 R = normalize(-L + 2.0*dot(N,L)*N);
  
  // camera direction
  vec3 B = normalize(viewVec);
  
  
  // 1. Ambient Component: included in "color" variable below
  
  // 2. Diffuse Component 
  // get lambertian
  float lambertian = max(dot(L,N), 0.0);
  
  // 3. Specular Component 
  // specular factor
  float specular = max(dot(R,B), 0.0);
  float specular_factor = pow(specular, shininessVal);
    

  // pass on color to fragment shader  
  color = vec4(Ka * ambientColor  +  Kd * lambertian * diffuseColor  +  Ks * specular_factor * specularColor, 1.0);
}
