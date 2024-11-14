{{- define "hub.image" -}}
    {{ get $.Values.werf.image $.Chart.Name -}}
{{ end -}}

{{- define "hub.domain" -}}
    {{ printf "%s.%s" .Values.werf.name  .Values.global.rootDomain | trunc 63 | trimSuffix "-"  | lower }}
{{ end -}}

{{- define "hub.initcontainers" -}}
{{- range $index, $container := .Values.initContainers }}
{{- with $container }}
- name: {{ .name }}
  image: {{ .image }}
  command: {{ .command -}}
{{ end -}}
{{ end -}}
{{ end -}}



