import pandas as pd

# load data
df = pd.read_csv("ecommerce.csv")

# show data
df.head()

# remove duplicates
df.drop_duplicates(inplace=True)

# convert timestamp to proper format
df['timestamp'] = pd.to_datetime(df['timestamp'])

# check data types
print(df.dtypes)

# count each event
df['event'].value_counts()

df['user_id'].nunique()

funnel = df.groupby('event')['user_id'].nunique()
print(funnel)

df.to_csv("cleaned_ecommerce.csv", index=False)
