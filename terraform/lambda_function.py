import json
import boto3

client = boto3.client('rds')


def lambda_handler(event, context):
    # TODO implement
    # print(event['detail']['dBClusterIdentifier'])
    # print('event', event)
    cluster_identifier = event['detail']['responseElements']['dBClusterIdentifier']
    tags = extract_cluster_tags_from_cluster_identifier(cluster_identifier)
    # print('tags', tags)
    target_arn = event['detail']['responseElements']['dBInstanceArn']
    response = client.add_tags_to_resource(
        ResourceName=target_arn,
        Tags=tags
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


def extract_cluster_tags_from_cluster_identifier(cluster_identifier):
    response = client.describe_db_clusters(
        DBClusterIdentifier=cluster_identifier
    )
    return response['DBClusters'][0]['TagList']
