#ifndef PI
    #define PI 3.1415926536
#endif

float bellFunction(float x)
{
    return (sin(2 * PI * (x - 0.25)) + 1) / 2;
}

void handleFraction_float(float value, out float resFrac, out float resSign)
{
    float valScaled = value / 2;
    resFrac = bellFunction(frac(valScaled));
    resSign = sign(frac(valScaled/2) - .5);
}


void Checkerboard_float(float3 pos, out float checkerboard)
{
    float xFrac, xSign, yFrac,ySign, zFrac, zSign;

    handleFraction_float(pos.x, xFrac, xSign);
    handleFraction_float(pos.y, yFrac, ySign);
    handleFraction_float(pos.z, zFrac, zSign);

    float frac = min(min(xFrac, yFrac), zFrac);
    float sign = xSign * ySign * zSign;

    checkerboard = saturate(sign * frac);
}