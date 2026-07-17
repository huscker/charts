{{/*
Return the fully qualified backend name.
*/}}
{{- define "townsquare.backend.fullname" -}}
{{- printf "%s-backend" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
