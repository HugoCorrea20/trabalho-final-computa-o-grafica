Shader "Custom/WindowReflectionShader"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _ReflectionTex ("Reflection (RGB)", 2D) = "black" {}
        _Transparency ("Transparency", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        sampler2D _MainTex;
        sampler2D _ReflectionTex;
        float _Transparency;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldRefl;
            INTERNAL_DATA
        };

        half4 LightingStandard (SurfaceOutputStandard s, half3 lightDir, half atten)
        {
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (atten * 2);
            c.a = s.Alpha;
            return c;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half4 tex = tex2D(_MainTex, IN.uv_MainTex);
            half4 refl = tex2D(_ReflectionTex, IN.uv_MainTex);

            o.Albedo = tex.rgb;
            o.Emission = refl.rgb;
            o.Alpha = tex.a * _Transparency;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
