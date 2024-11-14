{{- define "hub.labels" -}}
app: {{ include "hub.name" . }}
owner: {{ $.Values.global.hub.owner | quote }}
project: {{ $.Values.werf.name | quote }}
date: {{ now | htmlDate | quote }}
{{ end }}

{{- define "hub.name" -}}
    {{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}