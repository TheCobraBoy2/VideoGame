#version 330

in vec2 fragTexCoord;
in vec4 fragColor;

uniform sampler2D texture0;
uniform float blurSize;

out vec4 finalColor;

void main() {
  vec2 texel = 1.0 / textureSize(texture0, 0);

  vec2 s = texel * blurSize;

  vec4 sum = vec4(0.0);

  sum += texture(texture0, fragTexCoord + s * vec2(-4, 0)) * 0.05;
  sum += texture(texture0, fragTexCoord + s * vec2(-3, 0)) * 0.09;
  sum += texture(texture0, fragTexCoord + s * vec2(-2, 0)) * 0.12;
  sum += texture(texture0, fragTexCoord + s * vec2(-1, 0)) * 0.15;
  sum += texture(texture0, fragTexCoord)                     * 0.16;
  sum += texture(texture0, fragTexCoord + s * vec2( 1, 0)) * 0.15;
  sum += texture(texture0, fragTexCoord + s * vec2( 2, 0)) * 0.12;
  sum += texture(texture0, fragTexCoord + s * vec2( 3, 0)) * 0.09;
  sum += texture(texture0, fragTexCoord + s * vec2( 4, 0)) * 0.05;

  finalColor = sum;
}
