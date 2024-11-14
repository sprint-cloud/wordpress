
{{- define "app.env" -}}
{{- toYaml $.Values.env  -}}
{{ end -}}

{{- define "app.db.name" -}}
{{ printf "%s-%s" $.Release.Name "mariadb" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "app.db.host" -}}
{{ template "app.db.name" . }}
{{- end -}}

{{- define "app.db.usersecret" -}}
{{ template "app.db.name" . }}
{{- end -}}

{{- define "app.db.user" -}}
{{ $.Values.mariadb.auth.username | quote  }}
{{- end -}}

{{- define "app.db.database" -}}
{{ $.Values.mariadb.auth.database | quote  }}
{{- end -}}

{{- define "app.db.passkey" -}}
{{ "mariadb-password" }}
{{- end -}}