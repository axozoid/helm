

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "generic.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.appName }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "generic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "generic.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/appName: {{ include "generic.fullname" . }}
app.kubernetes.io/release: {{ .Release.Name }}
{{- end }}

{{/*
Extra labels for services
*/}}
{{- define "generic.extraServiceLabels" -}}
{{- if .Values.extraServiceLabels }}
{{- toYaml .Values.extraServiceLabels }}
{{- end }}
{{- end }}

{{/*
Extra labels for pods
*/}}
{{- define "generic.extraPodLabels" -}}
{{- if .Values.extraPodLabels }}
{{- toYaml .Values.extraPodLabels }}
{{- end }}
{{- end }}

{{/*
Prometheus annotations
*/}}
{{- define "generic.metrics" -}}
prometheus.io/scrape: "true"
prometheus.io/port: {{ .Values.metrics.port | quote }}
prometheus.io/path: {{ .Values.metrics.path | quote}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "generic.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "generic.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
