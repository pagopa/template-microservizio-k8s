{{/*
Expand the name of the chart.
*/}}
{{- define "microservice-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "microservice-chart.fullname" -}}
{{- if .Values.fullnameOverride }}

{{- if .Values.canaryDelivery.create }}
{{- printf "%s-beta"  .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- else }}
{{- if .Values.canaryDelivery.create }}
{{- printf "%s-beta" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "microservice-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name (.Values.image.tag | default .Chart.Version) | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "microservice-chart.labels" -}}
helm.sh/chart: {{ include "microservice-chart.chart" . }}
{{ include "microservice-chart.selectorLabels" . }}
{{- include "microservice-chart.extraLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Extra labels
*/}}
{{- define "microservice-chart.extraLabels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ (.Values.image.tag | default .Chart.AppVersion) | quote }}
{{- end }}
{{- end }}




{{/*
Selector labels
*/}}
{{- define "microservice-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "microservice-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "microservice-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "microservice-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
