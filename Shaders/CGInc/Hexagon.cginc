#ifndef S_Y
#define S_Y 1.732050807568877
#endif

float4 getHexInfo_float(float2 uv) {
    const float2 s = float2(1.0, S_Y);
    float4 hexCenter = round(float4(uv, uv - float2(0.5, 1.0)) / s.xyxy);
    float4 offset = float4(uv - hexCenter.xy * s, uv - (hexCenter.zw + .5) * s);
    //result = float4(0,0,0,1);
    return dot(offset.xy, offset.xy) < dot(offset.zw, offset.zw) ? float4(offset.xy, hexCenter.xy) : float4(offset.zw, hexCenter.zw);
}

float getHexDistance_float(float2 hexPoint) {
    const float2 s = float2(1.0, S_Y);
    float2 p = abs(hexPoint);
    return max(dot(p, s * .5), p.x);
}

void Hexagon_float(float2 uv, out float distance, out float2 hexCenter, out float2 coordante) {
    float4 info = getHexInfo_float(uv);
    coordante = info.xy;
    hexCenter = info.zw;
    distance = getHexDistance_float(coordante);
}

half4 getHexInfo_half(half2 uv) {
	
    const half2 s = half2(1.0, S_Y);
    half4 hexCenter = round(half4(uv, uv - half2(0.5, 1.0)) / s.xyxy);
    half4 offset = half4(uv - hexCenter.xy * s, uv - (hexCenter.zw + .5) * s);
    //result = float4(0,0,0,1);
    return dot(offset.xy, offset.xy) < dot(offset.zw, offset.zw) ? half4(offset.xy, hexCenter.xy) : half4(offset.zw, hexCenter.zw);
}

half getHexDistance_half(half2 hexPoint) {
    const half2 s = half2(1.0, S_Y);
    half2 p = abs(hexPoint);
    return max(dot(p, s * .5), p.x);
}

void Hexagon_half(half2 uv, out half distance, out half2 hexCenter, out half2 coordante) {
    half4 info = getHexInfo_half(uv);
    coordante = info.xy;
    hexCenter = info.zw;
    distance = getHexDistance_half(coordante);

}