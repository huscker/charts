{{/*
Expand the name of the chart.
*/}}
{{- define "s-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "s-ui.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "s-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "s-ui.labels" -}}
helm.sh/chart: {{ include "s-ui.chart" . }}
{{ include "s-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "s-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "s-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "s-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "s-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "s-ui.image" -}}
{{- $registry := .Values.global.imageRegistry | default .Values.image.registry -}}
{{- $repository := .Values.image.repository -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion | toString -}}
{{- if $registry }}
{{- printf "%s/%s:%s" $registry $repository $tag }}
{{- else }}
{{- printf "%s:%s" $repository $tag }}
{{- end }}
{{- end }}

{{/*
Return the proper imagePullSecrets
*/}}
{{- define "s-ui.imagePullSecrets" -}}
{{- $pullSecrets := list }}
{{- range .Values.global.imagePullSecrets }}
  {{- $pullSecrets = append $pullSecrets . }}
{{- end }}
{{- range .Values.image.pullSecrets }}
  {{- $pullSecrets = append $pullSecrets . }}
{{- end }}
{{- if $pullSecrets }}
imagePullSecrets:
{{- range $pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for the database
*/}}
{{- define "s-ui.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- printf "%s-db" (include "s-ui.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for certificates
*/}}
{{- define "s-ui.certPvcName" -}}
{{- if .Values.certPersistence.existingClaim }}
{{- .Values.certPersistence.existingClaim }}
{{- else }}
{{- printf "%s-cert" (include "s-ui.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the storage class for the PVC
*/}}
{{- define "s-ui.storageClass" -}}
{{- $storageClass := .Values.global.storageClass | default .Values.persistence.storageClass -}}
{{- if $storageClass }}
storageClassName: {{ $storageClass | quote }}
{{- end }}
{{- end }}

{{/*
Return the storage class for the cert PVC
*/}}
{{- define "s-ui.certStorageClass" -}}
{{- $storageClass := .Values.global.storageClass | default .Values.certPersistence.storageClass -}}
{{- if $storageClass }}
storageClassName: {{ $storageClass | quote }}
{{- end }}
{{- end }}
