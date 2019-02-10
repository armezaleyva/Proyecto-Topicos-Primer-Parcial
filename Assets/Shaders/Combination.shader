Shader "Custom/Combination"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor ("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower ("Rim Power", Range(0.5, 8.0)) = 1
        _Spec("Specular", Range(0, 1)) = 0.5
		_Gloss("Gloss", Range(0, 1)) = 0.5
		_SpecColor("SpecColor", Color) = (1, 1, 1, 1)
        _BumpTex("Normal", 2D) = "bump" {}
		_NormalAmount("Normal Amount", Range(-3, 3)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf BlinnPhong

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpTex;
            float3 viewDir;
        };

        half4 _Color;

        float4 _RimColor;
    	float _RimPower;
        
        half _Spec;
		fixed _Gloss;

        float _NormalAmount;
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color.rgb;

            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
         	o.Emission = _RimColor.rgb * pow (rim, _RimPower);

            o.Specular = _Spec;
			o.Gloss = _Gloss;

            float3 normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
			normal.z = normal.z / _NormalAmount;
			o.Normal = normal;
        }
        ENDCG
    }
}
