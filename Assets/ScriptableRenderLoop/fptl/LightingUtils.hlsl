#ifndef __LIGHTINGUTILS_H__
#define __LIGHTINGUTILS_H__


#include "..\common\ShaderBase.h"
#include "LightDefinitions.cs.hlsl"


uniform float4x4 g_mViewToWorld;
uniform float4x4 g_mWorldToView;        // used for reflection only
uniform float4x4 g_mScrProjection;
uniform float4x4 g_mInvScrProjection;


uniform uint g_widthRT;
uniform uint g_heightRT;


float3 GetViewPosFromLinDepth(float2 v2ScrPos, float fLinDepth)
{
    float fSx = g_mScrProjection[0].x;
    //float fCx = g_mScrProjection[2].x;
    float fCx = g_mScrProjection[0].z;
    float fSy = g_mScrProjection[1].y;
    //float fCy = g_mScrProjection[2].y;
    float fCy = g_mScrProjection[1].z;

#ifdef LEFT_HAND_COORDINATES
    return fLinDepth*float3( ((v2ScrPos.x-fCx)/fSx), ((v2ScrPos.y-fCy)/fSy), 1.0 );
#else
    return fLinDepth*float3( -((v2ScrPos.x+fCx)/fSx), -((v2ScrPos.y+fCy)/fSy), 1.0 );
#endif
}

float GetLinearZFromSVPosW(float posW)
{
#ifdef LEFT_HAND_COORDINATES
    float linZ = posW;
#else
    float linZ = -posW;
#endif

    return linZ;
}

float GetLinearDepth(float zDptBufSpace)    // 0 is near 1 is far
{
	// todo (simplify): m22 is zero and m23 is +1/-1 (depends on left/right hand proj)
	float m22 = g_mInvScrProjection[2].z, m23 = g_mInvScrProjection[2].w;
    float m32 = g_mInvScrProjection[3].z, m33 = g_mInvScrProjection[3].w;

	return (m22*zDptBufSpace+m23) / (m32*zDptBufSpace+m33);

    //float3 vP = float3(0.0f,0.0f,zDptBufSpace);
    //float4 v4Pres = mul(g_mInvScrProjection, float4(vP,1.0));
    //return v4Pres.z / v4Pres.w;
}



float3 OverlayHeatMap(uint numLights, float3 c)
{
    /////////////////////////////////////////////////////////////////////
    //
    const float4 kRadarColors[12] =
    {
        float4(0.0,0.0,0.0,0.0),   // black
        float4(0.0,0.0,0.6,0.5),   // dark blue
        float4(0.0,0.0,0.9,0.5),   // blue
        float4(0.0,0.6,0.9,0.5),   // light blue
        float4(0.0,0.9,0.9,0.5),   // cyan
        float4(0.0,0.9,0.6,0.5),   // blueish green
        float4(0.0,0.9,0.0,0.5),   // green
        float4(0.6,0.9,0.0,0.5),   // yellowish green
        float4(0.9,0.9,0.0,0.5),   // yellow
        float4(0.9,0.6,0.0,0.5),   // orange
        float4(0.9,0.0,0.0,0.5),   // red
        float4(1.0,0.0,0.0,0.9)    // strong red
    };

    float maxNrLightsPerTile = 31;



    int nColorIndex = numLights==0 ? 0 : (1 + (int) floor(10 * (log2((float)numLights) / log2(maxNrLightsPerTile))) );
    nColorIndex = nColorIndex<0 ? 0 : nColorIndex;
    float4 col = nColorIndex>11 ? float4(1.0,1.0,1.0,1.0) : kRadarColors[nColorIndex];

    return lerp(c, pow(col.xyz, 2.2), 0.3*col.w);
}



#endif
