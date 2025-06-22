# AWS SimuLearn: Cloud Computing Essentials

## Simulated business scenario

The city's web portal team wants a solution that will make their beach wave size prediction webpage more reliable.

## Solution 1

[aws s3](https://aws.amazon.com/s3/)

1. Amazon Simple Storage Service (Amazon S3) can be used to store any type of data, and retrieve any amount of data from anywhere.
2. In Amazon S3, any type of file, and any metadata that describes that file, is called an object. Objects are stored in S3 containers, called buckets.
3. This solution uses an S3 bucket to host a static website. In Amazon S3, the static website can sustain any conceivable level of traffic, at a very modest cost, without the need to set up, monitor, scale, or manage any web servers.
4. Along with an HTML file, files that support webpage functionality, such as client-side scripts and style sheets, are uploaded to the S3 bucket. Any S3 bucket can be configured to host a static website.
5. When an S3 bucket is configured for website hosting, the bucket is assigned a URL. When requests are made to this URL, Amazon S3 returns the HTML file, known as the root object, that was set for the bucket.
6. For others to access the S3 bucket, or specific objects in it, permissions must be configured to allow that access. A bucket policy can be created to configure these permissions.
7. A bucket policy defines who can access the bucket and what type of operations can be performed. Bucket policies are written in JSON format.
8. JSON is a human- and computer-readable format used to store and retrieve data. JSON is used by many applications and throughout AWS.
9. City residents visit the city web portal for beach wave information, which invokes a GET request from the portal to the URL of the static webpage. The initial root object is named index.html.
10. The index.html root object in the S3 bucket can be renamed waves.html. The S3 bucket settings can be updated to use the renamed root object.

## Solution Techinal

1. login to s3 service
2. go to s3/buckets
3. choose the bucket you have for static site
4. properties tab scroll to bottom and assign S3 static website hosting
Enabled in the Static website hosting
5. assign you index.html  
6. web url is generated

## insteresting

[aws Marketplace](https://aws.amazon.com/marketplace)
[aws Partner Network](https://aws.amazon.com/partners/)
[AWS Well-Architected Tool](https://aws.amazon.com/well-architected-tool/) (Any usage free)
