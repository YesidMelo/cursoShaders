//01-> indica la ubicacion en el buscador de unity para los shaders (NombrePaquete/NombreShaderParaBuuscadorUnity)
Shader "Custom/SolidColor"
{
    //02 -> aqui encontraremos los parametros de entrada para el editor de unity
    Properties
    {
        _Color("Tint",Color)=(1, 1, 1, 1)
    }
    
    //03 -> aqui se definira los elementos relacionados con el comportamiento del shader
    SubShader
    {
        
        Pass {

            // aqui se procesa el comportamiento del shader
            CGPROGRAM
            //Codigo CG aqui
            //PRAGMAS
            // Compila las funciones necesarias para el funcionamiento del shader
            // si no se define el pragma no cargara el shader
            #pragma vertex vertexShader //<- Funcion abajo definida
            #pragma fragment fragmentShader //<- Funcion abajo definida

            uniform fixed4 _Color;

            //Vertex input
            struct vertexInput {
                fixed4 vertex : POSITION;
            };

            //Vertex Output
            struct vertexOutput {
                fixed4 position: SV_POSITION;
                fixed4 color: COLOR;
            };

            //Vertex Shader
            vertexOutput vertexShader(vertexInput i) {
                vertexOutput o;
                o.position = UnityObjectToClipPos(i.vertex);
                o.color = _Color;
                return o;
            };

            //Fragment Shader
            // fixed4 fragmentShader(vertexOutput o) : SV_TARGET{
            //     return o.color;
            // };
            struct  pixelOutput
            {
                fixed4 pixel : SV_TARGET;
            };

            pixelOutput fragmentShader(vertexOutput o) {
                pixelOutput p;
                p.pixel = o.color;
                return p;
            };

            ENDCG
        }
    }
    Fallback "Mobile/VertexLit"
}