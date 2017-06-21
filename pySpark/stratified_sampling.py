# Configure context to access S3
sc._jsc.hadoopConfiguration().set('fs.s3n.awsAccessKeyId', 'AKIAIPWWBV7EZHFTQRKQ')
sc._jsc.hadoopConfiguration().set('fs.s3n.awsSecretAccessKey', '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')
news = sqlContext.read.json("s3://newsclustering/webhose-monthly-gz/*.json.gz")

# Stratified sampling of the different domains
cc = news.groupBy('thread.site').count().collect()
sample_count = 2000
frac = dict((e['site'], min(1, sample_count / float(e['count']))) for e in cc)
sampled = news.sampleBy('thread.site', fractions=frac)

# Verify that we roughly have the same number of articles per domain
sampled.rdd.map(lambda x: x['thread']['site']).countByValue()

# Save subsampled dataset to s3
sampled.write.mode('append').json("s3://newsclustering/stratified-sample")
