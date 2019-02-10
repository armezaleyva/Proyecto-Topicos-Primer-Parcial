Shader "Custom/RimLighting"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor ("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower ("Rim Power", Range(0.5, 8.0)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        float4 _RimColor;
    	float _RimPower;
        half4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color.rgb;
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
         	o.Emission = _RimColor.rgb * pow (rim, _RimPower);
        }
        ENDCG
    }
}
