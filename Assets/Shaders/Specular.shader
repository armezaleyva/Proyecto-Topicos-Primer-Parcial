Shader "Custom/Specular"
{
    Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Albedo", Color) = (1, 1, 1, 1)
		_Spec("Specular", Range(0, 1)) = 0.5
		_Gloss("Gloss", Range(0, 1)) = 0.5
		_SpecColor("SpecColor", Color) = (1, 1, 1, 1)
	}

	SubShader
	{
		CGPROGRAM

		#pragma surface surf BlinnPhong

		sampler2D _MainTex;
		half4 _Color;

		half _Spec;
		fixed _Gloss;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color.rbg;

			o.Specular = _Spec;
			o.Gloss = _Gloss;
		}

		ENDCG
	}

}
