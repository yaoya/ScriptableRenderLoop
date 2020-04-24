using UnityEngine.Experimental.Rendering.HDPipeline;

namespace UnityEditor.Experimental.Rendering
{
    class SerializedRenderPipelineSettings
    {
        public SerializedProperty root;

        public SerializedProperty supportShadowMask;
        public SerializedProperty supportSSR;
        public SerializedProperty supportSSAO;
        public SerializedProperty supportDBuffer;
        public SerializedProperty supportMSAA;
        public SerializedProperty MSAASampleCount;
        public SerializedProperty supportSubsurfaceScattering;
        public SerializedProperty supportOnlyForward;
        public SerializedProperty supportMotionVectors;
        public SerializedProperty supportStereo;
        public SerializedProperty enableUltraQualitySSS;
        public SerializedProperty supportVolumetric;

        public SerializedGlobalLightLoopSettings lightLoopSettings;
        public SerializedShadowInitParameters shadowInitParams;
        public SerializedGlobalDecalSettings decalSettings;

        public SerializedRenderPipelineSettings(SerializedProperty root)
        {
            this.root = root;

            supportShadowMask = root.Find((RenderPipelineSettings s) => s.supportShadowMask);
            supportSSR = root.Find((RenderPipelineSettings s) => s.supportSSR);
            supportSSAO = root.Find((RenderPipelineSettings s) => s.supportSSAO);
            supportDBuffer = root.Find((RenderPipelineSettings s) => s.supportDBuffer);
            supportMSAA = root.Find((RenderPipelineSettings s) => s.supportMSAA);
            MSAASampleCount = root.Find((RenderPipelineSettings s) => s.msaaSampleCount);
            supportSubsurfaceScattering = root.Find((RenderPipelineSettings s) => s.supportSubsurfaceScattering);
            supportOnlyForward = root.Find((RenderPipelineSettings s) => s.supportOnlyForward);
            supportMotionVectors = root.Find((RenderPipelineSettings s) => s.supportMotionVectors);
            supportStereo = root.Find((RenderPipelineSettings s) => s.supportStereo);
            enableUltraQualitySSS = root.Find((RenderPipelineSettings s) => s.enableUltraQualitySSS);
            supportVolumetric = root.Find((RenderPipelineSettings s) => s.supportVolumetric);

            lightLoopSettings = new SerializedGlobalLightLoopSettings(root.Find((RenderPipelineSettings s) => s.lightLoopSettings));
            shadowInitParams = new SerializedShadowInitParameters(root.Find((RenderPipelineSettings s) => s.shadowInitParams));
            decalSettings = new SerializedGlobalDecalSettings(root.Find((RenderPipelineSettings s) => s.decalSettings));
        }
    }
}
