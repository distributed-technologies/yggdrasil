{{- define "bucket-claim.env-var" }}
- name: AWS_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ . }}
      key: AWS_ACCESS_KEY_ID
- name: AWS_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ . }}
      key: AWS_SECRET_ACCESS_KEY
- name: BUCKET_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ . }}
      key: BUCKET_HOST
- name: BUCKET_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ . }}
      key: BUCKET_NAME
- name: BUCKET_REGION
  valueFrom:
    configMapKeyRef:
      name: {{ . }}
      key: BUCKET_REGION
{{- end }}
