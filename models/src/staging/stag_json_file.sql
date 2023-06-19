{{ flatten_json(
   modelname= source('RAW_DEV', 'MYJSONTABLE'),
   json_column= 'JSON_DATA'
  )}}

