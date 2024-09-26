{{/*
Create a default fully qualified domain name
*/}}
{{- define "desafio-jack.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "desafio-jack.labels" -}}
app.kubernetes.io/name: {{ include "desafio-jack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "desafio-jack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "desafio-jack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Chart name
*/}}
{{- define "desafio-jack.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Service Account Name
*/}}
{{- define "desafio-jack.serviceAccountName" -}}
{{- if .Values.serviceAccount.name -}}
{{ .Values.serviceAccount.name }}
{{- else -}}
{{ .Release.Name }}-{{ .Chart.Name }}-sa
{{- end -}}
{{- end -}}


