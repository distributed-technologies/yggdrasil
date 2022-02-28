{{/* returns a list of environment variables that is needed to use the ceph bucket-claim */}}
{{- define "bucket-claim.env-var" -}}
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

{{/* Returns the KV pairs that is used for Cortex storage config */}}
{{- define "cortex.s3.config" -}}
bucket_name: ${BUCKET_NAME}
endpoint: ${BUCKET_HOST}
region: ${BUCKET_REGION}
access_key_id: ${AWS_ACCESS_KEY_ID}
secret_access_key: ${AWS_SECRET_ACCESS_KEY}
insecure: true
{{- end }}
