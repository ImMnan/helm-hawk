{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-rag_vLLM.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "helm-rag_vLLM.fullname" -}}
{{- default .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "helm-rag_vLLM.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
    {{- default (include "helm-rag_vLLM.fullname" .) .Values.serviceAccount.name -}}
{{- else }}
    {{- default "default" .Values.serviceAccount.name -}}
{{- end }}
{{- end }}
{{/*
Common labels
*/}}
{{- define "helm-rag_vLLM.labels" -}}
helm.sh/chart: {{ include "helm-rag_vLLM.chart" . }}
{{ include "helm-rag_vLLM.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helm-rag_vLLM.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-rag_vLLM.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
