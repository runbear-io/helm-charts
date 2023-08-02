{{/*
Expand the name of the chart.
*/}}
{{- define "runbear-worker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "runbear-worker.fullname" -}}
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
{{- define "runbear-worker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "runbear-worker.labels" -}}
helm.sh/chart: {{ include "runbear-worker.chart" . }}
{{ include "runbear-worker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "runbear-worker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "runbear-worker.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "runbear-worker.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "runbear-worker.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return secret name to be used based on provided values.
*/}}
{{- define "runbear-worker.apiSecretSecretName" -}}
{{- $fullName := printf "%s-api-secret" (include "runbear-worker.fullname" .) -}}
{{- default $fullName .Values.runbear.apiSecretExistingSecret | quote -}}
{{- end -}}

{{/*
Role name of worker
*/}}
{{- define "runbear-worker.roleName" -}}
{{- if and .Values.rbac.create }}
{{- default (include "runbear-worker.fullname" .) .Values.rbac.roleName }}
{{- else }}
{{- default "default" .Values.rbac.existingRoleName }}
{{- end }}
{{- end }}

{{/*
Service account name of executor
*/}}
{{- define "runbear-worker.executorServiceAccountName" -}}
{{- if and .Values.runbear.executor.serviceAccount.create .Values.runbear.executor.serviceAccount.name }}
{{- $fullName := printf "%s-executor" (include "runbear-worker.fullname" .) -}}
{{- default $fullName .Values.runbear.executor.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.runbear.executor.serviceAccount.existingServiceAccountName }}
{{- end }}
{{- end }}
