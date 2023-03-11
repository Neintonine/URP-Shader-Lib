#define HAS_INCLUDED_COMMON_HALF

half MapRange(half value, half min1, half max1, half min2, half max2)
{
    return ((value - min1) / (max1 - min1)) * (max2 - min2) + min2;
}

half2 hhalf2(half xy)
{
    return half2(xy,xy);
}

half3 hhalf3(half2 v)
{
    return half3(v.x, v.y, 0);
}
half3 hhalf3(half2 v, half z)
{
    return half3(v.x, v.y, z);
}
half3 hhalf3(half xyz)
{
    return half3(xyz,xyz,xyz);
}
half4 hhalf4(half2 v)
{
    return half4(v.x, v.y,0,0);
}
half4 hhalf4(half2 v, half z)
{
    return half4(v.x, v.y, z, 0);
}
half4 hhalf4(half2 v, half z, half w)
{
    return half4(v.x, v.y, z, w);
}
half4 hhalf4(half3 v)
{
    return half4(v.x, v.y, v.z, 0);
}
half4 hhalf4(half3 v, half w)
{
    return half4(v.x, v.y, v.z, w);
}
half4 hhalf4(half xyzw)
{
    return half4(xyzw,xyzw,xyzw,xyzw);
}