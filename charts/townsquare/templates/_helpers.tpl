{{/*
Return the proper frontend image name.
*/}}
{{- define "townsquare.frontend.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.frontend.image "global" .Values.global "chart" .Chart) }}
{{- end -}}

{{/*
Return the proper backend image name.
*/}}
{{- define "townsquare.backend.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.backend.image "global" .Values.global "chart" .Chart) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names.
*/}}
{{- define "townsquare.imagePullSecrets" -}}
{{ include "common.images.renderPullSecrets" (dict "images" (list .Values.frontend.image .Values.backend.image) "context" $) }}
{{- end -}}

{{/*
Return the service account name.
*/}}
{{- define "townsquare.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
