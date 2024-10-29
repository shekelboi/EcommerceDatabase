"""
Uploads the images in the product_images folder to S3 with the appropriate public_id.
Product images must be stored in a {PRODUCT_ID}_{SEQUENCE}.jpg format in the folder.
"""
import os
import psycopg2
import boto3

password = input('Enter password: ')

# Empty bucket
s3 = boto3.resource('s3')
bucket = s3.Bucket('ecommerce420')
bucket.objects.all().delete()

# Upload blank image
bucket.upload_file('product_images/special/blank.jpg', 'blank.jpg')

connection = psycopg2.connect(dbname='ecommerce', user='shopadmin', password=password)
connection.set_session(autocommit=True)

images = os.listdir('product_images')

with connection.cursor() as cursor:
    cursor.execute("delete from image;")

for img in images:
    if img == 'special':
        continue
    product_id = img.split('_')[0]
    with connection.cursor() as cursor:
        cursor.execute("select generate_unique_base_32('image', 'public_id', 20);")
        public_id = cursor.fetchone()[0]
        bucket.upload_file(f'product_images/{img}', f'{public_id}.jpg')
        print(f'Uploading image ({public_id}) for product with id: {product_id}')
        cursor.execute(f"insert into image(product_id, public_id) values({product_id}, '{public_id}');")
