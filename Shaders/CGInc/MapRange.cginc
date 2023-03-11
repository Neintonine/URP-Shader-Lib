#ifndef HAS_INCLUDED_COMMON
    #include "Common.cginc"
#endif

void MapRange_half(
    half value,
    half min1,
    half max1,
    half min2,
    half max2,
    out half result
)
{
    result = MapRange(value, min1, max1, min2, max2);
}

void MapRange_float(
    float value,
    float min1,
    float max1,
    float min2,
    float max2,
    out float result
)
{
    result = MapRange(value, min1, max1, min2, max2);
}
