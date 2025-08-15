from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType

spark = SparkSession.builder.getOrCreate()

schema = StructType([
    StructField('Date', StringType(), True), 
    StructField('Subtype', StringType(), True), 
    StructField('PurchaseMethod', StringType(), True),
    StructField('Out', StringType(), True)
])

dfs = spark.readStream.option("header", "true").schema(schema).format("csv").load("Files/Shop*.csv")
deltaTablePath = "Tables/Shop_table"
query = dfs.writeStream.format("delta").outputMode("append") \
           .option("checkpointLocation", deltaTablePath + '/_checkpoint') \
           .option("path", deltaTablePath).start()
query.awaitTermination()