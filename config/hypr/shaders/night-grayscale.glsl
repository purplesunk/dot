#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

/* ---------- Fixed settings (no uniforms) ---------- */
const int   GRAY_TYPE        = 0;      // 0=LUMINOSITY, 1=LIGHTNESS, 2=AVERAGE
const int   LUMA_STANDARD    = 2;      // 0=PAL, 1=HDTV, 2=HDR
const float BLUE_REDUCE      = 0.2;    // 20 % blue reduction
const float TEMPERATURE_K    = 2600.0; // kelvin
const float TEMPERATURE_STR  = 1.0;    // full strength

/* Helper: temperature → RGB multiplier (same as before) */
vec3 temperatureToRGB(float T) {
    mat3 m = (T <= 6500.0)
        ? mat3(vec3(0.0, -2902.1955373783176, -8257.7997278925690),
               vec3(0.0, 1669.5803561666639, 2575.2827530017594),
               vec3(1.0, 1.3302673723350029, 1.8993753891711275))
        : mat3(vec3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
               vec3(-2666.3474220535695, -2173.1012343082230, 2575.2827530017594),
               vec3(0.55995389139931482, 0.70381203140554553, 1.8993753891711275));

    vec3 t = vec3(clamp(T, 1000.0, 40000.0));
    vec3 rgb = clamp(m[0] / (t + m[1]) + m[2], 0.0, 1.0);
    return mix(rgb, vec3(1.0), smoothstep(1000.0, 0.0, T));
}

/* ---------- Main ---------- */
void main() {
    vec4 src = texture(tex, v_texcoord);
    vec3 col = src.rgb;

    /* 1️⃣ Grayscale */
    float gray;
    if (GRAY_TYPE == 0) {                     // LUMINOSITY
        if (LUMA_STANDARD == 0) gray = dot(col, vec3(0.299, 0.587, 0.114));
        else if (LUMA_STANDARD == 1) gray = dot(col, vec3(0.2126, 0.7152, 0.0722));
        else gray = dot(col, vec3(0.2627, 0.6780, 0.0593)); // HDR
    } else if (GRAY_TYPE == 1) {              // LIGHTNESS
        float mx = max(col.r, max(col.g, col.b));
        float mn = min(col.r, min(col.g, col.b));
        gray = (mx + mn) * 0.5;
    } else {                                  // AVERAGE
        gray = (col.r + col.g + col.b) * 0.3333333;
    }
    vec3 grayCol = vec3(gray);

    /* 2️⃣ Blue‑light reduction */
    grayCol.b = mix(grayCol.b, 0.0, clamp(BLUE_REDUCE, 0.0, 1.0));

    /* 3️⃣ Color‑temperature tint */
    vec3 tempMul = temperatureToRGB(TEMPERATURE_K);
    grayCol = mix(grayCol, grayCol * tempMul,
                  clamp(TEMPERATURE_STR, 0.0, 1.0));

    fragColor = vec4(grayCol, src.a);
}

