Shader "Custom/WoodFloorShader"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _DetailTex ("Detail Map", 2D) = "white" {}
        _DetailScale ("Detail Scale", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _DetailTex;
        half _Glossiness;
        half _Metallic;
        half _DetailScale;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float2 uv_DetailTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half4 tex = tex2D(_MainTex, IN.uv_MainTex);
            half3 normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
            half4 detail = tex2D(_DetailTex, IN.uv_DetailTex * _DetailScale);
            o.Albedo = tex.rgb * detail.rgb;
            o.Normal = normal;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
