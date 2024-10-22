# README
 

* API Schema:

* 'api/v1/create_sensor_data' requires contextMap with [name location device location_max_capacity] string fields
* 'api/v1/read_sensor_data' requires _id and optional [start_date end_date] fields. If dates are not provided - all sensor data will be returned
* .ENV file should contain SENSORS_API_TOKEN and HOST_ADDRESS values
