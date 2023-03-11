Shader "URP Shader Library/Passes/Outline"
{
	Properties
	{
		[HDR] _Color ("Color", Color) = (0,0,0,1)
		_Width ("Width", Range(0, 5)) = 0.03
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Name "OutlinePass"
			Cull Front
			
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float _Width;
			fixed4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;

				float4 clipPosition = UnityObjectToClipPos(v.vertex);
				float3 clipNormal = mul((float3x3) UNITY_MATRIX_VP, mul((float3x3) UNITY_MATRIX_M, v.normal));

				clipPosition.xy += normalize(clipNormal.xy) / _ScreenParams.xy * _Width * clipPosition.w;

				o.vertex = clipPosition;
				
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = _Color;
				return col;
			}
			ENDHLSL
		}
	}
}