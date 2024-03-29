#version 400

uniform vec3 kd;
uniform vec3 ks;
uniform vec3 lightPos;
uniform float shininess;
uniform vec3 lightColor;
uniform bool enableLighting;

in vec3 positionForFP;
in vec3 normalForFP;

out vec4 fragColor;


void main(void) {
  vec3 rgb = kd;
  	if ( enableLighting ) {
  		vec3 lightDirection = normalize( lightPos - positionForFP );
  		float diffuse = max( dot( normalForFP, lightDirection), 0 );
  		vec3 viewDirection = normalize( - positionForFP );
  		vec3 halfVector = normalize( lightDirection + viewDirection );
  		float specular = max( 0, dot( normalForFP, halfVector ) );
  		if (diffuse == 0.0) {
  		    specular = 0.0;
  		} else {
  	   		specular = pow( specular, shininess );
  		}
  		vec3 scatteredLight = kd * lightColor * diffuse;
  		vec3 reflectedLight = ks * lightColor * specular;
  	    rgb = min( scatteredLight + reflectedLight, vec3(1,1,1) );
   	}
  	fragColor = vec4( rgb ,1 );
}