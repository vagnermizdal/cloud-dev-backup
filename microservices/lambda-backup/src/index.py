import boto3
import urllib.parse
import os

s3 = boto3.client('s3')

# Configurações
backup_bucket = os.getenv("BUCKET_BACKUP", None)

def lambda_handler(event, context):
    # Extraindo informações do evento
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    # Copia o objeto do bucket de origem para o bucket de backup
    copy_source = {'Bucket': bucket_name, 'Key': object_key}
    s3.copy_object(CopySource=copy_source, Bucket=backup_bucket, Key=object_key)

    return {
        'statusCode': 200,
        'body': 'Backup realizado com sucesso!'
    }