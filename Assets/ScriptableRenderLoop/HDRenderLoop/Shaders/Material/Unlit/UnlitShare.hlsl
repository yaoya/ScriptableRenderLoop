// No guard header!

#ifndef SHADERPASS
#error Undefine_SHADERPASS
#endif

//-------------------------------------------------------------------------------------
// Attribute/Varying
//-------------------------------------------------------------------------------------

struct Attributes
{
    float3 positionOS   : POSITION;
    float2 uv0          : TEXCOORD0;
};

struct Varyings
{
    float4 positionHS;
    float2 texCoord0;
};

struct PackedVaryings
{
    float4 positionHS : SV_Position;
    float4 interpolators[1] : TEXCOORD0;
};

PackedVaryings PackVaryings(Varyings input)
{
    PackedVaryings output;
    output.positionHS = input.positionHS;
    output.interpolators[0] = float4(input.texCoord0.xy, 0.0, 0.0);

    return output;
}

FragInput UnpackVaryings(PackedVaryings input)
{
    FragInput output;
    ZERO_INITIALIZE(FragInput, output);

    output.positionHS = input.positionHS;
    output.texCoord0.xy = input.interpolators[0].xy;

    return output;
}

//-------------------------------------------------------------------------------------
// Vertex shader
//-------------------------------------------------------------------------------------

PackedVaryings VertDefault(Attributes input)
{
    Varyings output;

    float3 positionWS = TransformObjectToWorld(input.positionOS);
    output.positionHS = TransformWorldToHClip(positionWS);

    output.texCoord0 = input.uv0;

    return PackVaryings(output);
}
